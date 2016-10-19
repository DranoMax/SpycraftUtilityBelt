//
//  FirstViewController.swift
//  SpyCraft Utility Belt
//
//  Created by Alexander Scroggins on 10/16/16.
//  Copyright © 2016 Alexander Scroggins. All rights reserved.
//

import UIKit
import FLKAutoLayout

class HSCrisisCardSetSelectionViewController: UIViewController {
    
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
        
        self.buildButtonsConstraints(buttonOne: self.brainWashingButton, buttonTwo: self.chaseButton)
        self.buildButtonsConstraints(buttonOne: self.hackingButton, buttonTwo: self.infiltrationButton)
        self.buildButtonsConstraints(buttonOne: self.interrogationButton, buttonTwo: self.manhuntButton)
        self.brainWashingButton.alignTopEdge(withView: self.mainScrollView, predicate: self.buttonPaddingStr)
        self.chaseButton.alignTopEdge(withView: self.mainScrollView, predicate: self.buttonPaddingStr)
        
        self.hackingButton.constrainTopSpace(toView: self.brainWashingButton, predicate: self.buttonPaddingStr)
        self.infiltrationButton.constrainTopSpace(toView: self.chaseButton, predicate: self.buttonPaddingStr)
        
        self.interrogationButton.constrainTopSpace(toView: self.hackingButton, predicate: self.buttonPaddingStr)
        self.manhuntButton.constrainTopSpace(toView: self.infiltrationButton, predicate: self.buttonPaddingStr)
        
 //       self.buildButtons(self.seductionButton)
    }
    
    private func setButtonLabels() {
        self.brainWashingButton.titleLabel?.text = "Brain Washing"
        self.chaseButton.titleLabel?.text = "Chase"
        self.hackingButton.titleLabel?.text = "Hacking"
        self.infiltrationButton.titleLabel?.text = "Infiltration"
        self.interrogationButton.titleLabel?.text = "Interrogation"
        self.manhuntButton.titleLabel?.text = "Manhunt"
    }
    
    private func buildButtonsConstraints(buttonOne: HSRoundedButton, buttonTwo: HSRoundedButton) {
        buttonOne.constrainWidth(self.buttonWidth, height: self.buttonWidth)
        self.mainScrollView.addSubview(buttonOne)
        
        buttonTwo.constrainWidth(self.buttonWidth, height: self.buttonWidth)
        self.mainScrollView.addSubview(buttonTwo)
        buttonOne.backgroundColor = UIColor.yellow
        buttonTwo.backgroundColor = UIColor.red
        buttonOne.alignLeadingEdge(withView: self.mainScrollView, predicate: self.buttonPaddingStr)
        
        buttonTwo.constrainLeadingSpace(toView: buttonOne, predicate: self.buttonPaddingStr)
        buttonTwo.alignTrailingEdge(withView: self.mainScrollView, predicate: self.buttonPaddingStr)
        
        buttonOne.addTarget(self, action: #selector(buttonPress), for: .touchUpInside)
    }
    
    @objc private func buttonPress(sender: UIButton!) {
        let viewCon = HSConflictCardTableViewcontroller()
        let navCon = UINavigationController(rootViewController: viewCon)
        
        self.present(navCon, animated: true, completion: nil)
    }
}

