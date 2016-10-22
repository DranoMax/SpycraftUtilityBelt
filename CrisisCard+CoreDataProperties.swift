//
//  CrisisCard+CoreDataProperties.swift
//  
//
//  Created by Alexander Scoggins on 10/21/16.
//
//

import Foundation
import CoreData


extension CrisisCard {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CrisisCard> {
        return NSFetchRequest<CrisisCard>(entityName: "CrisisCard");
    }

    @NSManaged public var advantages: String?
    @NSManaged public var crisistype: String?
    @NSManaged public var desc: String?
    @NSManaged public var duration: String?
    @NSManaged public var name: String!
    @NSManaged public var requirements: String?
    @NSManaged public var skill: String?
    @NSManaged public var skillmod: String?
    @NSManaged public var strategy: String!
    @NSManaged public var special: String?

}
