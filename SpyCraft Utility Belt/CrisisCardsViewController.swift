//
//  FirstViewController.swift
//  SpyCraft Utility Belt
//
//  Created by Alexander Scroggins on 10/16/16.
//  Copyright © 2016 Alexander Scroggins. All rights reserved.
//

import UIKit
import FLKAutoLayout

class CrisisCardsViewController: UIViewController {
    
    @IBOutlet weak var mainScrollView: UIScrollView!
    
    var brainWashingButton = HSRoundedButton()
    var chaseButton = HSRoundedButton()
    var hackingButton = HSRoundedButton()
    var infiltrationButton = HSRoundedButton()
    var interrogationButton = HSRoundedButton()
    var manhuntButton = HSRoundedButton()
    var seductionButton = HSRoundedButton()
    
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
        self.buildButtonsConstraints(self.brainWashingButton, buttonTwo: self.chaseButton)
        self.buildButtonsConstraints(self.hackingButton, buttonTwo: self.infiltrationButton)
        self.buildButtonsConstraints(self.interrogationButton, buttonTwo: self.manhuntButton)
        
        self.brainWashingButton.alignTopEdge(withView: self.mainScrollView, predicate: self.buttonPaddingStr)
        self.chaseButton.alignTopEdge(withView: self.mainScrollView, predicate: self.buttonPaddingStr)
        
        self.hackingButton.constrainTopSpace(toView: self.brainWashingButton, predicate: self.buttonPaddingStr)
        self.infiltrationButton.constrainTopSpace(toView: self.chaseButton, predicate: self.buttonPaddingStr)
        
        self.interrogationButton.constrainTopSpace(toView: self.hackingButton, predicate: self.buttonPaddingStr)
        self.manhuntButton.constrainTopSpace(toView: self.infiltrationButton, predicate: self.buttonPaddingStr)
 
 //       self.buildButtons(self.seductionButton)
    }
    
    private func setButtonLabels() {
        self.brainWashingButton.buttonLabel.text = "Brain Washing"
        self.chaseButton.buttonLabel.text = "Chase"
        self.hackingButton.buttonLabel.text = "Hacking"
        self.infiltrationButton.buttonLabel.text = "Infiltration"
        self.interrogationButton.buttonLabel.text = "Interrogation"
        self.manhuntButton.buttonLabel.text = "Manhunt"
    }
    
    private func buildButtonsConstraints(_ buttonOne: HSRoundedButton, buttonTwo: HSRoundedButton) {
        buttonOne.constrainWidth(self.buttonWidth, height: self.buttonWidth)
        self.mainScrollView.addSubview(buttonOne)
        
        buttonTwo.constrainWidth(self.buttonWidth, height: self.buttonWidth)
        self.mainScrollView.addSubview(buttonTwo)
        
        buttonOne.alignLeading(self.buttonPaddingStr,
                               trailing: self.buttonPaddingStr,
                               toView: self.mainScrollView)
        
        buttonTwo.constrainLeadingSpace(toView: buttonOne, predicate: self.buttonPaddingStr)
        buttonTwo.alignTrailingEdge(withView: self.mainScrollView, predicate: self.buttonPaddingStr)
    }
    
}

