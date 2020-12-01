//
//  File.swift
//  Bloomy
//
//  Created by Mayara Mendonça de Souza on 20/11/20.
//

import CoreData

struct IslandManager {
    static let shared = IslandManager()
    static var island: Island?
    // MARK: Create new Island
    public func newIsland(withName name: String) -> Island? {
        
        let islandObject = NSEntityDescription.insertNewObject(forEntityName: "Island", into: coreDataContext)
        
        guard let island = islandObject as? Island else {
            fatalError("Could not find Island Entity")
        }
        island.name = name
        return self.saveContext() ? island : nil
    }

    // MARK: Read Island
    public func getIsland(withName name: String) -> Island? {
        let fetchRequest = NSFetchRequest<Island>(entityName: "Island")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        do {
            let island = try coreDataContext.fetch(fetchRequest)
            if !island.isEmpty { return island[0] }
        } catch let error {
            print("We couldn't find the island. \n \(error)")
        }
    
        return nil
    }
    
    public func getIslands() -> [Island]? {
        let fetchRequest = NSFetchRequest<Island>(entityName: "Island")

        do {
            let islands = try coreDataContext.fetch(fetchRequest)
            if !islands.isEmpty { return islands }
        } catch let fetchError {
            print("Failed to fetch companies: \(fetchError)")
        }

        return nil
    }
    
    public func getIslandsNames() {
        if let islands = getIslands() {
            for island in islands {
                print(island.name ?? "")
            }
        }
    }
    
    public func getChallenges(fromIsland name: String) -> [Challenge]? {
        guard let island = self.getIsland(withName: name) else {fatalError("Could not find \(name) Island")}
        
        if let challenges = island.islandToChallenge {
            let challengesArray = challenges.allObjects as? [Challenge] ?? []
            return challengesArray
        }
        
        return []
    }
    
    // MARK: Delete Island
    public func deleteIsland(withName name: String) -> Bool {
        
        let fetchRequest = NSFetchRequest<Island>(entityName: "Island")
        
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
        do {
            let island = try coreDataContext.fetch(fetchRequest)
            
            if !island.isEmpty {
                coreDataContext.delete(island[0])
                return self.saveContext()
            } else {
                print("The island \(name) could not be found!")
            }
        } catch {
            print("Error deleting the island \(name)")
        }
        
        return false
    }
    
    // Relationship between user and islands
    public func setUser (islandName: String, user: User) -> Bool {
        let island = getIsland(withName: islandName)
        island?.islandToUser = user
        return saveContext()
    }
    
    // MARK: Save Context (auxiliar)
    private func saveContext() -> Bool {
        
        do {
            try coreDataContext.save()
            return true
        } catch let error {
            print("Sorry, we can't save the island. Try again later. \n \(error)")
        }
        
        return false
    }
}
