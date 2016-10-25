//
//  ElectronicsGear+CoreDataProperties.swift
//  
//
//  Created by Alexander Scoggins on 10/23/16.
//
//

import Foundation
import CoreData


extension ElectronicsGear {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ElectronicsGear> {
        return NSFetchRequest<ElectronicsGear>(entityName: "ElectronicsGear");
    }

    @NSManaged public var powerRating: String?
    @NSManaged public var resultCapMod: String?
    @NSManaged public var range: String?
    @NSManaged public var sizeHand: String?
    @NSManaged public var battery: String?
    @NSManaged public var save: String?
    @NSManaged public var weight: String?
    @NSManaged public var complexity: String?
    @NSManaged public var year: String?
    @NSManaged public var streetValue: String?
    @NSManaged public var name: String?
    @NSManaged public var caliber: String?

}
