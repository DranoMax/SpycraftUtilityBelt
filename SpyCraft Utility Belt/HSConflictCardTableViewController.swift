//
//  HSConflictCardTableViewController.swift
//  SpyCraft Utility Belt
//
//  Created by Alexander Scoggins on 10/16/16.
//  Copyright © 2016 Alexander Scroggins. All rights reserved.
//

import UIKit
import CoreData

public enum CrisisCardType: String {
    case kBrainWashing  = "BRAINWASHING"
    case kChase = "CHASE"
    case kHacking = "HACKING"
    case kInfiltration = "INFILTRATION"
    case kInterrogation = "INTERROGATION"
    case kManhunt = "MANHUNT"
    case kSeduction = "SEDUCTION"
    case kAll = "ALL"
}

class HSConflictCardTableViewController: UITableViewController {
    
    var tableSource: [CrisisCard]!
    
    // The Crisis Type to show chose from the enum above
    var selectedCrisisType: CrisisCardType?
    
    // Padding and other table values
    let kCellHeight: CGFloat = 100.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let title = self.selectedCrisisType?.rawValue {
            self.title = title
        }
        // Load our database stuff
        self.loadCards()
        self.sortCardsAlphabetically(array: self.tableSource)
        self.tableView.register(HSCrisisCardCell.self, forCellReuseIdentifier: "crisisCardCell")
        
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(back))
        self.navigationItem.leftBarButtonItem = newBackButton
    }
    
    private func loadCards() {
        let moc = HSDatabaseManager.sharedInstance.mob
        do {
            // Create a new predicate that filters out any object that
            // doesn't have a title of "Best Language" exactly.
            if let type = self.selectedCrisisType?.rawValue {
                let predicate = NSPredicate(format: "crisistype == %@", type)
                let crisisCardFetchRequest: NSFetchRequest<CrisisCard> = CrisisCard.fetchRequest()
                crisisCardFetchRequest.predicate = predicate
                
                self.tableSource = try moc.fetch(crisisCardFetchRequest)
            }
        } catch {
            fatalError("Failed to fetch employees: \(error)")
        }
    }
    
    private func sortCardsAlphabetically(array: [CrisisCard]!) {
        self.tableSource.sort { (card1: CrisisCard, card2: CrisisCard) -> Bool in
            return card1.name < card2.name
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
        let crisisCard = tableSource[indexPath.row]
        
        if let viewCon = self.storyboard?.instantiateViewController(withIdentifier: "CrisisDetailTable") as? HSCrisisCardDetailTableViewContoller {
            viewCon.crisisCard = crisisCard
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kCellHeight;
    }
    
    func back(sender: UIBarButtonItem) {
        // Perform your custom actions
        // ...
        // Go back to the previous ViewController
        self.navigationController?.popViewController(animated: true)
    }
    
}
