//
//  User.swift
//  Bloomy
//
//  Created by Wilton Ramos on 19/11/20.
//

import CoreData

struct UserManager {
    static let shared = UserManager()
    static var user: User?
    
    //create
    func newUser(withName name: String) -> User? {
        
        let userObject = NSEntityDescription.insertNewObject(forEntityName: "User", into: coreDataContext)
        
        guard let user = userObject as? User else {
            fatalError("Could not find User Entity")
        }
        user.name = name
        return self.save() ? user : nil
    }
    //read
    func getUser() -> User? {
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
    //update
    func updateUserName(name: String) -> Bool {
        
        guard let user = getUser() else {
            fatalError("Could not find User \(name)")
        }
        user.name = name
        
        return self.save()
    }
    //delete
    func deleteUser(withName name: String) -> Bool {
        
        let fetchRequest = NSFetchRequest<User>(entityName: "User")
        
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
        do {
            let user = try coreDataContext.fetch(fetchRequest)
            
            if !user.isEmpty {
                coreDataContext.delete(user[0])
                return self.save()
            } else {
                print("The user \(name) could not be found!")
            }
        } catch {
            print("Error deleting the user \(name)")
        }
        
        return false
    }
    
    private func save() -> Bool {
        
        do {
            try coreDataContext.save()
            return true
        } catch let error {
            print("Sorry, we can't save the user. Try again later. \n \(error)")
        }
        
        return false
    }
}
