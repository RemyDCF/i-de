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
    var secouer:Bool? = true
    override func viewDidLoad() {
        super.viewDidLoad()
        // Nombre face
        var donneeNombreFace = MesDonnesNombreFace()
        var dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        var path = dir[0] . stringByAppendingPathComponent("nombreFace")
        if (NSFileManager.defaultManager().fileExistsAtPath(path)) {
            donneeNombreFace = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as MesDonnesNombreFace
            nombreFace = Int(donneeNombreFace.nombreFace)
        }
        else {
            donneeNombreFace.nombreFace = 6
            NSKeyedArchiver.archiveRootObject(donneeNombreFace, toFile: path)
        }
        
        labelFace.text = "Tirage d'un nombre entre 1 et " + String(UInt8(nombreFace!))
        
        // Secouer
        var donneeSecouer = MesDonnesSecouer()
        dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        path = dir[0] . stringByAppendingPathComponent("secouer")
        if (NSFileManager.defaultManager().fileExistsAtPath(path)) {
            donneeSecouer = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as MesDonnesSecouer
            if (!donneeSecouer.secouer) {
                btChoisir.hidden = false
                texteSecouer.hidden = true
            }
            else {
                btChoisir.hidden = true
                texteSecouer.hidden = false
                secouer = true
            }
        }
        else {
            btChoisir.hidden = true
            texteSecouer.hidden = false
            donneeSecouer.secouer = true
            NSKeyedArchiver.archiveRootObject(donneeSecouer, toFile: path)
        }
        
        // Lancer au demmarage
        var donneeLancerAuDemmarage = MesDonnesLancerAuDemmarage()
        dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        path = dir[0] . stringByAppendingPathComponent("lancerAuDemmarage")
        if (NSFileManager.defaultManager().fileExistsAtPath(path)) {
            donneeLancerAuDemmarage = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as MesDonnesLancerAuDemmarage
            if (donneeLancerAuDemmarage.lancerAuDemmarage) {
                choisir()
            }
        }
        else {
            donneeLancerAuDemmarage.lancerAuDemmarage = false
            NSKeyedArchiver.archiveRootObject(donneeLancerAuDemmarage, toFile: path)
        }
        
        // Personnalisation du bouton choisir
        btChoisir.setRoundedRectangle()
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
        if (secouer == true) {
            choisir()
        }
    }
    
    @IBAction func choisirActionGauche(sender: AnyObject) {
        choisir(sens: "Gauche")
    }
    @IBAction func choisirAction(sender: AnyObject) {
        choisir()
    }
    func choisir(sens:String = "Droite") {
        if animationEnCours == false {
            self.self.btChoisir.enabled = false
            self.self.btChoisir.setRoundedRectangleDisabled()
            animationEnCours = true
            nombre.hidden = false
            if (premierLancer == true) {
                self.nombreTiré = random() % self.nombreFace! + 1;
                self.nombre.text = String(self.nombreTiré!)
                premierLancer = false
                animationEnCours = false
                self.self.btChoisir.enabled = true
            }
            else {
                if (sens == "Droite") {
                    UIView.animateKeyframesWithDuration(0.5, delay: 0.0, options: UIViewKeyframeAnimationOptions.CalculationModeLinear, animations: { () -> Void in
                        self.nombre.frame = CGRectMake(self.nombre.frame.origin.x + 100, self.nombre.frame.origin.y, self.nombre.frame.size.width, self.nombre.frame.size.height)
                        }) { (finished: Bool) -> Void in
                            UIView.animateKeyframesWithDuration(0.3, delay: 0.0, options: UIViewKeyframeAnimationOptions.CalculationModeLinear, animations: { () -> Void in
                                self.nombre.frame = CGRectMake(self.nombre.frame.origin.x - 200, self.nombre.frame.origin.y, self.nombre.frame.size.width, self.nombre.frame.size.height)
                                }) { (finished: Bool) -> Void in
                                    self.nombreTiré = random() % self.nombreFace! + 1;
                                    self.nombre.text = String(self.nombreTiré!)
                                    UIView.animateKeyframesWithDuration(0.5, delay: 0.0, options: UIViewKeyframeAnimationOptions.CalculationModeLinear, animations: { () -> Void in
                                        self.nombre.frame = CGRectMake(self.nombre.frame.origin.x + 100, self.nombre.frame.origin.y, self.nombre.frame.size.width, self.nombre.frame.size.height)
                                        }) { (finished: Bool) -> Void in
                                            self.self.animationEnCours = false
                                            self.self.btChoisir.enabled = true
                                            self.self.btChoisir.setRoundedRectangle()
                                    }
                            }
                    }
                }
                else {
                    UIView.animateKeyframesWithDuration(0.5, delay: 0.0, options: UIViewKeyframeAnimationOptions.CalculationModeLinear, animations: { () -> Void in
                        self.nombre.frame = CGRectMake(self.nombre.frame.origin.x - 100, self.nombre.frame.origin.y, self.nombre.frame.size.width, self.nombre.frame.size.height)
                        }) { (finished: Bool) -> Void in
                            UIView.animateKeyframesWithDuration(0.3, delay: 0.0, options: UIViewKeyframeAnimationOptions.CalculationModeLinear, animations: { () -> Void in
                                self.nombre.frame = CGRectMake(self.nombre.frame.origin.x + 200, self.nombre.frame.origin.y, self.nombre.frame.size.width, self.nombre.frame.size.height)
                                }) { (finished: Bool) -> Void in
                                    self.nombreTiré = random() % self.nombreFace! + 1;
                                    self.nombre.text = String(self.nombreTiré!)
                                    UIView.animateKeyframesWithDuration(0.5, delay: 0.0, options: UIViewKeyframeAnimationOptions.CalculationModeLinear, animations: { () -> Void in
                                        self.nombre.frame = CGRectMake(self.nombre.frame.origin.x - 100, self.nombre.frame.origin.y, self.nombre.frame.size.width, self.nombre.frame.size.height)
                                        }) { (finished: Bool) -> Void in
                                            self.self.animationEnCours = false
                                            self.self.btChoisir.enabled = true
                                            self.self.btChoisir.setRoundedRectangle()
                                    }
                            }
                    }
                }
            }
        }
    }
}

