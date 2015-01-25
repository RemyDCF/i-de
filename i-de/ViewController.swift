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
    case Aucun
}

enum SenderChoisir {
    case Secouer
    case Tap
    case Autre
}

class ViewController: UIViewController {
    @IBOutlet weak var labelNombre: UILabel!
    @IBOutlet weak var btChoisir: UIButton!
    @IBOutlet weak var labelFace: UILabel!
    @IBOutlet weak var image: UIImageView!
    
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
        
        
        // Personnalisation des boutons
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
    func choisir(sens:SensSwipe, sender:SenderChoisir = .Autre) {
        if (AppValues.premierLancer == true) {
            // Si c'est le premier lancer
            self.btChoisir.setRoundedRectangleDisabled()
            if (AppValues.animationsAutorisés == true) {
                UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                    }, completion: { (finished: Bool) -> Void in
                        AppValues.nombreTiré = random() % AppValues.nombreFace! + 1;
                        self.labelNombre.text = String(AppValues.nombreTiré!)
                        UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                            self.labelNombre.alpha = 1.0
                            }, completion: { (finished: Bool) -> Void in
                                AppValues.premierLancer = false
                                AppValues.animationEnCours = false
                                self.btChoisir.setRoundedRectangle()
                        })
                })
            }
            else {
                AppValues.nombreTiré = random() % AppValues.nombreFace! + 1;
                self.labelNombre.text = String(AppValues.nombreTiré!)
                self.labelNombre.alpha = 1.0
            }
        }
        else if (UIDevice.currentDevice().orientation == UIDeviceOrientation.LandscapeLeft) {
            // Si c'est le premier lancer
            self.btChoisir.setRoundedRectangleDisabled()
            if (AppValues.animationsAutorisés == true) {
                println("kf")
                UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                    }, completion: { (finished: Bool) -> Void in
                        AppValues.nombreTiré = random() % AppValues.nombreFace! + 1;
                        self.labelNombre.text = String(AppValues.nombreTiré!)
                        UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                            self.labelNombre.alpha = 1.0
                            }, completion: { (finished: Bool) -> Void in
                                AppValues.premierLancer = false
                                AppValues.animationEnCours = false
                                self.btChoisir.setRoundedRectangle()
                        })
                })
            }
            else {
                AppValues.nombreTiré = random() % AppValues.nombreFace! + 1;
                self.labelNombre.text = String(AppValues.nombreTiré!)
                self.labelNombre.alpha = 1.0
            }
        }
        else if (UIDevice.currentDevice().orientation == UIDeviceOrientation.LandscapeRight) {
            // Si c'est le premier lancer
            self.btChoisir.setRoundedRectangleDisabled()
            if (AppValues.animationsAutorisés == true) {
                println("kf")
                UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                    }, completion: { (finished: Bool) -> Void in
                        AppValues.nombreTiré = random() % AppValues.nombreFace! + 1;
                        self.labelNombre.text = String(AppValues.nombreTiré!)
                        UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                            self.labelNombre.alpha = 1.0
                            }, completion: { (finished: Bool) -> Void in
                                AppValues.premierLancer = false
                                AppValues.animationEnCours = false
                                self.btChoisir.setRoundedRectangle()
                        })
                })
            }
            else {
                AppValues.nombreTiré = random() % AppValues.nombreFace! + 1;
                self.labelNombre.text = String(AppValues.nombreTiré!)
                self.labelNombre.alpha = 1.0
            }
        }
        else {
            self.btChoisir.setRoundedRectangleDisabled()
            // Sinon...
            if (!AppValues.animationEnCours) {
                // Il faut que l'animation soit en cours
                AppValues.animationEnCours = true
                if (sender == .Secouer) {
                    // Si on secoue
                    if (AppValues.animationsSecouerAutorisés == true) {
                        UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                            self.labelNombre.alpha = 0.0
                            }, completion: { (finished: Bool) -> Void in
                                AppValues.nombreTiré = random() % AppValues.nombreFace! + 1;
                                self.labelNombre.text = String(AppValues.nombreTiré!)
                                UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                                    self.labelNombre.alpha = 1.0
                                    }, completion: { (finished: Bool) -> Void in
                                        AppValues.animationEnCours = false
                                        AppValues.premierLancer = false
                                        AppValues.animationEnCours = false
                                        self.btChoisir.setRoundedRectangle()
                                })
                        })
                    }
                    else {
                        AppValues.nombreTiré = random() % AppValues.nombreFace! + 1;
                        self.labelNombre.text = String(AppValues.nombreTiré!)
                        AppValues.animationEnCours = false
                        self.btChoisir.setRoundedRectangle()
                    }
                }
                else if (sender == .Tap) {
                    // Si on "Tap"
                    if (AppValues.animationsAutorisés == true) {
                        UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                            self.labelNombre.alpha = 0.0
                            }, completion: { (finished: Bool) -> Void in
                                AppValues.nombreTiré = random() % AppValues.nombreFace! + 1;
                                self.labelNombre.text = String(AppValues.nombreTiré!)
                                UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                                    self.labelNombre.alpha = 1.0
                                    }, completion: { (finished: Bool) -> Void in
                                        AppValues.animationEnCours = false
                                        AppValues.premierLancer = false
                                        AppValues.animationEnCours = false
                                        self.btChoisir.setRoundedRectangle()
                                })
                        })
                    }
                    else {
                        AppValues.nombreTiré = random() % AppValues.nombreFace! + 1;
                        self.labelNombre.text = String(AppValues.nombreTiré!)
                        AppValues.animationEnCours = false
                        self.btChoisir.setRoundedRectangle()
                    }
                }
                else {
                    // Si on "Slide"
                    if (AppValues.animationsAutorisés == true) {
                        AppValues.animationEnCours = true
                        animerDe(sens)
                    }
                    else {
                        AppValues.nombreTiré = random() % AppValues.nombreFace! + 1;
                        self.labelNombre.text = String(AppValues.nombreTiré!)
                        AppValues.animationEnCours = false
                        self.btChoisir.setRoundedRectangle()
                    }
                }
            }
        }
    }
    
    func animerDe(sens:SensSwipe) {
        UIView.animateKeyframesWithDuration(0.5, delay: 0.0, options: UIViewKeyframeAnimationOptions.CalculationModeLinear, animations: { () -> Void in
            switch sens {
            case .Droite:
                self.labelNombre.frame = CGRectMake(self.labelNombre.frame.origin.x + AppValues.valeurMouvement, self.labelNombre.frame.origin.y, self.labelNombre.frame.size.width, self.labelNombre.frame.size.height)
                self.image.frame = CGRectMake(self.image.frame.origin.x + AppValues.valeurMouvement, self.image.frame.origin.y, self.image.frame.size.width, self.image.frame.size.height)
            case .Gauche:
                self.labelNombre.frame = CGRectMake(self.labelNombre.frame.origin.x - AppValues.valeurMouvement, self.labelNombre.frame.origin.y, self.labelNombre.frame.size.width, self.labelNombre.frame.size.height)
                self.image.frame = CGRectMake(self.image.frame.origin.x - AppValues.valeurMouvement, self.image.frame.origin.y, self.image.frame.size.width, self.image.frame.size.height)
            case .Haut:
                self.labelNombre.frame = CGRectMake(self.labelNombre.frame.origin.x, self.labelNombre.frame.origin.y - AppValues.valeurMouvement, self.labelNombre.frame.size.width, self.labelNombre.frame.size.height)
                self.image.frame = CGRectMake(self.image.frame.origin.x, self.image.frame.origin.y - AppValues.valeurMouvement, self.image.frame.size.width, self.image.frame.size.height)
            case .Bas:
                self.labelNombre.frame = CGRectMake(self.labelNombre.frame.origin.x, self.labelNombre.frame.origin.y + AppValues.valeurMouvement, self.labelNombre.frame.size.width, self.labelNombre.frame.size.height)
                self.image.frame = CGRectMake(self.image.frame.origin.x, self.image.frame.origin.y + AppValues.valeurMouvement, self.image.frame.size.width, self.image.frame.size.height)
            default:
                break
            }
            }) { (finished: Bool) -> Void in
                UIView.animateKeyframesWithDuration(0.3, delay: 0.0, options: UIViewKeyframeAnimationOptions.CalculationModeLinear, animations: { () -> Void in
                    switch sens {
                    case .Droite:
                        self.labelNombre.frame = CGRectMake(self.labelNombre.frame.origin.x - AppValues.valeurMouvement * 2, self.labelNombre.frame.origin.y, self.labelNombre.frame.size.width, self.labelNombre.frame.size.height)
                        self.image.frame = CGRectMake(self.image.frame.origin.x - AppValues.valeurMouvement * 2, self.image.frame.origin.y, self.image.frame.size.width, self.image.frame.size.height)
                    case .Gauche:
                        self.labelNombre.frame = CGRectMake(self.labelNombre.frame.origin.x + AppValues.valeurMouvement * 2, self.labelNombre.frame.origin.y, self.labelNombre.frame.size.width, self.labelNombre.frame.size.height)
                        self.image.frame = CGRectMake(self.image.frame.origin.x + AppValues.valeurMouvement * 2, self.image.frame.origin.y, self.image.frame.size.width, self.image.frame.size.height)
                    case .Haut:
                        self.labelNombre.frame = CGRectMake(self.labelNombre.frame.origin.x, self.labelNombre.frame.origin.y + AppValues.valeurMouvement * 2, self.labelNombre.frame.size.width, self.labelNombre.frame.size.height)
                        self.image.frame = CGRectMake(self.image.frame.origin.x, self.image.frame.origin.y + AppValues.valeurMouvement * 2, self.image.frame.size.width, self.image.frame.size.height)
                    case .Bas:
                        self.labelNombre.frame = CGRectMake(self.labelNombre.frame.origin.x, self.labelNombre.frame.origin.y - AppValues.valeurMouvement * 2, self.labelNombre.frame.size.width, self.labelNombre.frame.size.height)
                        self.image.frame = CGRectMake(self.image.frame.origin.x, self.image.frame.origin.y - AppValues.valeurMouvement * 2, self.image.frame.size.width, self.image.frame.size.height)
                    default:
                        break
                    }
                    }) { (finished: Bool) -> Void in
                        UIView.animateKeyframesWithDuration(0.5, delay: 0.0, options: UIViewKeyframeAnimationOptions.CalculationModeLinear, animations: { () -> Void in
                            AppValues.nombreTiré = random() % AppValues.nombreFace! + 1;
                            self.labelNombre.text = String(AppValues.nombreTiré!)
                            switch sens {
                            case .Droite:
                                self.labelNombre.frame = CGRectMake(self.labelNombre.frame.origin.x + AppValues.valeurMouvement, self.labelNombre.frame.origin.y, self.labelNombre.frame.size.width, self.labelNombre.frame.size.height)
                                self.image.frame = CGRectMake(self.image.frame.origin.x + AppValues.valeurMouvement, self.image.frame.origin.y, self.image.frame.size.width, self.image.frame.size.height)
                            case .Gauche:
                                self.labelNombre.frame = CGRectMake(self.labelNombre.frame.origin.x - AppValues.valeurMouvement, self.labelNombre.frame.origin.y, self.labelNombre.frame.size.width, self.labelNombre.frame.size.height)
                                self.image.frame = CGRectMake(self.image.frame.origin.x - AppValues.valeurMouvement, self.image.frame.origin.y, self.image.frame.size.width, self.image.frame.size.height)
                            case .Haut:
                                self.labelNombre.frame = CGRectMake(self.labelNombre.frame.origin.x, self.labelNombre.frame.origin.y - AppValues.valeurMouvement, self.labelNombre.frame.size.width, self.labelNombre.frame.size.height)
                                self.image.frame = CGRectMake(self.image.frame.origin.x, self.image.frame.origin.y - AppValues.valeurMouvement, self.image.frame.size.width, self.image.frame.size.height)
                            case .Bas:
                                self.labelNombre.frame = CGRectMake(self.labelNombre.frame.origin.x, self.labelNombre.frame.origin.y + AppValues.valeurMouvement, self.labelNombre.frame.size.width, self.labelNombre.frame.size.height)
                                self.image.frame = CGRectMake(self.image.frame.origin.x, self.image.frame.origin.y + AppValues.valeurMouvement, self.image.frame.size.width, self.image.frame.size.height)
                            default:
                                break
                            }
                            }) { (finished: Bool) -> Void in
                                AppValues.animationEnCours = false
                                self.btChoisir.setRoundedRectangle()
                        }
                }
        }
    }
}
