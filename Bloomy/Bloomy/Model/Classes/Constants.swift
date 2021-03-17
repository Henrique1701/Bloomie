//
//  Constants.swift
//  Bloomy
//
//  Created by Wilton Ramos on 19/11/20.
//

import UIKit
import CoreData

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
}

enum DefaultsConstants: String {
    case auxiliarToRootWindow = "userSelectedIslands"
}
