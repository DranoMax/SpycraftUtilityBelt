//
//  HSCrisisCardDetailTableViewContoller.swift
//  SpyCraft Utility Belt
//
//  Created by Alexander Scoggins on 10/21/16.
//  Copyright © 2016 Alexander Scroggins. All rights reserved.
//

import UIKit

class HSCrisisCardDetailTableViewContoller: UITableViewController {
    
    var crisisCard: CrisisCard?
    
    // Label Outlets
    @IBOutlet weak var strategyLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var skillLabel: UILabel!
    @IBOutlet weak var requirementsLabel: UILabel!
    @IBOutlet weak var skillCheckModLabel: UILabel!
    @IBOutlet weak var specialTextView: UITextView!
    @IBOutlet weak var detailsTextView: UITextView!
    @IBOutlet weak var advantagesTextView: UITextView!
    
    // Special Section and rows
    let kStatsSectionHeader = 0
    let kDurationRow = 1
    
    let kSpecialSectionHeader = 1
    let kSpecialRow = 0
    let kDetailsRow = 1
    
    // Advantages Section and rows
    let kAdvantagesSectionHeader = 2
    
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupLabels()
    }
    
    // MARK: - Private Methods
    
    private func setupLabels() {
        if let name = self.crisisCard?.name {
            self.title = name
        }
        if let strategy = self.crisisCard?.getCleanedStrategy() {
            self.strategyLabel.text = strategy
        }
        if let skill = self.crisisCard?.getCleanedSkill() {
            self.skillLabel.text = skill
        }
        if let reqs = self.crisisCard?.getCleanedRequirements() {
            self.requirementsLabel.text = reqs
        }
        if let skillmod = self.crisisCard?.getCleanedSkillMod() {
            self.skillCheckModLabel.text = skillmod
        }
        if let special = self.crisisCard?.special {
            self.specialTextView.text = special
        }
        if let desc = self.crisisCard?.desc {
            self.detailsTextView.font = UIFont(name: "HelveticaNeue-Italic", size: 14)
            self.detailsTextView.text = desc
        }
        if let advantages = self.crisisCard?.advantages {
            self.advantagesTextView.text = advantages
        }
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        // Hide Special Header if there is no special value
        if section == kSpecialSectionHeader && self.specialTextView.text == "" {
            return 0
        }
        
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case kStatsSectionHeader:
            if indexPath.row == kDurationRow && self.durationLabel.text == "-" {
                return 0
            }
        case kSpecialSectionHeader:
            switch indexPath.row {
            case kSpecialRow:
                if self.specialTextView.text == "" {
                    return 0
                } else {
                    return 88
                }
            case kDetailsRow:
                if self.detailsTextView.text == "" {
                    return 0
                } else {
                    return 88
                }
            default:
                return 44
            }
        case kAdvantagesSectionHeader:
            return 300
        default:
            return 44
        }
        
        return 44
    }
}
