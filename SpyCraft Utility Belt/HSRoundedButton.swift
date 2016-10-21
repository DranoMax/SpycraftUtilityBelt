//
//  HSRoundedButton.swift
//  SpyCraft Utility Belt
//
//  Created by Alexander Scroggins on 10/16/16.
//  Copyright © 2016 Alexander Scroggins. All rights reserved.
//

import UIKit
import Foundation
import FLKAutoLayout
import QuartzCore

class HSRoundedButton: UIButton {
    
    // MARK: - Lifecycle Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupDefaults()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupDefaults() {
        // Rounded Corners
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
    }
    
    private func setupTitleLabel() {
        self.titleLabel?.alignCenter(withView: self)
        self.titleLabel?.font = UIFont(name: "Helvetica Neue Ultralight", size: 36)
        self.titleLabel?.textColor = UIColor.black
    }
}
