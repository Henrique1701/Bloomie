//
//  Constants.swift
//  Bloomy
//
//  Created by Wilton Ramos on 19/11/20.
//

import UIKit
import CoreData

let userDefaults = UserDefaults.standard

let coreDataContext: NSManagedObjectContext = {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
        fatalError("")
    }
    
    let context = appDelegate.persistentContainer.viewContext
    
    return context
}()

enum IslandsNames: String {
    case mindfulness = "Atenção Plena"
    case health      = "Saúde"
    case loveds      = "Pessoas Queridas"
    case leisure     = "Lazer"
}

extension Notification.Name {
    static let acceptChallenge = Notification.Name("acceptChallenge")
    static let doneChallenge = Notification.Name("doneChallenge")
    static let islandsChange = Notification.Name("islandsChange")
    static let callHome = Notification.Name("callHome")
    static let delayedMissionToIslands = Notification.Name("rewardsDelayedMission")
}

class UserDefaultsKeys {
    
    class var userSelectedIslands: String {
        return "userSelectedIslands"
    }
    
    class var userDaysOfActivation: String {
        return "userDaysOfActivation"
    }
    
    class var reviewPrompted: String {
        return "reviewPrompted"
    }
    
    class var quantityIslands: String {
        return "quantityIslands"
    }
    
    class var stateSoundsSwitch: String {
        return "stateSoundsSwitch"
    }
    
    class var selectedMindfulness: String {
        return "selectedMindfulness"
    }
    
    class var selectedLeisure: String {
        return "selectedLeisure"
    }
    
    class var selectedHealth: String {
        return "selectedHealth"
    }
    
    class var selectedLoveds: String {
        return "selectedLoveds"
    }
    
    class var islandsChange: String {
        return "islandsChange"
    }
    
    class var dateWasAccepted: String {
        return "dateWasAccepted"
    }
    
}

func getRandomNumber(maximum: Int) -> Int {
    let randomInt = Int.random(in: 0..<maximum)
    return randomInt
}

func isSameDay(firstDate: Date, secondDate: Date) -> Bool {
    let calendar = Calendar.current
    let firstDateMidnight = calendar.startOfDay(for: firstDate)
    let secondDateMidnight = calendar.startOfDay(for: secondDate)
    let diff = calendar.dateComponents([.day], from: firstDateMidnight, to: secondDateMidnight)
    
    if diff.day == 0 {
        return true
    }

    return false
}
