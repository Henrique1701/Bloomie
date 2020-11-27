//
//  Challenge.swift
//  Bloomy
//
//  Created by Wilton Ramos on 25/11/20.
//

import CoreData
import UIKit

struct ChallengeManager {
    static let shared = ChallengeManager()
    static var challenge: Challenge?
    
    // MARK: Create
    public func createChallenge(withID: String,withSummary summary: String) -> Challenge? {
        let userObject = NSEntityDescription.insertNewObject(forEntityName: "Challenge", into: coreDataContext)
        
        guard let challenge = userObject as? Challenge else {fatalError("Could not find Challenge Entity")}
        challenge.id = withID
        challenge.summary = summary
        
        return self.saveContext() ? challenge : nil
    }
    // MARK: Read
    public func getChallenges() -> [Challenge]? {
        let fetchRequest = NSFetchRequest<Challenge>(entityName: "Challenge")
        
        do {
            let challenges = try coreDataContext.fetch(fetchRequest)
            if !challenges.isEmpty { return challenges }
        } catch let error {
            print("We couldn't find the island. \n \(error)")
        }
        
        return nil
    }
    
    public func getChallenge(withID: String) -> Challenge? {
        let fetchRequest = NSFetchRequest<Challenge>(entityName: "Challenge")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "summary == %@", withID)
        
        do {
            let challenge = try coreDataContext.fetch(fetchRequest)
            if !challenge.isEmpty { return challenge[0]}
        } catch let error {
            print("We couldn't find the island. \n \(error)")
        }
        
        return nil
    }
    
    public func wasDone(challenge withID: String) -> Bool {
        if let challenge = getChallenge(withID: withID) {
            let wasDone = challenge.done
            return wasDone
        }
        
        return false
    }
    
    public func wasAccepted(challenge withID: String) -> Bool {
        if let challenge = getChallenge(withID: withID) {
            let wasAccepted = challenge.accepted
            return wasAccepted
        }
        
        return false
    }
    
    public func getSummary(forChallenge withID: String) -> String? {
        if let challenge = getChallenge(withID: withID) {
            let summary = challenge.summary
            return summary ?? nil
        } else {
            print("The \(withID) challenge has no summary description")
        }
        
        return nil
    }
    
    public func getTime(forChallenge withID: String) -> Date? {
        if let challenge = getChallenge(withID: withID) {
            let time = challenge.time
            return time ?? nil
        } else {
            print("The \(withID) challenge has no date")
        }
        
        return nil
    }
    
    //publicFunc
    // MARK: Update
    public func updateSummary(withID: String, to newSummary: String) -> Bool {
        guard let challenge = getChallenge(withID: withID) else { fatalError("Coud not find \(withID) Challenge") }
        challenge.summary = newSummary
        
        return self.saveContext()
    }
    
    public func updateAccepted(withID: String, to newValue: Bool) -> Bool {
        guard let challenge = getChallenge(withID: withID) else { fatalError("Coud not find \(withID) Challenge") }
        challenge.accepted = newValue
        
        return self.saveContext()
    }
    
    public func updateDone(withID: String, to newValue: Bool) -> Bool {
        guard let challenge = getChallenge(withID: withID) else { fatalError("Coud not find \(withID) Challenge") }
        challenge.done = newValue
        
        return self.saveContext()
    }
    
    public func updateTime(withID: String, to newDate: Date) -> Bool {
        guard let challenge = getChallenge(withID: withID) else { fatalError("Coud not find \(withID) Challenge") }
        challenge.time = newDate
        
        return self.saveContext()
    }
    
    public func setIsland(toChallenge withID: String, island: Island) -> Bool {
        guard let challenge = getChallenge(withID: withID) else { fatalError("Coud not find \(withID) Challenge") }
        challenge.challengeToIsland = island
        return saveContext()
    }
    
    // MARK: Delete
    public func deleteChallenge(withID: String) -> Bool {
        guard let challenge = getChallenge(withID: withID) else { fatalError("Coud not find \(withID) Challenge") }
        coreDataContext.delete(challenge)
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
