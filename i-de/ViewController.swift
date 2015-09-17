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
    let defaults = NSUserDefaults.standardUserDefaults()
    var animationEnCours = false
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        // Nombre face
        let nombreFace = defaults.integerForKey(NSUserDefaultsKeys.NombreFace)
        if nombreFace != 0 {
            AppValues.nombreFace = Int(nombreFace)
            labelFace.text = NSLocalizedString("phraseTirage", tableName: "", bundle: NSBundle.mainBundle(), value: "", comment: "") + String(nombreFace)
        }
        else {
            AppValues.nombreFace = Int(6)
            labelFace.text = NSLocalizedString("phraseTirage", tableName: "", bundle: NSBundle.mainBundle(), value: "", comment: "") + String(6)
            defaults.setInteger(6, forKey: NSUserDefaultsKeys.NombreFace)
        }
        // Lancer au demmarage
        let lancerAuDemmarageDonnee = defaults.boolForKey(NSUserDefaultsKeys.LancerAuDemmarage)
        if (lancerAuDemmarageDonnee) {
            choisirTap(self)
        }
        else {
            labelNombre.text = ""
        }
        // Secouer
        var donneeSecouer = MesDonnesSecouer()
        var dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let path = dir[0] + "secouer"
        if (NSFileManager.defaultManager().fileExistsAtPath(path)) {
            donneeSecouer = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as! MesDonnesSecouer
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
        let couleurDe = defaults.colorForKey(NSUserDefaultsKeys.CouleurDe)
        if (couleurDe != nil) {
            AppValues.couleurDe = couleurDe!
            labelNombre.borderColor = couleurDe!
            labelNombre.textColor = couleurDe
            labelFace.textColor = couleurDe
            btChoisir.borderColor = couleurDe!
            btChoisir.setTitleColor(couleurDe, forState: UIControlState.Normal)
        }
        else {
            AppValues.couleurDe = UIColor(red:0, green:0.64, blue:0.98, alpha:1)
            defaults.setColor(UIColor(red:0, green:0.64, blue:0.98, alpha:1), forKey: NSUserDefaultsKeys.CouleurDe)
        }
        // Secouer Animations
        let secouerAnimations = defaults.boolForKey(NSUserDefaultsKeys.SecouerAnimations)
        if (!secouerAnimations) {
            AppValues.animationsSecouerAutorisés = false
        }
        // Animations
        let animations = defaults.boolForKey(NSUserDefaultsKeys.Animations)
        if (!animations) {
            AppValues.animationsAutorisés = false
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Mouvenent animation
        if (UIDevice().userInterfaceIdiom == .Pad) {
            AppValues.valeurMouvement *= 2
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func canResignFirstResponder() -> Bool {
        return true
    }
    
    override func motionBegan(motion: UIEventSubtype, withEvent event: UIEvent?) {}
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if (AppValues.secouer == true) {
            choisir(.Aucun, sender: .Secouer)
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
        UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            self.labelNombre.alpha = 0.0
            }, completion: { (finished: Bool) -> Void in
                AppValues.nombreTiré = Int((arc4random() % UInt32(AppValues.nombreFace!)) + 1)
                self.labelNombre.text = String(AppValues.nombreTiré!)
                UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                    self.labelNombre.alpha = 1.0
                    }, completion: { (finished: Bool) -> Void in
                        AppValues.premierLancer = false
                        self.animationEnCours = false
                })
        })
    }
    func choisir(sens:SensSwipe, sender:SenderChoisir = .Autre) {
        if animationEnCours == false {
            animationEnCours = true
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
                    }
                }
                else {
                    // Si on "Slide"
                    if (AppValues.animationsAutorisés == true) {
                        animerDe(sens)
                    }
                    else {
                        AppValues.nombreTiré = Int((arc4random() % UInt32(AppValues.nombreFace!)) + 1)
                        self.labelNombre.text = String(AppValues.nombreTiré!)
                    }
                }
            }
            animationEnCours = false
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
                                self.animationEnCours = false
                        }
                }
        }
    }
}
