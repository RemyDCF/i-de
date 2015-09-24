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
    @IBOutlet weak var labelNombre: RYSpringLabel!
    @IBOutlet weak var labelFace: UILabel!
    @IBOutlet weak var btChoisir: RYButton!
    let defaults = NSUserDefaults.standardUserDefaults()
    var animationEnCours = false
    var typeAnimations = "shake"
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
            choisir()
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
        // Type Animations
        let typeAnimations = defaults.stringForKeySwift(NSUserDefaultsKeys.TypeAnimations)
        if ((typeAnimations) != nil) {
            self.typeAnimations = typeAnimations!
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
            choisir(true)
        }
    }
    @IBAction func choisirIBAction(sender: AnyObject) {
        choisir()
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
    func choisir(secouer: Bool! = false) {
        if secouer == false {
            if (AppValues.animationsAutorisés == true) {
                animer()
            }
            else {
                AppValues.nombreTiré = Int((arc4random() % UInt32(AppValues.nombreFace!)) + 1)
                self.labelNombre.text = String(AppValues.nombreTiré!)
            }
        }
        else {
            if (AppValues.animationsSecouerAutorisés == true) {
                animer()
            }
            else {
                AppValues.nombreTiré = Int((arc4random() % UInt32(AppValues.nombreFace!)) + 1)
                self.labelNombre.text = String(AppValues.nombreTiré!)
            }
        }
    }
    
    func animer() {
        
        labelNombre.animation = self.typeAnimations
        labelNombre.curve = "easeIn"
        labelNombre.delay = CGFloat(defaults.floatForKey(NSUserDefaultsKeys.AnimationsDelay))
        labelNombre.duration = CGFloat(defaults.floatForKey(NSUserDefaultsKeys.AnimationsDuration))
        labelNombre.force = CGFloat(defaults.floatForKey(NSUserDefaultsKeys.AnimationsForce))
        labelNombre.damping = CGFloat(defaults.floatForKey(NSUserDefaultsKeys.AnimationsDamping))
        labelNombre.velocity = CGFloat(defaults.floatForKey(NSUserDefaultsKeys.AnimationsVelocity))
        labelNombre.rotate = CGFloat(defaults.floatForKey(NSUserDefaultsKeys.AnimationsRotate))
        AppValues.nombreTiré = Int((arc4random() % UInt32(AppValues.nombreFace!)) + 1)
        self.labelNombre.text = String(AppValues.nombreTiré!)
        labelNombre.animate()

    }
}
