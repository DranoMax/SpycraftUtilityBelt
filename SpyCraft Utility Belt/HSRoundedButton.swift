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

class HSRoundedButton: UIView {
    
    var buttonLabel = UILabel()
    
    // MARK: - Lifecycle Methods
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupDefaults()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupDefaults() {
        self.addSubview(self.buttonLabel)
        self.buttonLabel.alignCenter(withView: self)
    }
}
