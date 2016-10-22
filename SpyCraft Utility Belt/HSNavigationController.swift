//
//  HSNavigationController.swift
//  SpyCraft Utility Belt
//
//  Created by Alexander Scoggins on 10/20/16.
//  Copyright © 2016 Alexander Scroggins. All rights reserved.
//

import UIKit

public class HSNavigationController: UINavigationController {

    public override func viewDidLoad() {
        super.viewDidLoad()
        self.setupBackButton()
    }
    
    private func setupBackButton() {
        let backBtn = UIBarButtonItem(barButtonSystemItem: .cancel,
                                      target: #selector(backButtonPress),
                                      action: nil)
        backBtn.title = "Back"
        
        self.navigationItem.leftBarButtonItem = backBtn
    }
    
    @objc private func backButtonPress(sender: UIBarButtonItem) {
        self.popViewController(animated: true)
    }
}
