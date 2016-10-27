//
//  HSConflictCardTableViewController.swift
//  SpyCraft Utility Belt
//
//  Created by Alexander Scoggins on 10/16/16.
//  Copyright © 2016 Alexander Scroggins. All rights reserved.
//

import UIKit
import CoreData

class HSIndividualGearPickTableViewController: UITableViewController {
    
    var tableSource: [ElectronicsGear]!
    
    // Table Source sorted into Sections
    var sortedTableSource = [[ElectronicsGear]]()
    
    // The Crisis Type to show chose from the enum above
    //    var selectedCrisisType: CrisisCardType?
    
    // The names of the table headers
    var caliberSections = [String]()
    
    // Padding and other table values
    let kCellHeight: CGFloat = 110.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load our database stuff
        self.loadGearData()
        self.sortCardsAlphabetically(array: self.tableSource)
        self.getArrayOfCalibers()
        self.getSectionRows()
        
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
            fatalError("Failed to fetch gear: \(error)")
        }
    }
    
    private func sortCardsAlphabetically(array: [ElectronicsGear]!) {
        self.tableSource.sort { (card1: ElectronicsGear, card2: ElectronicsGear) -> Bool in
            return card1.name < card2.name
        }
    }
    
    private func getArrayOfCalibers() {
//        for i in 0..<self.tableSource.count {
//            let results = self.caliberSections.filter({ (strategy: String) -> Bool in
//                return (strategy == self.tableSource[i].caliber)
//            })
//            if (results.count == 0) {
//                self.caliberSections.append(self.tableSource[i].caliber)
//            }
//        }

        self.caliberSections.append("Caliber I")
        self.caliberSections.append("Caliber II")
        self.caliberSections.append("Caliber III")
        self.caliberSections.append("Caliber IV")
        self.caliberSections.append("Caliber V")
        self.caliberSections.append("Reputation/Net Worth Only")
        
        // Init our arrayOfSections
        for _ in 0..<self.caliberSections.count {
            self.sortedTableSource.append([ElectronicsGear]())
        }
    }
    
    private func getSectionRows() {
        // Look at each card in our table
        for i in 0..<self.tableSource.count {
            for x in 0..<self.caliberSections.count {
                if self.tableSource[i].caliber == self.caliberSections[x] {
                    self.sortedTableSource[x].append((self.tableSource[i]))
                }
            }
        }
    }
    
    // MARK: - UITableViewDelegate
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // If we have sorted Sections
        if self.caliberSections.count > 0 {
            return self.caliberSections.count
        }
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // If we have sorted Sections
        if self.sortedTableSource.count > 0 {
            return sortedTableSource[section].count
        }
        
        return self.tableSource.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if self.caliberSections.count > 0 {
            return self.caliberSections[section]
        }
        
        return ""
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if self.caliberSections.count > 0 {
            return 44
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "gearCell", for: indexPath) as? HSGearCell {
            var gear: ElectronicsGear!
            
            // If we have sorted Sections
            if self.sortedTableSource.count > 0 {
                gear = self.sortedTableSource[indexPath.section][indexPath.row]
            } else {
                gear = self.tableSource[indexPath.row]
            }
            
            if let value = gear.name {
                cell.nameLabel.text = value
            }
            
            cell.descLabel.text =  ""
            
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var gear: ElectronicsGear!
        
        // If we have sorted Sections
        if self.sortedTableSource.count > 0 {
            gear = self.sortedTableSource[indexPath.section][indexPath.row]
        } else {
            gear = self.tableSource[indexPath.row]
        }
        
        if let viewCon = self.storyboard?.instantiateViewController(withIdentifier: "ElectronicsGearDetailTable") as? HSElectronicsGearDetailTableViewController {
            viewCon.electronicGear = gear
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
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
