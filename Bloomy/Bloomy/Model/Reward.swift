//
//  Reward.swift
//  Bloomy
//
//  Created by Mayara Mendonça de Souza on 25/11/20.
//

import Foundation
import CoreData

struct RewardManager {
    static let shared = RewardManager()
    static var reward: Reward?
    // MARK: Create new Reward
    func newReward(withLocation location: String) -> Reward? {
        
        let rewardObject = NSEntityDescription.insertNewObject(forEntityName: "Reward", into: coreDataContext)
        
        guard let reward = rewardObject as? Reward else {
            fatalError("Could not find Reward Entity")
        }
        reward.location = location
        return self.save() ? reward : nil
    }

    // MARK: Read Rewards
    func getReward(withLocation location: String) -> Reward? {
        let fetchRequest = NSFetchRequest<Reward>(entityName: "Reward")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "location == %@", location)
        do {
            let reward = try coreDataContext.fetch(fetchRequest)
            if !reward.isEmpty { return reward[0] }
        } catch let error {
            print("We couldn't find the reward. \n \(error)")
        }
    
        return nil
    }
    
    func getRewards() -> [Reward]? {
        let fetchRequest = NSFetchRequest<Reward>(entityName: "Reward")

        do {
            let rewards = try coreDataContext.fetch(fetchRequest)
            return rewards
        } catch let fetchError {
            print("Failed to fetch Rewards: \(fetchError)")
        }

        return nil
    }
    
    func getRewardsLocation() {
        if let rewards = getRewards() {
            for reward in rewards {
                print(reward.location)
            }
        } else {
            print("Não encontrei a localização das recompensas")
        }
    }
    
    // MARK: Delete Reward
    func deleteIsland(withLocation location: String) -> Bool {
        
        let fetchRequest = NSFetchRequest<Reward>(entityName: "Reward")
        
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "location == %@", location)
        
        do {
            let reward = try coreDataContext.fetch(fetchRequest)
            
            if !reward.isEmpty {
                coreDataContext.delete(reward[0])
                return self.save()
            } else {
                print("The reward from the \(location) could not be found!")
            }
        } catch {
            print("Error deleting the reward \(location)")
        }
        
        return false
    }
    
    // Adicionar função SetIsland
    // MARK: Save
    private func save() -> Bool {
        
        do {
            try coreDataContext.save()
            return true
        } catch let error {
            print("Sorry, we can't save the reward. Try again later. \n \(error)")
        }
        
        return false
    }
}

