//
//  DailyMissions.swift
//  Bloomie
//
//  Created by Wilton Ramos on 12/04/21.
//

import Foundation

struct DailyMissionsManager {
    static let shared = DailyMissionsManager()
    
    let userManager = UserManager.shared
    let islandsManager = IslandManager.shared
    let islands = UserManager.shared.getIslands()
    
    // MARK: - Public
    
    /// Updates the daily mission for a given island
    /// - Parameter islandName: String representing the island's name
    /// - Returns: The last daily challenge for that island
    public func updateDailyMission(forIsland islandName: String) -> Challenge? {
        let island = self.islandsManager.getIsland(withName: islandName)
        let lastDailyChallenge = island?.dailyChallenge
        self.islandsManager.setLastDailyChallenge(forIsland: island!.name! , toChallenge: lastDailyChallenge)
        
        if let newDailyChallenge = self.getAvailableChallenge(forIsland: islandName) {
            newDailyChallenge.dateAsDaily = Date()
            _ = self.islandsManager.updateDailyChallenge(forIsland: islandName, toChallenge: newDailyChallenge)
        } else if (self.refreshDoneStatus(forIsland: islandName)) {
            let newDailyChallenge = self.getAvailableChallenge(forIsland: islandName)
            newDailyChallenge?.dateAsDaily = Date()
            _ = self.islandsManager.updateDailyChallenge(forIsland: islandName, toChallenge: newDailyChallenge!)
        } else {
            // Fazer algo para caso não tenha mais missão
            return nil
        }
        
        return lastDailyChallenge
    }
    
    /// Set to true the done attribute for the challenge and set the time attribute of this challenge to the actual date
    /// - Parameter forChallenge: Challenge that will be modified
    public func setDoneStatus(forChallenge challenge: Challenge?) {
        challenge?.done = true
        challenge?.time = Date()
        _ = ChallengeManager.shared.saveContext()
    }

    /// Muda o status de done para os desafios que foram aceitos mas não foram concluídos
    /// - Parameter withName: String com o nome da ilha
    /// - Returns: Bool que indica se alguma ilha mudou o status
    private func refreshDoneStatus(forIsland withName: String) -> Bool {
        var thereIsUndoneChallenge = false
        guard let islandChallenges = IslandManager.shared.getChallenges(fromIsland: withName) else { return false}
        for challenge in islandChallenges where challenge.accepted && !challenge.done {
            thereIsUndoneChallenge = true
            challenge.accepted = false
        }
        return thereIsUndoneChallenge
    }
    
    private func getAvailableChallenge(forIsland islandName: String) -> Challenge? {
        let islandChallenges = islandsManager.getChallenges(fromIsland: islandName)!
        var challengesCount = islandChallenges.count //Auxiliar para garantir saída do while
        var randomIndex = getRandomNumber(maximum: challengesCount)
        
        while (islandChallenges[randomIndex].accepted && challengesCount > 0) {
            challengesCount -= 1
            randomIndex = (randomIndex + 1) % islandChallenges.count
        }
        
        if (!islandChallenges[randomIndex].accepted) {
            return islandChallenges[randomIndex]
        }
        
        return nil
    }
}
