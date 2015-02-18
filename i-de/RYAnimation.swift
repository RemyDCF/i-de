//
//  RYAnimation.swift
//  i-de
//
//  Created by remy on 17/02/2015.
//  Copyright (c) 2015 DCF. All rights reserved.
//

import UIKit

class RYAnimation{
    func setScale(toScale:Float!, duration:Double!) -> CABasicAnimation {
        let scale = CABasicAnimation(keyPath: "transform.scale")
        scale.toValue = toScale
        scale.duration = duration
        scale.removedOnCompletion = false
        scale.fillMode = kCAFillModeForwards
        return scale
    }
    func setOpacity(fromOpacity:Float!, toOpacity:Float!, duration:Double!) -> CABasicAnimation {
        let opacity = CABasicAnimation(keyPath: "opacity")
        opacity.fromValue = fromOpacity
        opacity.toValue = toOpacity
        opacity.duration = duration
        opacity.removedOnCompletion = false
        opacity.fillMode = kCAFillModeForwards
        return opacity
    }
}