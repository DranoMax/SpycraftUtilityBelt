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
    
    var tableSource: [CrisisCard]!
    
    // Padding and other table values
    let kCellHeight: CGFloat = 92.0
    
    override func viewDidLoad() {
        // Load our database stuff
        self.loadCards()
        self.tableView.register(HSCrisisCardCell.self, forCellReuseIdentifier: "crisisCardCell")
    }
    
    private func loadCards() {
        let moc = HSDatabaseManager.sharedInstance.mob
        do {
            let crisisCardFetchRequest: NSFetchRequest<CrisisCard> = CrisisCard.fetchRequest()
            self.tableSource = try moc.fetch(crisisCardFetchRequest)
        } catch {
            fatalError("Failed to fetch employees: \(error)")
        }
    }
    
    // MARK: - UITableViewDelegate
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        super.tableView(tableView, numberOfRowsInSection: section)
        return self.tableSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "crisisCardCell", for: indexPath) as? HSCrisisCardCell {
            let card = self.tableSource[indexPath.row]
            
            if let value = card.name {
                cell.nameLabel.text = value
            }
            if let value = card.desc {
                cell.descLabel.text = value
            }
            
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kCellHeight;
    }
    
}
