//
//  RIButton.swift
//  i-de
//
//  Created by remy on 16/02/2015.
//  Copyright (c) 2015 DCF. All rights reserved.
//

import UIKit

@IBDesignable public class RYButton : UIButton {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor = UIColor(red:0, green:0.64, blue:0.98, alpha:1) {
        didSet {
            layer.borderColor = borderColor.CGColor
        }
    }
}