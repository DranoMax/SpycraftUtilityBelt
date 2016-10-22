//
//  FirstViewController.swift
//  SpyCraft Utility Belt
//
//  Created by Alexander Scroggins on 10/16/16.
//  Copyright © 2016 Alexander Scroggins. All rights reserved.
//

import UIKit
import FLKAutoLayout
import UIColor_Hex_Swift

class HSCrisisCardSetSelectionViewController: UIViewController {
    
    // Crisis Card Buttons
    // Tapping these takes us to a tableView of their respective cards
    var brainWashingButton = HSRoundedButton()
    var chaseButton = HSRoundedButton()
    var hackingButton = HSRoundedButton()
    var infiltrationButton = HSRoundedButton()
    var interrogationButton = HSRoundedButton()
    var manhuntButton = HSRoundedButton()
    var seductionButton = HSRoundedButton()
    
    // This is the container for our Crisis Card Buttons, used to center them in the view
    let buttonContainer = UIView()
    
    let numberOfButtonsPerRow: CGFloat = 2
    
    var buttonWidth: String!
    let buttonPadding: CGFloat = 16
    let buttonPaddingStr = "16"
    
    // Button tags
    let kBrainWashingTag = 0
    let kChaseTag = 1
    let kHackingTag = 2
    let kInfiltrationTag = 3
    let kInterrogationTag = 4
    let kManhuntTag = 5
    let kSeductionTag = 6
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Crisis Cards"
        let screenWidth = UIScreen.main.bounds.width
        // buttonPadding*4 comes from padding on the left and right of each button
        let totalHorBtnPad = buttonPadding * (numberOfButtonsPerRow * 2)
        self.buttonWidth = String.init(format: "%f", screenWidth / self.numberOfButtonsPerRow - totalHorBtnPad)
        
        self.setupCrisisTypeButtons()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func setupCrisisTypeButtons() {
        self.setButtonLabels()
        
        self.buildButtonsConstraints(buttonOne: self.brainWashingButton, buttonTwo: self.chaseButton)
        self.buildButtonsConstraints(buttonOne: self.hackingButton, buttonTwo: self.infiltrationButton)
        self.buildButtonsConstraints(buttonOne: self.interrogationButton, buttonTwo: self.manhuntButton)
        self.brainWashingButton.alignTopEdge(withView: self.view, predicate: self.buttonPaddingStr)
        self.chaseButton.alignTopEdge(withView: self.view, predicate: self.buttonPaddingStr)
        
        self.hackingButton.constrainTopSpace(toView: self.brainWashingButton, predicate: self.buttonPaddingStr)
        self.infiltrationButton.constrainTopSpace(toView: self.chaseButton, predicate: self.buttonPaddingStr)
        
        self.interrogationButton.constrainTopSpace(toView: self.hackingButton, predicate: self.buttonPaddingStr)
        self.manhuntButton.constrainTopSpace(toView: self.infiltrationButton, predicate: self.buttonPaddingStr)
        
 //       self.buildButtons(self.seductionButton)
    }
    
    private func setButtonLabels() {
        self.brainWashingButton.setTitle("Brain Washing", for: .normal)
        self.brainWashingButton.tag = kBrainWashingTag
        self.chaseButton.setTitle("Chase", for: .normal)
        self.chaseButton.tag = kChaseTag
        self.hackingButton.setTitle("Hacking", for: .normal)
        self.hackingButton.tag = kHackingTag
        self.infiltrationButton.setTitle("Infiltration", for: .normal)
        self.infiltrationButton.tag = kInfiltrationTag
        self.interrogationButton.setTitle("Interrogation", for: .normal)
        self.interrogationButton.tag = kInterrogationTag
        self.manhuntButton.setTitle("Manhunt", for: .normal)
        self.manhuntButton.tag = kManhuntTag
        self.seductionButton.setTitle("Seduction", for: .normal)
        self.seductionButton.tag = kSeductionTag
    }
    
    private func buildButtonsConstraints(buttonOne: HSRoundedButton, buttonTwo: HSRoundedButton) {
        buttonOne.constrainWidth(self.buttonWidth, height: self.buttonWidth)
        self.view.addSubview(buttonOne)
        
        buttonTwo.constrainWidth(self.buttonWidth, height: self.buttonWidth)
        self.view.addSubview(buttonTwo)
        let spyCraftGray = UIColor("#D7D5D5")
        buttonOne.backgroundColor = spyCraftGray
        buttonTwo.backgroundColor = spyCraftGray
        buttonOne.alignLeadingEdge(withView: self.view, predicate: "0")
        
        buttonTwo.constrainLeadingSpace(toView: buttonOne, predicate: self.buttonPaddingStr)
       // buttonTwo.alignTrailingEdge(withView: self.view, predicate: self.buttonPaddingStr)
        
        buttonOne.addTarget(self, action: #selector(buttonPress), for: .touchUpInside)
        buttonTwo.addTarget(self, action: #selector(buttonPress), for: .touchUpInside)
    }
    
    @objc private func buttonPress(sender: UIButton!) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let viewCon = storyboard.instantiateViewController(withIdentifier: "ConflictCardTable") as? HSConflictCardTableViewController {
            viewCon.selectedCrisisType = self.getCrisisCardTypeForButton(tag: sender.tag)
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    
    private func getCrisisCardTypeForButton(tag: Int) -> CrisisCardType {
        var crisisType: CrisisCardType
        
        switch tag {
        case kBrainWashingTag:
            crisisType = .kBrainWashing
            break
        case kChaseTag:
            crisisType = .kChase
            break
        case kHackingTag:
            crisisType = .kHacking
            break
        case kInfiltrationTag:
            crisisType = .kInfiltration
            break
        case kInterrogationTag:
            crisisType = .kInterrogation
            break
        case kManhuntTag:
            crisisType = .kManhunt
            break
        case kSeductionTag:
            crisisType = .kSeduction
            break
        default:
            crisisType = .kAll
            break
        }
        
        return crisisType
    }
}

