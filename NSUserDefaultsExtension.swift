//
//  NSUserDefaultsExtension.swift
//  i-de
//
//  Created by Bernex.net on 17.09.15.
//  Copyright © 2015 DCF. All rights reserved.
//

import UIKit

extension NSUserDefaults {
    
    func colorForKey(key: String) -> UIColor? {
        var color: UIColor?
        if let colorData = dataForKey(key) {
            color = NSKeyedUnarchiver.unarchiveObjectWithData(colorData) as? UIColor
        }
        return color
    }
    
    func setColor(color: UIColor?, forKey key: String) {
        var colorData: NSData?
        if let color = color {
            colorData = NSKeyedArchiver.archivedDataWithRootObject(color)
        }
        setObject(colorData, forKey: key)
    }
    func stringForKeySwift(key: String) -> String? {
        var string: String?
        if let stringData = dataForKey(key) {
            string = NSKeyedUnarchiver.unarchiveObjectWithData(stringData) as? String
        }
        return string
    }
    
    func setStringSwift(string: String?, forKey key: String) {
        var stringData: NSData?
        if let string = string {
            stringData = NSKeyedArchiver.archivedDataWithRootObject(string)
        }
        setObject(stringData, forKey: key)
    }
}