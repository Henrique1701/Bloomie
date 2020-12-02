//
//  User.swift
//  Bloomy
//
//  Created by Wilton Ramos on 19/11/20.
//

import CoreData
import UIKit

struct UserManager {
    static let shared = UserManager()
    static var user: User?
    
    // MARK: Create
    public func newUser(withName name: String) -> User? {
        let userObject = NSEntityDescription.insertNewObject(forEntityName: "User", into: coreDataContext)
        
        guard let user = userObject as? User else {fatalError("Could not find User Entity")}
        user.name = name
        
        return self.saveContext() ? user : nil
    }
    
    // MARK: Read
    public func getUser() -> User? {
        let fetchRequest = NSFetchRequest<User>(entityName: "User")
        fetchRequest.fetchLimit = 1
        
        do {
            let user = try coreDataContext.fetch(fetchRequest)
            if !user.isEmpty { return user[0] }
        } catch let error {
            print("We couldn't find the user. \n \(error)")
        }
        
        return nil
    }
    
    public func getUserName() -> String? {
        guard let user = getUser() else {fatalError("Could not find User")}
        guard let userName = user.name else {fatalError("Could not find User's name")}
        return userName
    }
    
    public func getUserImage() -> UIImage? {
        guard let user = getUser() else {fatalError("Could not find User")}
        if let userImage = UIImage(data: user.image!) {
            return userImage
        }
        return nil
    }
    
    public func getIslands() -> [Island]? {
        let user = getUser()
        let islands = user!.userToIsland
        let islandsArray = islands?.allObjects as? [Island] ?? []
        return islandsArray
    }
    
    public func getLastSeen() -> Date? {
        guard let user = getUser() else {fatalError("Could not find User")}
        if let lastSeen = user.lastSeen {
            return lastSeen
        }
        return nil
    }
    
    public func getDailyChallenges() -> [Challenge]? {
        guard let user = getUser() else {fatalError("Could not find User")}
        if let dailyChallenges = user.dailyChallenges {
            let dailyChallengesArray = dailyChallenges.allObjects as? [Challenge] ?? []
            return dailyChallengesArray
        }
        return []
    }
    
    // MARK: Update
    public func updateUserName(to name: String) -> Bool {
        guard let user = getUser() else {fatalError("Could not find User")}
        user.name = name
        
        return self.saveContext()
    }
    
    public func updateUserImage(to image: UIImage) -> Bool {
        guard let user = getUser() else {fatalError("Could not find User")}
        if let data = image.pngData() {
            user.image = data
            return self.saveContext()
        }
        return false
    }
    
    public func updateLastSeen(to date: Date) -> Bool {
        guard let user = getUser() else {fatalError("Could not find User")}
        user.lastSeen = date
        
        return self.saveContext()
    }
    
    public func updateDailyChallenges(to challenges: NSSet) -> Bool {
        guard let user = getUser() else {fatalError("Could not find User")}
        user.dailyChallenges = challenges
        
        return saveContext()
    }
    
    // MARK: Delete
    public func deleteUser() -> Bool {
        guard let user = getUser() else { fatalError("Coud not find User") }
        coreDataContext.delete(user)
        return self.saveContext()
    }
    
    // MARK: Auxiliar
    private func saveContext() -> Bool {
        do {
            try coreDataContext.save()
            return true
        } catch let error {
            print("Sorry, we can't save the user. Try again later. \n \(error)")
        }
        
        return false
    }
}
