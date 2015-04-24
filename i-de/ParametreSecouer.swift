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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Animations
        var donneeSecouerAnimations = MesDonnesSecouerAnimations()
        var dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        var path = dir[0] . stringByAppendingPathComponent("secouerAnimations")
        if (NSFileManager.defaultManager().fileExistsAtPath(path)) {
            donneeSecouerAnimations = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as! MesDonnesSecouerAnimations
            if (!donneeSecouerAnimations.secouerAnimations) {
                switchAnimations.setOn(false, animated: true)
            }
        }
        else {
            switchAnimations.setOn(false, animated: true)
            donneeSecouerAnimations.secouerAnimations = false
            var erreur = NSKeyedArchiver.archiveRootObject(donneeSecouerAnimations, toFile: path)
        }
    }
    
    @IBAction func switchAnimationsChange(sender: AnyObject!) {
        var donnee = MesDonnesSecouerAnimations()
        donnee.secouerAnimations = switchAnimations.on
        var dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        var path = dir[0] . stringByAppendingPathComponent("secouerAnimations")
        NSKeyedArchiver.archiveRootObject(donnee, toFile: path)
        AppValues.animationsSecouerAutorisés = switchAnimations.on
    }
}
