//
//  ElectronicsGear+CoreDataClass.swift
//
//
//  Created by Alexander Scoggins on 10/23/16.
//
//

import CoreData

public class ElectronicsGear: NSManagedObject {
    convenience init(context: NSManagedObjectContext!, name: String!, caliber: String!, powerRating: String?, resultCapMod: String?, range: String?, sizeHand: String?, battery: String?, save: String?, weight: String?, complexity: String?, year: String?, streetValue: String?) {
        let entity = NSEntityDescription.entity(forEntityName: "ElectronicsGear", in: context)
        self.init(entity: entity!, insertInto: context)
        
        self.name = name
        self.caliber = caliber
        self.powerRating = powerRating
        self.resultCapMod = resultCapMod
        self.range = range
        self.sizeHand = sizeHand
        self.battery = battery
        self.save = save
        self.weight = weight
        self.complexity = complexity
        self.year = year
        self.streetValue = streetValue
    }
}
