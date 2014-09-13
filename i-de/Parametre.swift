//
//  ChoixFace.swift
//  i-de
//
//  Created by DCF on 27/07/2014.
//  Copyright (c) 2014 Da Costa Faro Rémy. All rights reserved.
//

import UIKit

class Parametres: UIViewController {
    let pref = NSUserDefaults.standardUserDefaults()
    @IBOutlet weak var segmentChoixDe: UISegmentedControl!
    @IBOutlet weak var segmentChoixNombreFace: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        if (pref.boolForKey("secouer") == false) {
            segmentChoixDe.selectedSegmentIndex = 1
        }
        var donnee = MesDonnes()
        var dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        var path = dir[0] . stringByAppendingPathComponent("nombreFace")
        if (NSFileManager.defaultManager().fileExistsAtPath(path)) {
            donnee = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as MesDonnes
            if (donnee.laChaine == "6") {
                segmentChoixNombreFace.selectedSegmentIndex = 0
            }
            if (donnee.laChaine == "8") {
                segmentChoixNombreFace.selectedSegmentIndex = 1
            }
            if (donnee.laChaine == "10") {
                segmentChoixNombreFace.selectedSegmentIndex = 2
            }
        }
        else {
            segmentChoixNombreFace.selectedSegmentIndex = 0
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        let message = UIAlertController(title: "Erreur mémoire", message: "Attention à la mémoire", preferredStyle: .Alert)
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        message.addAction(defaultAction)
        
        presentViewController(message, animated: true, completion: nil)
    }
    
    @IBAction func choixTypeLanceDeChange(sender: AnyObject) {
        var appDefault:NSDictionary?
        if (segmentChoixDe.selectedSegmentIndex == 0) {
            appDefault = NSDictionary(object: true, forKey: "secouer")
        }
        else {
            appDefault = NSDictionary(object: false, forKey: "secouer")
        }
        pref.registerDefaults(appDefault!)
        pref.synchronize()
    }
    
    @IBAction func choixNombreFaceChange(sender: AnyObject) {
        super.viewDidLoad()
        var donnee = MesDonnes()
        if (segmentChoixNombreFace.selectedSegmentIndex == 0) {
            donnee.laChaine = "6"
        }
        if (segmentChoixNombreFace.selectedSegmentIndex == 1) {
            donnee.laChaine = "8"
        }
        if (segmentChoixNombreFace.selectedSegmentIndex == 2) {
            donnee.laChaine = "10"
        }
        var dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        var path = dir[0] . stringByAppendingPathComponent("nombreFace")
        var erreur = NSKeyedArchiver.archiveRootObject(donnee, toFile: path)
    }
}
