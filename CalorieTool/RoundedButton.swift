//
//  RoundedButton.swift
//  CalorieTool
//
//  Created by MICHAEL on 2018-12-18.
//  Copyright © 2018 Michael Truong. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Set to 2pt border
        layer.borderWidth = 5/UIScreen.main.nativeScale
        contentEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        titleLabel?.adjustsFontForContentSizeCategory = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = (cornerRadius == 0) ? frame.height / 2 : cornerRadius
        layer.borderColor = isEnabled ? tintColor.cgColor : UIColor.lightGray.cgColor
    }
}
