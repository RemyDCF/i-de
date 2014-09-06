//
//  ChoixFace.swift
//  Aleatoire
//
//  Created by DCF on 27/07/2014.
//  Copyright (c) 2014 Da Costa Faro Rémy. All rights reserved.
//

import UIKit

class Parametre: UITableViewController {
    let pref = NSUserDefaults.standardUserDefaults()
    @IBOutlet weak var segmentChoixDe: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        if (pref.boolForKey("secouer") == false) {
            segmentChoixDe.selectedSegmentIndex = 1
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool  {
        return true
    }
    @IBAction func choixTypeLanceDeChange(sender: AnyObject) {
        println("coucou")
        var appDefault:NSDictionary?
        if (segmentChoixDe.selectedSegmentIndex == 0) {
            appDefault = NSDictionary(object: true, forKey: "secouer")
        }
        else {
            appDefault = NSDictionary(object: false, forKey: "secouer")
        }
        println(appDefault)
        pref.registerDefaults(appDefault!)
        pref.synchronize()
    }
}
