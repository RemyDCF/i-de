//
//  ViewController.swift
//  i-de
//
//  Created by DCF on 23/07/2014.
//  Copyright (c) 2014 Da Costa Faro Rémy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var premierTirageDepuisLancement:Bool = true
    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var btChoisir: UIButton!
    @IBOutlet weak var labelFace: UILabel!
    @IBOutlet weak var texteSecouer: UILabel!
    let pref = NSUserDefaults.standardUserDefaults()
    var nombreTiré:Int?
    var nombreFace:Int? = 6
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
            if !erreur {
                println("L'écriture de la valeur par défault de la face du dé à échoué")
            }
        }
        labelFace.text = "Tirage d'un nombre entre 1 et " + String(UInt8(nombreFace!))
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
    
    override func motionBegan(motion: UIEventSubtype, withEvent event: UIEvent) {}
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent) {
        if (pref.boolForKey("secouer") == true) {
            choisir()
        }
    }
    @IBAction func appuiChoisir(sender: AnyObject) {
        choisir()
    }
    func choisir() {
        if (premierTirageDepuisLancement) {
            premierTirageDepuisLancement = false
        }
        nombre.moveTo(CGPoint(x: self.view.bounds.width, y: self.view.bounds.height / 2), duration: 1, option: UIViewAnimationOptions.CurveLinear)
        
        nombreTiré = random() % nombreFace! + 1;
        nombre.text = String(nombreTiré!)
        nombre.hidden = false
        image.hidden = false
    }
}

