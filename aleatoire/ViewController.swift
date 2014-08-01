//
//  ViewController.swift
//  Aleatoire
//
//  Created by DCF on 23/07/2014.
//  Copyright (c) 2014 Da Costa Faro Rémy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var btChoisir: UIButton!
    @IBOutlet weak var btChoixFace: UIButton!
    @IBOutlet weak var texteSecouer: UILabel!
    let pref = NSUserDefaults.standardUserDefaults()
    var nombreTiré:Int?
    var nombreFace = 6
    override func viewDidLoad() {
        super.viewDidLoad()
        var donnee = MesDonnes()
        var dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        var path = dir[0] . stringByAppendingPathComponent("nombreFace")
        if (NSFileManager.defaultManager().fileExistsAtPath(path)) {
            donnee = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as MesDonnes
            if (donnee.laChaine == "6") {
                nombreFace = 6
            }
            if (donnee.laChaine == "8") {
                nombreFace = 8
            }
            if (donnee.laChaine == "10") {
                nombreFace = 10
            }
        }
        else {
            donnee.laChaine = "6"
            var erreur = NSKeyedArchiver.archiveRootObject(donnee, toFile: path)
            if erreur {
            }
            donnee.laChaine = "0"
            var path = dir[0] . stringByAppendingPathComponent("1")
            erreur = NSKeyedArchiver.archiveRootObject(donnee, toFile: path)
            if erreur {
            }
            path = dir[0] . stringByAppendingPathComponent("2")
            erreur = NSKeyedArchiver.archiveRootObject(donnee, toFile: path)
            if erreur {
            }
            path = dir[0] . stringByAppendingPathComponent("3")
            erreur = NSKeyedArchiver.archiveRootObject(donnee, toFile: path)
            if erreur {
            }
            path = dir[0] . stringByAppendingPathComponent("4")
            erreur = NSKeyedArchiver.archiveRootObject(donnee, toFile: path)
            if erreur {
            }
            path = dir[0] . stringByAppendingPathComponent("5")
            erreur = NSKeyedArchiver.archiveRootObject(donnee, toFile: path)
            if erreur {
            }
            path = dir[0] . stringByAppendingPathComponent("6")
            erreur = NSKeyedArchiver.archiveRootObject(donnee, toFile: path)
            if erreur {
            }
            path = dir[0] . stringByAppendingPathComponent("7")
            erreur = NSKeyedArchiver.archiveRootObject(donnee, toFile: path)
            if erreur {
            }
            path = dir[0] . stringByAppendingPathComponent("8")
            erreur = NSKeyedArchiver.archiveRootObject(donnee, toFile: path)
            if erreur {
            }
            path = dir[0] . stringByAppendingPathComponent("9")
            erreur = NSKeyedArchiver.archiveRootObject(donnee, toFile: path)
            if erreur {
            }
            path = dir[0] . stringByAppendingPathComponent("10")
            erreur = NSKeyedArchiver.archiveRootObject(donnee, toFile: path)
            if erreur {
            }
            
        }
        btChoixFace.setTitle(NSLocalizedString("Tirage",comment: "Message de tirage") + String(nombreFace), forState: UIControlState.Normal)
        if (pref.boolForKey("secouer") == false) {
            btChoisir.hidden = false
            texteSecouer.hidden = true
        }
        else {
            btChoisir.hidden = true
            texteSecouer.hidden = false
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func canResignFirstResponder() -> Bool {
        return true
    }
    
    override func motionBegan(motion: UIEventSubtype, withEvent event: UIEvent!) {}
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent!) {
        if (pref.boolForKey("secouer") == true) {
            choisir()
        }
    }
    @IBAction func appuiChoisir(sender: AnyObject) {
        choisir()
    }
    func choisir() {
        nombreTiré = random() % nombreFace + 1;
        nombre.text = String(nombreTiré!)
        nombre.hidden = false
    }
}

