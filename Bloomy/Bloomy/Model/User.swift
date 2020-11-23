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
    
    //create
    public func newUser(withName name: String) -> User? {
        
        let userObject = NSEntityDescription.insertNewObject(forEntityName: "User", into: coreDataContext)
        
        guard let user = userObject as? User else {fatalError("Could not find User Entity")}
        user.name = name
        return self.saveContext() ? user : nil
    }
    
    //read
    private func getUser() -> User? {
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
    
    //update
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
    
    //delete
    public func deleteUser(withName name: String) -> Bool {
        
        let fetchRequest = NSFetchRequest<User>(entityName: "User")
        
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
        do {
            let user = try coreDataContext.fetch(fetchRequest)
            
            if !user.isEmpty {
                coreDataContext.delete(user[0])
                return self.saveContext()
            } else {
                print("The user \(name) could not be found!")
            }
        } catch {
            print("Error deleting the user \(name)")
        }
        
        return false
    }
    
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
