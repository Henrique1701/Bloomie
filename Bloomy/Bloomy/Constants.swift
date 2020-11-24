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
