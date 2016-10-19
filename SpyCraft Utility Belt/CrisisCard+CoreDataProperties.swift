//
//  CrisisCard+CoreDataProperties.swift
//  SpyCraft Utility Belt
//
//  Created by Alexander Scoggins on 10/18/16.
//  Copyright © 2016 Alexander Scroggins. All rights reserved.
//

import Foundation
import CoreData


extension CrisisCard {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CrisisCard> {
        return NSFetchRequest<CrisisCard>(entityName: "CrisisCard");
    }

    @NSManaged public var name: String?
    @NSManaged public var desc: String?
    @NSManaged public var strategy: String?
    @NSManaged public var skill: String?
    @NSManaged public var requirements: String?
    @NSManaged public var advantages: String?
    @NSManaged public var skillmod: Int16
    @NSManaged public var crisistype: Int16

}
