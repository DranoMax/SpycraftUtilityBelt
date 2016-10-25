//
//  HSConflictCardTableViewController.swift
//  SpyCraft Utility Belt
//
//  Created by Alexander Scoggins on 10/16/16.
//  Copyright © 2016 Alexander Scroggins. All rights reserved.
//

import UIKit
import CoreData

class HSGearPickTableViewController: UITableViewController {
    
    var tableSource: [ElectronicsGear]!
    
    // Table Source sorted into Sections
    //    var sortedTableSource = [[CrisisCard]]()
    
    // The Crisis Type to show chose from the enum above
    //    var selectedCrisisType: CrisisCardType?
    
    // The names of the table headers
    //    var crisisStrategies = [String]()
    
    // Padding and other table values
    let kCellHeight: CGFloat = 110.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load our database stuff
        self.loadGearData()
        //        self.sortCardsAlphabetically(array: self.tableSource)
        //        self.getArrayOfStrategiesInCrisisType()
        //        self.getSectionRows()
        
        self.tableView.register(HSGearCell.self, forCellReuseIdentifier: "gearCell")
        
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(back))
        self.navigationItem.leftBarButtonItem = newBackButton
    }
    
    private func loadGearData() {
        let moc = HSDatabaseManager.sharedInstance.mob
        do {
            let electronicGearFetchRequest: NSFetchRequest<ElectronicsGear> = ElectronicsGear.fetchRequest()
            
            self.tableSource = try moc.fetch(electronicGearFetchRequest)
        } catch {
            fatalError("Failed to fetch employees: \(error)")
        }
    }
    
    private func sortCardsAlphabetically(array: [ElectronicsGear]!) {
        //        self.tableSource.sort { (card1: CrisisCard, card2: CrisisCard) -> Bool in
        //            return card1.name < card2.name
        //        }
    }
    
    // MARK: - UITableViewDelegate
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // If we have sorted Sections
        if self.tableSource.count > 0 {
            return self.tableSource.count
        }
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // If we have sorted Sections
        if self.tableSource.count > 0 {
            return tableSource.count
        }
        
        return self.tableSource.count
    }
    
    //    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //        if self.tableSource.count > 0 {
    //            return self.tableSource[section]
    //        }
    //
    //        return ""
    //    }
    //
    //    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    //        if self.tableSource.count > 0 {
    //            return 44
    //        }
    //
    //        return 0
    //    }
    //
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "gearCell", for: indexPath) as? HSGearCell {
            let gear = self.tableSource[indexPath.row]
            
            if let value = gear.name {
                cell.nameLabel.text = value
            }
            
            cell.descLabel.text =  gear.description
            
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let crisisCard = tableSource[indexPath.row]
//        
//        if let viewCon = self.storyboard?.instantiateViewController(withIdentifier: "CrisisDetailTable") as? HSCrisisCardDetailTableViewContoller {
//            viewCon.crisisCard = crisisCard
//            self.navigationController?.pushViewController(viewCon, animated: true)
//        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kCellHeight;
    }
    
    // MARK: - Gesture Recognizer
    
    func back(sender: UIBarButtonItem) {
        // Perform your custom actions
        // ...
        // Go back to the previous ViewController
        self.navigationController?.popViewController(animated: true)
    }
    
}
