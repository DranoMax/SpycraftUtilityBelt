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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        self.view.addSubview(self.buttonContainer)
        self.buttonContainer.alignCenterX(withView: self.view, predicate: "0")
        
        self.buildButtonsConstraints(buttonOne: self.brainWashingButton, buttonTwo: self.chaseButton)
        self.buildButtonsConstraints(buttonOne: self.hackingButton, buttonTwo: self.infiltrationButton)
        self.buildButtonsConstraints(buttonOne: self.interrogationButton, buttonTwo: self.manhuntButton)
        self.brainWashingButton.alignTopEdge(withView: self.buttonContainer, predicate: self.buttonPaddingStr)
        self.chaseButton.alignTopEdge(withView: self.buttonContainer, predicate: self.buttonPaddingStr)
        
        self.hackingButton.constrainTopSpace(toView: self.brainWashingButton, predicate: self.buttonPaddingStr)
        self.infiltrationButton.constrainTopSpace(toView: self.chaseButton, predicate: self.buttonPaddingStr)
        
        self.interrogationButton.constrainTopSpace(toView: self.hackingButton, predicate: self.buttonPaddingStr)
        self.manhuntButton.constrainTopSpace(toView: self.infiltrationButton, predicate: self.buttonPaddingStr)
        
 //       self.buildButtons(self.seductionButton)
    }
    
    private func setButtonLabels() {
        self.brainWashingButton.setTitle("Brain Washing", for: .normal)
        self.chaseButton.setTitle("Chase", for: .normal)
        self.hackingButton.setTitle("Hacking", for: .normal)
        self.infiltrationButton.setTitle("Infiltration", for: .normal)
        self.interrogationButton.setTitle("Interrogation", for: .normal)
        self.manhuntButton.setTitle("Manhunt", for: .normal)
        self.seductionButton.setTitle("Seduction", for: .normal)
    }
    
    private func buildButtonsConstraints(buttonOne: HSRoundedButton, buttonTwo: HSRoundedButton) {
        buttonOne.constrainWidth(self.buttonWidth, height: self.buttonWidth)
        self.buttonContainer.addSubview(buttonOne)
        
        buttonTwo.constrainWidth(self.buttonWidth, height: self.buttonWidth)
        self.buttonContainer.addSubview(buttonTwo)
        let spyCraftGray = UIColor("#D7D5D5")
        buttonOne.backgroundColor = spyCraftGray
        buttonTwo.backgroundColor = spyCraftGray
        buttonOne.alignLeadingEdge(withView: self.buttonContainer, predicate: "0")
        
        buttonTwo.constrainLeadingSpace(toView: buttonOne, predicate: self.buttonPaddingStr)
       // buttonTwo.alignTrailingEdge(withView: self.view, predicate: self.buttonPaddingStr)
        
        buttonOne.addTarget(self, action: #selector(buttonPress), for: .touchUpInside)
    }
    
    @objc private func buttonPress(sender: UIButton!) {
        let viewCon = HSConflictCardTableViewcontroller()
        let navCon = UINavigationController(rootViewController: viewCon)
        
        self.present(navCon, animated: true, completion: nil)
    }
}

