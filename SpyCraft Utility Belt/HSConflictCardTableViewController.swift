//
//  HSConflictCardTableViewController.swift
//  SpyCraft Utility Belt
//
//  Created by Alexander Scoggins on 10/16/16.
//  Copyright © 2016 Alexander Scroggins. All rights reserved.
//

import UIKit
import CoreData

class HSConflictCardTableViewcontroller: UITableViewController {
    
    enum CrisisCardType: Int {
        case kBrainWasing  = 0
        case kChase = 1
        case kHacking = 2
        case kInfiltration = 3
        case kInterrogation = 4
        case kManhunt = 5
        case kSeduction = 6
    }
    
    override func viewDidLoad() {
        // Load our database stuff
        self.loadCards()
    }
    
    private func loadCards() {
        let mob = HSDatabaseManager.sharedInstance.mob
        
        let entity = NSEntityDescription.entity(forEntityName: "CrisisCard", in: mob)
        let card = NSManagedObject(entity: entity!, insertInto: mob) as! CrisisCard
        
        card.name = "Test"
        HSDatabaseManager.sharedInstance.save()
    }
    
    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        super.tableView(tableView, numberOfRowsInSection: section)
//        return 0
//        
//    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        return nil
//    }
//    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        //
//    }

}
