//
//  StandardGearModels+CoreDataProperties.swift
//  
//
//  Created by Alexander Scoggins on 10/27/16.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension StandardGearModels {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StandardGearModels> {
        return NSFetchRequest<StandardGearModels>(entityName: "StandardGearModels");
    }

    @NSManaged public var battery: String?
    @NSManaged public var caliber: String?
    @NSManaged public var complexity: String?
    @NSManaged public var gearType: String?
    @NSManaged public var name: String?
    @NSManaged public var powerRating: String?
    @NSManaged public var range: String?
    @NSManaged public var resultCapMod: String?
    @NSManaged public var save: String?
    @NSManaged public var sizeHand: String?
    @NSManaged public var streetValue: String?
    @NSManaged public var weight: String?
    @NSManaged public var year: String?

}
