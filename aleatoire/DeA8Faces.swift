//
//  DeA8Faces.swift
//  Aleatoire
//
//  Created by DCF on 27/07/2014.
//  Copyright (c) 2014 Da Costa Faro Rémy. All rights reserved.
//

import UIKit

class DeA8Faces: UIViewController {
    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        var donnee = MesDonnes()
        donnee.laChaine = "8"
        var dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        var path = dir[0] . stringByAppendingPathComponent("nombreFace")
        var erreur = NSKeyedArchiver.archiveRootObject(donnee, toFile: path)
        if !erreur {
            label.text = NSLocalizedString("Erreur",comment: "Message d'erreur")
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
