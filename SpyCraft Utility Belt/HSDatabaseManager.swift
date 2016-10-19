//
//  HSDatabaseManager.swift
//  SpyCraft Utility Belt
//
//  Created by Alexander Scoggins on 10/16/16.
//  Copyright © 2016 Alexander Scroggins. All rights reserved.
//

import Foundation
import SQLite

public class HSDatabaseManager {
    public let sharedInstance = HSDatabaseManager()
    public let db: Connection!
    
    public init() {
        do {
            db = try Connection("db.sqlite3")
        } catch {
            print("Couldn't create database...")
            db = nil
        }
    }
    
}
