//
//  ParametreSecouer.swift
//  i-de
//
//  Created by remy on 27/10/2014.
//  Copyright (c) 2014 DCF. All rights reserved.
//

import UIKit

class ParametreSecouer: UITableViewController {
    @IBOutlet weak var switchRotation: UISwitch!
    @IBOutlet weak var switchAnimations: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Rotation
        var donneeSecouerRotation = MesDonnesSecouerRotation()
        var dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        var path = dir[0] . stringByAppendingPathComponent("secouerRotation")
        if (NSFileManager.defaultManager().fileExistsAtPath(path)) {
            donneeSecouerRotation = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as MesDonnesSecouerRotation
            if (!donneeSecouerRotation.secouerRotation) {
                switchRotation.setOn(false, animated: true)
            }
        }
        else {
            donneeSecouerRotation.secouerRotation = true
            var erreur = NSKeyedArchiver.archiveRootObject(donneeSecouerRotation, toFile: path)
        }
        // Animations
        var donneeSecouerAnimations = MesDonnesSecouerAnimations()
        dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        path = dir[0] . stringByAppendingPathComponent("secouerAnimations")
        if (NSFileManager.defaultManager().fileExistsAtPath(path)) {
            donneeSecouerAnimations = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as MesDonnesSecouerAnimations
            if (!donneeSecouerAnimations.secouerAnimations) {
                switchAnimations.setOn(false, animated: true)
            }
        }
        else {
            switchAnimations.setOn(false, animated: true)
            donneeSecouerAnimations.secouerAnimations = false
            var erreur = NSKeyedArchiver.archiveRootObject(donneeSecouerRotation, toFile: path)
        }
    }
    
    @IBAction func switchRotationChange(sender: AnyObject!) {
        var donnee = MesDonnesSecouerRotation()
        if (switchRotation.on) {
            donnee.secouerRotation = true
        }
        else {
            donnee.secouerRotation = false
        }
        var dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        var path = dir[0] . stringByAppendingPathComponent("secouerRotation")
        NSKeyedArchiver.archiveRootObject(donnee, toFile: path)
    }
    
    @IBAction func switchAnimationsChange(sender: AnyObject!) {
        var donnee = MesDonnesSecouerAnimations()
        if (switchAnimations.on) {
            donnee.secouerAnimations = true
        }
        else {
            donnee.secouerAnimations = false
        }
        var dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        var path = dir[0] . stringByAppendingPathComponent("secouerAnimations")
        NSKeyedArchiver.archiveRootObject(donnee, toFile: path)
    }
}
