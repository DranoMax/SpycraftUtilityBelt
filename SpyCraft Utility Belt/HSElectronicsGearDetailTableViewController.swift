//
//  HSelectronicGearDetailTableViewContoller.swift
//  SpyCraft Utility Belt
//
//  Created by Alexander Scoggins on 10/21/16.
//  Copyright © 2016 Alexander Scroggins. All rights reserved.
//

import UIKit

class HSElectronicsGearDetailTableViewController: UITableViewController {
    
    var electronicGear: ElectronicsGear?
    
    // Label Outlets
    @IBOutlet weak var caliberLabel: UILabel!
    @IBOutlet weak var powerRatingLabel: UILabel!
    @IBOutlet weak var resultCapLabel: UILabel!
    @IBOutlet weak var rangeLabel: UILabel!
    @IBOutlet weak var sizeHandLabel: UILabel!
    @IBOutlet weak var batteryLabel: UILabel!
    @IBOutlet weak var saveLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var complexityLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var streetValueLabel: UILabel!
    
    
    // Special Section and rows
    let kStatsSectionHeader = 0
    let kDurationRow = 1
    let kSkillRow = 2
    
    let kSpecialSectionHeader = 1
    let kSpecialRow = 0
    let kDetailsRow = 1
    
    // Advantages Section and rows
    let kAdvantagesSectionHeader = 2
    
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLabels()
        self.tableView.allowsSelection = false
    }
    
    // MARK: - Private Methods
    
    private func setupLabels() {
        if let name = self.electronicGear?.name {
            self.title = name
        }
        if let caliber = self.electronicGear?.caliber {
            self.caliberLabel.text = caliber
        }
        if let powerRating = self.electronicGear?.powerRating {
            self.powerRatingLabel.text = powerRating
        }
        if let resultCapMod = self.electronicGear?.resultCapMod {
            self.resultCapLabel.text = resultCapMod
        }
        if let range = self.electronicGear?.range {
            self.rangeLabel.text = range
        }
        if let sizeHand = self.electronicGear?.sizeHand {
            self.sizeHandLabel.text = sizeHand
        }
        if let battery = self.electronicGear?.battery {
            self.batteryLabel.text = battery
        }
        if let save = self.electronicGear?.save {
            self.saveLabel.text = save
        }
        if let weight = self.electronicGear?.weight {
            self.weightLabel.text = weight
        }
        if let complexity = self.electronicGear?.complexity {
            self.complexityLabel.text = complexity
        }
        if let year = self.electronicGear?.year {
            self.yearLabel.text = year
        }
        if let streetValue = self.electronicGear?.streetValue {
            self.streetValueLabel.text = streetValue
        }
        
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
    }
    
//    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        // Hide Special Header if there is no special value
//        if section == kSpecialSectionHeader && self.specialTextView.text == "" {
//            return 0
//        }
//        
//        return UITableViewAutomaticDimension
//    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}
