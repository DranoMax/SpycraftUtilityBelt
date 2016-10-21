//
//  CrisisCardCell.swift
//  SpyCraft Utility Belt
//
//  Created by Alexander Scoggins on 10/20/16.
//  Copyright © 2016 Alexander Scroggins. All rights reserved.
//

import UIKit
import FLKAutoLayout

public class HSCrisisCardCell: UITableViewCell {
    var nameLabel = UILabel()
    var descLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupLabels()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLabels() {
        self.contentView.addSubview(self.nameLabel)
        self.contentView.addSubview(self.descLabel)
        
        // Name Label
        self.nameLabel.constrainWidth(self.contentView.frame.width.description)
        self.nameLabel.alignLeadingEdge(withView: self.contentView, predicate: "16")
        
        // Description Label
        self.descLabel.lineBreakMode = .byWordWrapping
        self.descLabel.numberOfLines = 0;
        self.descLabel.font = UIFont(name: "Helvetica Neue Ultralight", size: 12)
        self.descLabel.constrainWidth(self.contentView.frame.width.description)
        self.descLabel.constrainHeight("60")
        self.descLabel.alignLeadingEdge(withView: self.contentView, predicate: "16")
        self.descLabel.alignTrailingEdge(withView: self.contentView, predicate: "16")
        self.descLabel.constrainTopSpace(toView: self.nameLabel, predicate: "16")
    }
}
