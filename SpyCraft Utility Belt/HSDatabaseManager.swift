//
//  HSDatabaseManager.swift
//  SpyCraft Utility Belt
//
//  Created by Alexander Scoggins on 10/16/16.
//  Copyright © 2016 Alexander Scroggins. All rights reserved.
//

import Foundation
import CoreData

public class HSDatabaseManager: NSObject {
    static let sharedInstance = HSDatabaseManager()
    let mob: NSManagedObjectContext
    
    func createCrisisCardTableIfNeeded() {
        
    }
    
    func save() {
        do {
            try self.mob.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    }
    
    override init() {
        // This resource is the same name as your xcdatamodeld contained in your project.
        guard let modelURL = Bundle.main.url(forResource: "CrisisCardModel", withExtension:"momd") else {
            fatalError("Error loading model from bundle")
        }
        // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
        guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Error initializing mom from: \(modelURL)")
        }
        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
        self.mob = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        self.mob.persistentStoreCoordinator = psc
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docURL = urls[urls.endIndex-1]
        /* The directory the application uses to store the Core Data store file.
         This code uses a file named "DataModel.sqlite" in the application's documents directory.
         */
        let storeURL = docURL.appendingPathComponent("CrisisCardModel.sqlite")
        do {
            try psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
        } catch {
            fatalError("Error migrating store: \(error)")
        }
    }
}
