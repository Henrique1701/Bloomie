//
//  User+CoreDataProperties.swift
//  Bloomy
//
//  Created by Mayara Mendonça de Souza on 24/11/20.
//
//

import Foundation
import CoreData

extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var image: Data?
    @NSManaged public var name: String?
    @NSManaged public var userToIsland: NSSet?
    @NSManaged public var lastSeen: Date?
    @NSManaged public var dailyChallenges: NSSet?

}

// MARK: Generated accessors for userToIsland
extension User {

    @objc(addUserToIslandObject:)
    @NSManaged public func addToUserToIsland(_ value: Island)

    @objc(removeUserToIslandObject:)
    @NSManaged public func removeFromUserToIsland(_ value: Island)

    @objc(addUserToIsland:)
    @NSManaged public func addToUserToIsland(_ values: NSSet)

    @objc(removeUserToIsland:)
    @NSManaged public func removeFromUserToIsland(_ values: NSSet)

}

extension User : Identifiable {

}
