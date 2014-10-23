//
//  UIButtonCustom.swift
//  i-de
//
//  Created by remy on 21/10/2014.
//  Copyright (c) 2014 DCF. All rights reserved.
//

import UIKit


extension UIButton {
    func setRoundedRectangle(cornerRadius: CGFloat = 5, borderWidth: CGFloat = 1, borderColor: CGColor = UIColor(red:0, green:0.48, blue:1, alpha:1).CGColor) -> Void {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor
    }
}