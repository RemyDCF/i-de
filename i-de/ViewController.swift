//
//  ViewController.swift
//  i-de
//
//  Created by DCF on 23/07/2014.
//  Copyright (c) 2014 Da Costa Faro Rémy. All rights reserved.
//

import UIKit
import QuartzCore
import iAd

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

class ViewController: UIViewController, ADBannerViewDelegate {
    @IBOutlet weak var labelNombre: RYLabel!
    @IBOutlet weak var labelFace: UILabel!
    @IBOutlet weak var btChoisir: RYButton!
    var animationEnCours = false
    var bannierePub: ADBannerView! = ADBannerView(adType: ADAdType.Banner)
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        // Nombre face
        var donneeNombreFace = MesDonnesNombreFace()
        var dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        var path = dir[0] . stringByAppendingPathComponent("nombreFace")
        if (NSFileManager.defaultManager().fileExistsAtPath(path)) {
            donneeNombreFace = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as! MesDonnesNombreFace
            AppValues.nombreFace = Int(donneeNombreFace.nombreFace)
            labelFace.text = NSLocalizedString("phraseTirage", tableName: "", bundle: NSBundle.mainBundle(), value: "", comment: "") + String(donneeNombreFace.nombreFace)
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
            donneelancerAuDemarrage = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as! MesDonnesLancerAuDemarrage
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
        var donneeCouleurDe = MesDonnesCouleurDe()
        dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        path = dir[0] . stringByAppendingPathComponent("couleurDe")
        if (NSFileManager.defaultManager().fileExistsAtPath(path)) {
            donneeCouleurDe = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as! MesDonnesCouleurDe
            AppValues.couleurDe = donneeCouleurDe.couleurDe
            labelNombre.borderColor = AppValues.couleurDe
            labelNombre.textColor = AppValues.couleurDe
            labelFace.textColor = AppValues.couleurDe
            btChoisir.borderColor = AppValues.couleurDe
            btChoisir.setTitleColor(AppValues.couleurDe, forState: UIControlState.Normal)
        }
        else {
            AppValues.couleurDe = UIColor(red:0, green:0.64, blue:0.98, alpha:1)
            donneeCouleurDe.couleurDe = UIColor(red:0, green:0.64, blue:0.98, alpha:1)
            NSKeyedArchiver.archiveRootObject(donneeCouleurDe, toFile: path)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        var donneePublicite = MesDonnesPublicite()
        var dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        var path = dir[0] . stringByAppendingPathComponent("publicite")
        if (NSFileManager.defaultManager().fileExistsAtPath(path)) {
            donneePublicite = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as MesDonnesPublicite
            if (donneePublicite.publicite) {
                AppValues.valeurMouvement -= 10
                self.canDisplayBannerAds = true
                bannierePub.delegate = self
                bannierePub.hidden = true
            }
            else {
                self.canDisplayBannerAds = false
                bannierePub.delegate = self
                bannierePub.hidden = true
            }
        }
        else {
            donneePublicite.publicite = true
            var erreur = NSKeyedArchiver.archiveRootObject(donneePublicite, toFile: path)
        }
        */
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if (userDefaults.boolForKey("pub") == true) {
            AppValues.valeurMouvement -= 10
            self.canDisplayBannerAds = true
            bannierePub.delegate = self
            bannierePub.hidden = true
        }
        else {
            self.canDisplayBannerAds = false
            bannierePub.delegate = self
            bannierePub.hidden = true
            println("a")
        }
        // Mouvenent animation
        if (UIDevice().userInterfaceIdiom == .Pad) {
            AppValues.valeurMouvement *= 2
        }
        
        // Secouer Animations
        var donneeSecouerAnimations = MesDonnesSecouerAnimations()
        var dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        var path = dir[0] . stringByAppendingPathComponent("secouerAnimations")
        if (NSFileManager.defaultManager().fileExistsAtPath(path)) {
            donneeSecouerAnimations = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as! MesDonnesSecouerAnimations
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
            donneeAnimations = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as! MesDonnesAnimations
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
    
    func bannerViewDidLoadAd(banner: ADBannerView!) {
        self.bannierePub.hidden = false
    }
    
    func bannerViewActionShouldBegin(banner: ADBannerView!, willLeaveApplication willLeave: Bool) -> Bool {
        return willLeave
    }
    
    func bannerView(banner: ADBannerView!, didFailToReceiveAdWithError error: NSError!) {
        self.bannierePub.hidden = true
    }
}
