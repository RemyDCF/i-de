//
//  ParametreSecouer.swift
//  i-de
//
//  Created by remy on 27/10/2014.
//  Copyright (c) 2014 DCF. All rights reserved.
//

import UIKit

class ParametreSecouer: UITableViewController {
    @IBOutlet weak var switchAnimations: UISwitch!
    let defaults = NSUserDefaults.standardUserDefaults()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Animations
        let secouerAnimations = defaults.boolForKey(NSUserDefaultsKeys.SecouerAnimations)
        if (!secouerAnimations) {
            switchAnimations.setOn(false, animated: true)
        }
    }
    
    @IBAction func switchAnimationsChange(sender: AnyObject!) {
        defaults.setBool(switchAnimations.on, forKey: NSUserDefaultsKeys.SecouerAnimations)
        AppValues.animationsSecouerAutorisés = switchAnimations.on
    }
}
