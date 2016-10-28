//
//  HSelectronicGearDetailTableViewContoller.swift
//  SpyCraft Utility Belt
//
//  Created by Alexander Scoggins on 10/21/16.
//  Copyright © 2016 Alexander Scroggins. All rights reserved.
//

import UIKit

class HSElectronicsGearDetailTableViewController: UITableViewController {
    
    var standardGear: StandardGearModels?
    
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
        if let name = self.standardGear?.name {
            self.title = name
        }
        if let caliber = self.standardGear?.caliber {
            self.caliberLabel.text = caliber
        }
        if let powerRating = self.standardGear?.powerRating {
            self.powerRatingLabel.text = powerRating
        }
        if let resultCapMod = self.standardGear?.resultCapMod {
            self.resultCapLabel.text = resultCapMod
        }
        if let range = self.standardGear?.range {
            self.rangeLabel.text = range
        }
        if let sizeHand = self.standardGear?.sizeHand {
            self.sizeHandLabel.text = sizeHand
        }
        if let battery = self.standardGear?.battery {
            self.batteryLabel.text = battery
        }
        if let save = self.standardGear?.save {
            self.saveLabel.text = save
        }
        if let weight = self.standardGear?.weight {
            self.weightLabel.text = weight
        }
        if let complexity = self.standardGear?.complexity {
            self.complexityLabel.text = complexity
        }
        if let year = self.standardGear?.year {
            self.yearLabel.text = year
        }
        if let streetValue = self.standardGear?.streetValue {
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
