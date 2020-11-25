//
//  Challenge.swift
//  Bloomy
//
//  Created by Wilton Ramos on 25/11/20.
//

import CoreData
import UIKit

struct ChallengeManager {
    static let shared = UserManager()
    static var challenge: Challenge?
    
    // MARK: Create
    public func createChallenge(withSummary summary: String) -> Challenge? {
        let userObject = NSEntityDescription.insertNewObject(forEntityName: "Challenge", into: coreDataContext)
        
        guard let challenge = userObject as? Challenge else {fatalError("Could not find Challenge Entity")}
        challenge.summary = summary
        
        return self.saveContext() ? challenge : nil
    }
    // MARK: Read
    // TODO: Acho que cada challenge precisa ter um ID
    public func getChallenges() -> [Challenge]? {
        let fetchRequest = NSFetchRequest<Challenge>(entityName: "Challenge")
        
        do {
            let challenges = try coreDataContext.fetch(fetchRequest)
            return challenges
        } catch let error {
            print("We couldn't find the island. \n \(error)")
            
            return nil
        }
    }
    
    public func getChallenge(withSummary summary: String) -> Challenge? {
        let fetchRequest = NSFetchRequest<Challenge>(entityName: "Challenge")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "summary == %@", summary)
        
        do {
            let challenge = try coreDataContext.fetch(fetchRequest)
            if !challenge.isEmpty { return challenge[0]}
        } catch let error {
            print("We couldn't find the island. \n \(error)")
        }
        
        return nil
    }
    
    public func wasDone(challenge withSummary: String) -> Bool {
        if let challenge = getChallenge(withSummary: withSummary) {
            let wasDone = challenge.done
            return wasDone
        }
        return false
    }
    
    public func wasAccepted(challenge withSummary: String) -> Bool {
        if let challenge = getChallenge(withSummary: withSummary) {
            let wasAccepted = challenge.accepted
            return wasAccepted
        }
        return false
    }
    
    //publicFunc
    // MARK: Update
    
    // MARK: Delete
    
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
