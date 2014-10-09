//
//  ViewController.swift
//  i-de
//
//  Created by DCF on 23/07/2014.
//  Copyright (c) 2014 Da Costa Faro Rémy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var btChoisir: UIButton!
    @IBOutlet weak var labelFace: UILabel!
    @IBOutlet weak var texteSecouer: UILabel!
    let pref = NSUserDefaults.standardUserDefaults()
    var nombreTiré:Int?
    var nombreFace:Int? = 6
    var premierLancer:Bool? = true
    var animationEnCours:Bool? = false
    override func viewDidLoad() {
        super.viewDidLoad()
        var donnee = MesDonnes()
        var dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        var path = dir[0] . stringByAppendingPathComponent("nombreFace")
        if (NSFileManager.defaultManager().fileExistsAtPath(path)) {
            donnee = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as MesDonnes
            nombreFace = Int(donnee.leNombre)
        }
        else {
            donnee.leNombre = 6
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
        nombre.hidden = false
        if (premierLancer == true) {
            self.nombreTiré = random() % self.nombreFace! + 1;
            self.nombre.text = String(self.nombreTiré!)
            premierLancer = false
        }
        else {
            UIView.animateKeyframesWithDuration(0.5, delay: 0.0, options: UIViewKeyframeAnimationOptions.CalculationModeLinear, animations: { () -> Void in
                self.nombre.frame = CGRectMake(self.nombre.frame.origin.x + 100, self.nombre.frame.origin.y, self.nombre.frame.size.width, self.nombre.frame.size.height)
                }) { (finished: Bool) -> Void in
                    UIView.animateKeyframesWithDuration(0.5, delay: 0.0, options: UIViewKeyframeAnimationOptions.CalculationModeLinear, animations: { () -> Void in
                        self.nombre.frame = CGRectMake(self.nombre.frame.origin.x - 200, self.nombre.frame.origin.y, self.nombre.frame.size.width, self.nombre.frame.size.height)
                        }) { (finished: Bool) -> Void in
                            self.nombreTiré = random() % self.nombreFace! + 1;
                            self.nombre.text = String(self.nombreTiré!)
                            UIView.animateKeyframesWithDuration(0.5, delay: 0.0, options: UIViewKeyframeAnimationOptions.CalculationModeLinear, animations: { () -> Void in
                                self.nombre.frame = CGRectMake(self.nombre.frame.origin.x + 100, self.nombre.frame.origin.y, self.nombre.frame.size.width, self.nombre.frame.size.height)
                                }) { (finished: Bool) -> Void in
                        }
                }
            }
        }
    }
}

