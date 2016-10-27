//
//  HSSingleLineCell.swift
//  SpyCraft Utility Belt
//
//  Created by Alexander Scoggins on 10/26/16.
//  Copyright © 2016 Alexander Scroggins. All rights reserved.
//

import UIKit
import FLKAutoLayout

public class HSSingleLineCell: UITableViewCell {
    var nameLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupLabels()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLabels() {
        self.contentView.addSubview(self.nameLabel)
        
        // Name Label
        self.nameLabel.constrainWidth(self.contentView.frame.width.description)
        self.nameLabel.constrainHeight("30")
        self.nameLabel.alignCenterY(withView: self.contentView, predicate: "0")
        self.nameLabel.alignLeading("16", trailing: "-16", toView: self.contentView)
        self.nameLabel.font = HSStyleManager.sharedInstance.spyBodyBoldFont
    }
}
