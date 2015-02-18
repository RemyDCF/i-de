//
//  ViewController.swift
//  i-de
//
//  Created by DCF on 23/07/2014.
//  Copyright (c) 2014 Da Costa Faro Rémy. All rights reserved.
//

import UIKit
import QuartzCore

enum SensSwipe {
    case Haut
    case Bas
    case Droite
    case Gauche
    case Aucun
}

enum SenderChoisir {
    case Secouer
    case Tap
    case Autre
}

class ViewController: UIViewController {
    @IBOutlet weak var labelNombre: RYLabel!
    @IBOutlet weak var labelFace: UILabel!
    @IBOutlet weak var btChoisir: RYButton!
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        // Nombre face
        var donneeNombreFace = MesDonnesNombreFace()
        var dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        var path = dir[0] . stringByAppendingPathComponent("nombreFace")
        if (NSFileManager.defaultManager().fileExistsAtPath(path)) {
            donneeNombreFace = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as MesDonnesNombreFace
            AppValues.nombreFace = Int(donneeNombreFace.nombreFace)
            labelFace.text = "Tirage d'un nombre entre 1 et " + String(donneeNombreFace.nombreFace)
        }
        else {
            donneeNombreFace.nombreFace = 6
            NSKeyedArchiver.archiveRootObject(donneeNombreFace, toFile: path)
        }
        // Lancer au demmarage
        var donneelancerAuDemarrage = MesDonnesLancerAuDemarrage()
        dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        path = dir[0] . stringByAppendingPathComponent("lancerAuDemarrage")
        if (NSFileManager.defaultManager().fileExistsAtPath(path)) {
            donneelancerAuDemarrage = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as MesDonnesLancerAuDemarrage
            if (donneelancerAuDemarrage.lancerAuDemarrage) {
                choisirTap(self)
            }
            else {
                labelNombre.text = ""
            }
        }
        else {
            donneelancerAuDemarrage.lancerAuDemarrage = false
            NSKeyedArchiver.archiveRootObject(donneelancerAuDemarrage, toFile: path)
        }
        // Secouer
        var donneeSecouer = MesDonnesSecouer()
        dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        path = dir[0] . stringByAppendingPathComponent("secouer")
        if (NSFileManager.defaultManager().fileExistsAtPath(path)) {
            donneeSecouer = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as MesDonnesSecouer
            if (donneeSecouer.secouer) {
                AppValues.secouer = true
            }
        }
        else {
            AppValues.secouer = true
            donneeSecouer.secouer = true
            NSKeyedArchiver.archiveRootObject(donneeSecouer, toFile: path)
        }
        // Couleur De
        var donneeCouleurDe = MesDonnesCouleurDe()
        dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        path = dir[0] . stringByAppendingPathComponent("couleurDe")
        if (NSFileManager.defaultManager().fileExistsAtPath(path)) {
            donneeCouleurDe = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as MesDonnesCouleurDe
            AppValues.couleurDe = donneeCouleurDe.couleurDe
            labelNombre.borderColor = AppValues.couleurDe
            labelNombre.textColor = AppValues.couleurDe
            labelFace.textColor = AppValues.couleurDe
            btChoisir.borderColor = AppValues.couleurDe
            btChoisir.titleLabel?.textColor = AppValues.couleurDe
        }
        else {
            AppValues.couleurDe = UIColor(red:0, green:0.64, blue:0.98, alpha:1)
            donneeCouleurDe.couleurDe = UIColor(red:0, green:0.64, blue:0.98, alpha:1)
            NSKeyedArchiver.archiveRootObject(donneeCouleurDe, toFile: path)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Mouvenent animation
        if (UIDevice().userInterfaceIdiom == .Pad) {
            AppValues.valeurMouvement *= 2
        }
        
        // Secouer Animations
        var donneeSecouerAnimations = MesDonnesSecouerAnimations()
        var dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        var path = dir[0] . stringByAppendingPathComponent("secouerAnimations")
        if (NSFileManager.defaultManager().fileExistsAtPath(path)) {
            donneeSecouerAnimations = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as MesDonnesSecouerAnimations
            if (!donneeSecouerAnimations.secouerAnimations) {
                AppValues.animationsSecouerAutorisés = false
            }
        }
        else {
            AppValues.animationsSecouerAutorisés = false
            donneeSecouerAnimations.secouerAnimations = false
            NSKeyedArchiver.archiveRootObject(donneeSecouerAnimations, toFile: path)
        }
        
        // Animations
        var donneeAnimations = MesDonnesAnimations()
        dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        path = dir[0] . stringByAppendingPathComponent("animations")
        if (NSFileManager.defaultManager().fileExistsAtPath(path)) {
            donneeAnimations = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as MesDonnesAnimations
            if (!donneeAnimations.animations) {
                AppValues.animationsAutorisés = false
            }
        }
        else {
            donneeAnimations.animations = true
            NSKeyedArchiver.archiveRootObject(donneeAnimations, toFile: path)
        }
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
        if (AppValues.secouer == true) {
            choisir(.Droite, sender: .Secouer)
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
    @IBAction func choisirTap(sender: AnyObject) {
        choisir(.Aucun, sender: .Tap)
    }
    func animationFondu() {
        var anim = RYAnimation()
        CATransaction.begin()
        CATransaction.setCompletionBlock { () -> Void in
            AppValues.nombreTiré = Int((arc4random() % UInt32(AppValues.nombreFace!)) + 1)
            self.labelNombre.text = String(AppValues.nombreTiré!)
            self.labelNombre.layer.addAnimation(anim.setOpacity(0, toOpacity: 1, duration: 0.5), forKey: "opacity")
        }
        labelNombre.layer.addAnimation(anim.setOpacity(1, toOpacity: 0, duration: 0.5), forKey: "opacity")
        CATransaction.commit()
        
    }
    func choisir(sens:SensSwipe, sender:SenderChoisir = .Autre) {
        if (AppValues.premierLancer == true) {
            // Si c'est le premier lancer
            if (AppValues.animationsAutorisés == true) {
                animationFondu()
                AppValues.premierLancer = false
            }
            else {
                AppValues.nombreTiré = Int((arc4random() % UInt32(AppValues.nombreFace!)) + 1)
                self.labelNombre.text = String(AppValues.nombreTiré!)
                self.labelNombre.alpha = 1.0
            }
        }
        else if (UIDevice.currentDevice().orientation == UIDeviceOrientation.LandscapeLeft) {
            // Si c'est le premier lancer
            if (AppValues.animationsAutorisés == true) {
                animationFondu()
            }
            else {
                AppValues.nombreTiré = Int((arc4random() % UInt32(AppValues.nombreFace!)) + 1)
                self.labelNombre.text = String(AppValues.nombreTiré!)
                self.labelNombre.alpha = 1.0
            }
        }
        else if (UIDevice.currentDevice().orientation == UIDeviceOrientation.LandscapeRight) {
            // Si c'est le premier lancer
            if (AppValues.animationsAutorisés == true) {
                animationFondu()
            }
            else {
                AppValues.nombreTiré = Int((arc4random() % UInt32(AppValues.nombreFace!)) + 1)
                self.labelNombre.text = String(AppValues.nombreTiré!)
                self.labelNombre.alpha = 1.0
            }
        }
        else {
            if (sender == .Secouer) {
                // Si on secoue
                if (AppValues.animationsSecouerAutorisés == true) {
                    animationFondu()
                }
                else {
                    AppValues.nombreTiré = Int((arc4random() % UInt32(AppValues.nombreFace!)) + 1)
                    self.labelNombre.text = String(AppValues.nombreTiré!)
                    AppValues.animationEnCours = false
                }
            }
            else if (sender == .Tap) {
                // Si on "Tap"
                if (AppValues.animationsAutorisés == true) {
                    animationFondu()
                }
                else {
                    AppValues.nombreTiré = Int((arc4random() % UInt32(AppValues.nombreFace!)) + 1)
                    self.labelNombre.text = String(AppValues.nombreTiré!)
                    AppValues.animationEnCours = false
                    //self.btChoisir.setRoundedRectangle()
                }
            }
            else {
                // Si on "Slide"
                if (AppValues.animationsAutorisés == true) {
                    AppValues.animationEnCours = true
                    animerDe(sens)
                }
                else {
                    AppValues.nombreTiré = Int((arc4random() % UInt32(AppValues.nombreFace!)) + 1)
                    self.labelNombre.text = String(AppValues.nombreTiré!)
                    AppValues.animationEnCours = false
                    //self.btChoisir.setRoundedRectangle()
                }
            }
        }
    }
    
    func animerDe(sens:SensSwipe) {
        UIView.animateKeyframesWithDuration(0.5, delay: 0.0, options: UIViewKeyframeAnimationOptions.CalculationModeLinear, animations: { () -> Void in
            switch sens {
            case .Droite:
                self.labelNombre.frame = CGRectMake(self.labelNombre.frame.origin.x + AppValues.valeurMouvement, self.labelNombre.frame.origin.y, self.labelNombre.frame.size.width, self.labelNombre.frame.size.height)
            case .Gauche:
                self.labelNombre.frame = CGRectMake(self.labelNombre.frame.origin.x - AppValues.valeurMouvement, self.labelNombre.frame.origin.y, self.labelNombre.frame.size.width, self.labelNombre.frame.size.height)
            case .Haut:
                self.labelNombre.frame = CGRectMake(self.labelNombre.frame.origin.x, self.labelNombre.frame.origin.y - AppValues.valeurMouvement, self.labelNombre.frame.size.width, self.labelNombre.frame.size.height)
            case .Bas:
                self.labelNombre.frame = CGRectMake(self.labelNombre.frame.origin.x, self.labelNombre.frame.origin.y + AppValues.valeurMouvement, self.labelNombre.frame.size.width, self.labelNombre.frame.size.height)
            default:
                break
            }
            }) { (finished: Bool) -> Void in
                UIView.animateKeyframesWithDuration(0.3, delay: 0.0, options: UIViewKeyframeAnimationOptions.CalculationModeLinear, animations: { () -> Void in
                    switch sens {
                    case .Droite:
                        self.labelNombre.frame = CGRectMake(self.labelNombre.frame.origin.x - AppValues.valeurMouvement * 2, self.labelNombre.frame.origin.y, self.labelNombre.frame.size.width, self.labelNombre.frame.size.height)
                    case .Gauche:
                        self.labelNombre.frame = CGRectMake(self.labelNombre.frame.origin.x + AppValues.valeurMouvement * 2, self.labelNombre.frame.origin.y, self.labelNombre.frame.size.width, self.labelNombre.frame.size.height)
                    case .Haut:
                        self.labelNombre.frame = CGRectMake(self.labelNombre.frame.origin.x, self.labelNombre.frame.origin.y + AppValues.valeurMouvement * 2, self.labelNombre.frame.size.width, self.labelNombre.frame.size.height)
                    case .Bas:
                        self.labelNombre.frame = CGRectMake(self.labelNombre.frame.origin.x, self.labelNombre.frame.origin.y - AppValues.valeurMouvement * 2, self.labelNombre.frame.size.width, self.labelNombre.frame.size.height)
                    default:
                        break
                    }
                    }) { (finished: Bool) -> Void in
                        UIView.animateKeyframesWithDuration(0.5, delay: 0.0, options: UIViewKeyframeAnimationOptions.CalculationModeLinear, animations: { () -> Void in
                            AppValues.nombreTiré = Int((arc4random() % UInt32(AppValues.nombreFace!)) + 1)
                            self.labelNombre.text = String(AppValues.nombreTiré!)
                            switch sens {
                            case .Droite:
                                self.labelNombre.frame = CGRectMake(self.labelNombre.frame.origin.x + AppValues.valeurMouvement, self.labelNombre.frame.origin.y, self.labelNombre.frame.size.width, self.labelNombre.frame.size.height)
                            case .Gauche:
                                self.labelNombre.frame = CGRectMake(self.labelNombre.frame.origin.x - AppValues.valeurMouvement, self.labelNombre.frame.origin.y, self.labelNombre.frame.size.width, self.labelNombre.frame.size.height)
                            case .Haut:
                                self.labelNombre.frame = CGRectMake(self.labelNombre.frame.origin.x, self.labelNombre.frame.origin.y - AppValues.valeurMouvement, self.labelNombre.frame.size.width, self.labelNombre.frame.size.height)
                            case .Bas:
                                self.labelNombre.frame = CGRectMake(self.labelNombre.frame.origin.x, self.labelNombre.frame.origin.y + AppValues.valeurMouvement, self.labelNombre.frame.size.width, self.labelNombre.frame.size.height)
                            default:
                                break
                            }
                            }) { (finished: Bool) -> Void in
                                AppValues.animationEnCours = false
                                //self.btChoisir.setRoundedRectangle()
                        }
                }
        }
    }
}
