//
//  HSAllGearPickerTableViewController.swift
//  SpyCraft Utility Belt
//
//  Created by Alexander Scoggins on 10/26/16.
//  Copyright © 2016 Alexander Scroggins. All rights reserved.
//

import UIKit
import CoreData

class HSAllGearPickerTableViewController: UITableViewController {
    
    var tableSource = [String]()
    
    // Padding and other table values
    let kCellHeight: CGFloat = 110.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Gear"
        self.buildRows()
        self.tableView.register(HSSingleLineCell.self, forCellReuseIdentifier: "singleLineCell")
    }
    
    private func buildRows() {
        self.tableSource.append("Electronic Picks")
        self.tableSource.append("Gadget Mechanism")
        self.tableSource.append("Security Picks")
        self.tableSource.append("Tradecraft Picks")
    }
    
    // MARK: - UITableViewDelegate
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableSource.count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "singleLineCell", for: indexPath) as? HSSingleLineCell {
            
            cell.nameLabel.text = tableSource[indexPath.row]
            
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let viewCon = storyboard.instantiateViewController(withIdentifier: "IndividualGearTable") as? HSIndividualGearPickTableViewController {
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kCellHeight;
    }
}
