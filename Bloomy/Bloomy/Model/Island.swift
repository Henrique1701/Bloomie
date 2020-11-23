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
    
    //MARK: Create new Island
    func newIsland(withName name: String) -> Island? {
        
        let islandObject = NSEntityDescription.insertNewObject(forEntityName: "Island", into: coreDataContext)
        
        guard let island = islandObject as? Island else {
            fatalError("Could not find Island Entity")
        }
        island.name = name
        return self.save() ? island : nil
    }

    
    //MARK: Read Island
    func getIsland() -> Island? {
        let fetchRequest = NSFetchRequest<Island>(entityName: "Island")
        fetchRequest.fetchLimit = 1
        
        do {
            let island = try coreDataContext.fetch(fetchRequest)
            if !island.isEmpty { return island[0] }
        } catch let error {
            print("We couldn't find the island. \n \(error)")
        }
    
        return nil
    }
    
    func getIslands() -> [Island]? {
        let fetchRequest = NSFetchRequest<Island>(entityName: "Island")

        do {
            let islands = try coreDataContext.fetch(fetchRequest)
            return islands
        } catch let fetchError {
            print("Failed to fetch companies: \(fetchError)")
        }

        return nil
    }
    
    
    //MARK: Delete Island
    func deleteIsland(withName name: String) -> Bool {
        
        let fetchRequest = NSFetchRequest<Island>(entityName: "Island")
        
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
        do {
            let island = try coreDataContext.fetch(fetchRequest)
            
            if !island.isEmpty {
                coreDataContext.delete(island[0])
                return self.save()
            } else {
                print("The island \(name) could not be found!")
            }
        } catch {
            print("Error deleting the island \(name)")
        }
        
        return false
    }
    
    //MARK: Save 
    private func save() -> Bool {
        
        do {
            try coreDataContext.save()
            return true
        } catch let error {
            print("Sorry, we can't save the island. Try again later. \n \(error)")
        }
        
        return false
    }
}
