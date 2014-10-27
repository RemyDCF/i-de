//
//  ViewController.swift
//  i-de
//
//  Created by DCF on 23/07/2014.
//  Copyright (c) 2014 Da Costa Faro Rémy. All rights reserved.
//

import UIKit

enum SensSwipe {
    case Haut
    case Bas
    case Droite
    case Gauche
}

class ViewController: UIViewController {
    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var btChoisir: UIButton!
    @IBOutlet weak var btParametres: UIButton!
    @IBOutlet weak var labelFace: UILabel!
    @IBOutlet weak var image: UIImageView!
    var nombreTiré:Int! = 0
    var nombreFace:Int! = 6
    var premierLancer:Bool! = true
    var animationEnCours:Bool! = false
    var secouer:Bool! = false
    var animationsAutorisés:Bool! = true
    var rotation:Bool! = true
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
        
        labelFace.text = "Tirage d'un nombre entre 1 et " + String(UInt8(nombreFace))
        
        // Secouer
        var donneeSecouer = MesDonnesSecouer()
        dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        path = dir[0] . stringByAppendingPathComponent("secouer")
        if (NSFileManager.defaultManager().fileExistsAtPath(path)) {
            donneeSecouer = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as MesDonnesSecouer
            if (donneeSecouer.secouer) {
                secouer = true
            }
        }
        else {
            secouer = true
            donneeSecouer.secouer = true
            NSKeyedArchiver.archiveRootObject(donneeSecouer, toFile: path)
        }
        
        // Secouer Rotation
        var donneeSecouerRotation = MesDonnesSecouerRotation()
        dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        path = dir[0] . stringByAppendingPathComponent("secouerRotation")
        if (NSFileManager.defaultManager().fileExistsAtPath(path)) {
            donneeSecouerRotation = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as MesDonnesSecouerRotation
            if (!donneeSecouerRotation.secouerRotation) {
                rotation = false
            }
        }
        else {
            rotation = true
            donneeSecouerRotation.secouerRotation = true
            NSKeyedArchiver.archiveRootObject(donneeSecouerRotation, toFile: path)
        }
        
        // Lancer au demmarage
        var donneelancerAuDemarrage = MesDonnesLancerAuDemarrage()
        dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        path = dir[0] . stringByAppendingPathComponent("lancerAuDemarrage")
        if (NSFileManager.defaultManager().fileExistsAtPath(path)) {
            donneelancerAuDemarrage = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as MesDonnesLancerAuDemarrage
            if (donneelancerAuDemarrage.lancerAuDemarrage) {
                choisir(.Droite)
            }
        }
        else {
            donneelancerAuDemarrage.lancerAuDemarrage = false
            NSKeyedArchiver.archiveRootObject(donneelancerAuDemarrage, toFile: path)
        }
        // Animations
        var donneeAnimations = MesDonnesAnimations()
        dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        path = dir[0] . stringByAppendingPathComponent("animations")
        if (NSFileManager.defaultManager().fileExistsAtPath(path)) {
            donneeAnimations = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as MesDonnesAnimations
            if (!donneeAnimations.animations) {
                animationsAutorisés = false
            }
        }
        else {
            donneeAnimations.animations = true
            NSKeyedArchiver.archiveRootObject(donneeAnimations, toFile: path)
        }
        
        
        // Personnalisation des boutons
        btChoisir.setRoundedRectangle()
        btParametres.setRoundedRectangle()
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
            choisir(.Droite)
        }
    }
    
    @IBAction func choisirActionGauche(sender: AnyObject) {
        choisir(.Gauche)
    }
    @IBAction func choisirActionDroite(sender: AnyObject) {
        choisir(.Droite)
    }
    @IBAction func choisirActionHaut(sender: AnyObject) {
        choisir(.Haut)
    }
    @IBAction func choisirActionBas(sender: AnyObject) {
        choisir(.Bas)
    }
    
    func choisir(sens:SensSwipe) {
        image.hidden = true
        nombre.hidden = false
        if (animationsAutorisés == true) {
            if (!animationEnCours) {
                self.btChoisir.setRoundedRectangleDisabled()
                animationEnCours = true
                if (premierLancer == true) {
                    self.nombreTiré = random() % self.nombreFace! + 1;
                    self.nombre.text = String(self.nombreTiré!)
                    premierLancer = false
                    animationEnCours = false
                    self.btChoisir.setRoundedRectangle()
                }
                else {
                    UIView.animateKeyframesWithDuration(0.5, delay: 0.0, options: UIViewKeyframeAnimationOptions.CalculationModeLinear, animations: { () -> Void in
                        switch sens {
                        case .Droite:
                            self.nombre.frame = CGRectMake(self.nombre.frame.origin.x + 100, self.nombre.frame.origin.y, self.nombre.frame.size.width, self.nombre.frame.size.height)
                        case .Gauche:
                            self.nombre.frame = CGRectMake(self.nombre.frame.origin.x - 100, self.nombre.frame.origin.y, self.nombre.frame.size.width, self.nombre.frame.size.height)
                        case .Haut:
                            self.nombre.frame = CGRectMake(self.nombre.frame.origin.x, self.nombre.frame.origin.y - 100, self.nombre.frame.size.width, self.nombre.frame.size.height)
                        case .Bas:
                            self.nombre.frame = CGRectMake(self.nombre.frame.origin.x, self.nombre.frame.origin.y + 100, self.nombre.frame.size.width, self.nombre.frame.size.height)
                        }
                        }) { (finished: Bool) -> Void in
                            UIView.animateKeyframesWithDuration(0.3, delay: 0.0, options: UIViewKeyframeAnimationOptions.CalculationModeLinear, animations: { () -> Void in
                                switch sens {
                                case .Droite:
                                    self.nombre.frame = CGRectMake(self.nombre.frame.origin.x - 200, self.nombre.frame.origin.y, self.nombre.frame.size.width, self.nombre.frame.size.height)
                                case .Gauche:
                                    self.nombre.frame = CGRectMake(self.nombre.frame.origin.x + 200, self.nombre.frame.origin.y, self.nombre.frame.size.width, self.nombre.frame.size.height)
                                case .Haut:
                                    self.nombre.frame = CGRectMake(self.nombre.frame.origin.x, self.nombre.frame.origin.y + 200, self.nombre.frame.size.width, self.nombre.frame.size.height)
                                case .Bas:
                                    self.nombre.frame = CGRectMake(self.nombre.frame.origin.x, self.nombre.frame.origin.y - 200, self.nombre.frame.size.width, self.nombre.frame.size.height)
                                }
                                }) { (finished: Bool) -> Void in
                                    self.nombreTiré = random() % self.nombreFace! + 1;
                                    self.nombre.text = String(self.nombreTiré!)
                                    UIView.animateKeyframesWithDuration(0.5, delay: 0.0, options: UIViewKeyframeAnimationOptions.CalculationModeLinear, animations: { () -> Void in
                                        switch sens {
                                        case .Droite:
                                            self.nombre.frame = CGRectMake(self.nombre.frame.origin.x + 100, self.nombre.frame.origin.y, self.nombre.frame.size.width, self.nombre.frame.size.height)
                                        case .Gauche:
                                            self.nombre.frame = CGRectMake(self.nombre.frame.origin.x - 100, self.nombre.frame.origin.y, self.nombre.frame.size.width, self.nombre.frame.size.height)
                                        case .Haut:
                                            self.nombre.frame = CGRectMake(self.nombre.frame.origin.x, self.nombre.frame.origin.y - 100, self.nombre.frame.size.width, self.nombre.frame.size.height)
                                        case .Bas:
                                            self.nombre.frame = CGRectMake(self.nombre.frame.origin.x, self.nombre.frame.origin.y + 100, self.nombre.frame.size.width, self.nombre.frame.size.height)
                                        }
                                        }) { (finished: Bool) -> Void in
                                            self.animationEnCours = false
                                            self.btChoisir.setRoundedRectangle()
                                    }
                            }
                    }
                }
            }
        }
        else {
            self.nombreTiré = random() % self.nombreFace! + 1;
            self.nombre.text = String(self.nombreTiré!)
        }
    }
    
    override func shouldAutorotate() -> Bool {
        if (rotation == true) {
            return true
        }
        else {
            if (secouer == true) {
                return false
            }
            else {
                return true
            }
        }
    }
}
