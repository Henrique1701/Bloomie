//
//  User+CoreDataProperties.swift
//  Bloomie
//
//  Created by Mayara Mendonça de Souza on 20/03/21.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var image: Data?
    @NSManaged public var lastSeen: Date?
    @NSManaged public var name: String?
    @NSManaged public var dailyChallenges: NSSet?
    @NSManaged public var userToIsland: NSSet?

}

// MARK: Generated accessors for dailyChallenges
extension User {

    @objc(addDailyChallengesObject:)
    @NSManaged public func addToDailyChallenges(_ value: Challenge)

    @objc(removeDailyChallengesObject:)
    @NSManaged public func removeFromDailyChallenges(_ value: Challenge)

    @objc(addDailyChallenges:)
    @NSManaged public func addToDailyChallenges(_ values: NSSet)

    @objc(removeDailyChallenges:)
    @NSManaged public func removeFromDailyChallenges(_ values: NSSet)

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
