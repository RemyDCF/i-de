//
//  ChoixFace.swift
//  i-de
//
//  Created by DCF on 27/07/2014.
//  Copyright (c) 2014 Da Costa Faro Rémy. All rights reserved.
//

import UIKit

class Parametres: UITableViewController {
    @IBOutlet weak var switchRotation: UISwitch!
    @IBOutlet weak var choixDe: UISwitch!
    @IBOutlet weak var segmentChoixNombreFace: UISegmentedControl!
    @IBOutlet weak var labelNombreFace: UILabel!
    @IBOutlet weak var lancerAuDemarrage: UISwitch!
    @IBOutlet weak var animations: UISwitch!
    @IBOutlet weak var boutonAutre: UIButton!
    @IBOutlet weak var boutonParametreSecouer: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Personnalisation des boutons
        boutonAutre.setRoundedRectangle()
        boutonParametreSecouer.setRoundedRectangle()
        boutonParametreSecouer.setImage(UIImage(named: "parametreDisabled"), forState: UIControlState.Disabled)
        // Mise en place des données existantes
        // Secouer
        var donneeSecouer = MesDonnesSecouer()
        var dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        var path = dir[0] . stringByAppendingPathComponent("secouer")
        if (NSFileManager.defaultManager().fileExistsAtPath(path)) {
            donneeSecouer = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as MesDonnesSecouer
            if (!donneeSecouer.secouer) {
                choixDe.setOn(false, animated: true)
                boutonParametreSecouer.setRoundedRectangleDisabled()
            }
        }
        else {
            donneeSecouer.secouer = true
            var erreur = NSKeyedArchiver.archiveRootObject(donneeSecouer, toFile: path)
            
            var donneeSecouerAnimations = MesDonnesSecouerAnimations()
            dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
            path = dir[0] . stringByAppendingPathComponent("secouerAnimations")
            donneeSecouerAnimations.secouerAnimations = false
            erreur = NSKeyedArchiver.archiveRootObject(donneeSecouerAnimations, toFile: path)
            
            var donneeRotation = MesDonnesRotation()
            dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
            path = dir[0] . stringByAppendingPathComponent("rotation")
            donneeRotation.rotation = false
            erreur = NSKeyedArchiver.archiveRootObject(donneeRotation, toFile: path)
        }
        // Lancer au demmarage
        var donneelancerAuDemarrage = MesDonnesLancerAuDemarrage()
        dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        path = dir[0] . stringByAppendingPathComponent("lancerAuDemarrage")
        if (NSFileManager.defaultManager().fileExistsAtPath(path)) {
            donneelancerAuDemarrage = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as MesDonnesLancerAuDemarrage
            if (donneelancerAuDemarrage.lancerAuDemarrage) {
                lancerAuDemarrage.setOn(true, animated: true)
            }
        }
        else {
            donneelancerAuDemarrage.lancerAuDemarrage = false
            var dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
            var path = dir[0] . stringByAppendingPathComponent("lancerAuDemarrage")
            var erreur = NSKeyedArchiver.archiveRootObject(donneelancerAuDemarrage, toFile: path)
        }
        // Animations
        var donneeAnimations = MesDonnesAnimations()
        dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        path = dir[0] . stringByAppendingPathComponent("animations")
        if (NSFileManager.defaultManager().fileExistsAtPath(path)) {
            donneeAnimations = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as MesDonnesAnimations
            if (donneeAnimations.animations) {
                animations.setOn(true, animated: true)
            }
        }
        else {
            donneeAnimations.animations = true
            var dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
            var path = dir[0] . stringByAppendingPathComponent("animations")
            var erreur = NSKeyedArchiver.archiveRootObject(donneeAnimations, toFile: path)
        }
        // Rotation
        var donneeRotation = MesDonnesRotation()
        dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        path = dir[0] . stringByAppendingPathComponent("rotation")
        if (NSFileManager.defaultManager().fileExistsAtPath(path)) {
            donneeRotation = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as MesDonnesRotation
            if (!donneeRotation.rotation) {
                switchRotation.setOn(false, animated: true)
            }
        }
        else {
            donneeRotation.rotation = true
            var erreur = NSKeyedArchiver.archiveRootObject(donneeRotation, toFile: path)
        }
        mettreAJourFaceDe()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func choixTypeLanceDeChange(sender: AnyObject) {
        // Le switch de Secouer est changé
        var donnee = MesDonnesSecouer()
        if (choixDe.on) {
            donnee.secouer = true
            boutonParametreSecouer.setRoundedRectangle()
        }
        else {
            donnee.secouer = false
            boutonParametreSecouer.setRoundedRectangleDisabled()
        }
        var dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        var path = dir[0] . stringByAppendingPathComponent("secouer")
        NSKeyedArchiver.archiveRootObject(donnee, toFile: path)
    }

    
    @IBAction func lancerDemarrageChange(sender: AnyObject) {
        // Le switch de lancer au demarrage est changé
        var donnee = MesDonnesLancerAuDemarrage()
        if (lancerAuDemarrage.on) {
            donnee.lancerAuDemarrage = true
        }
        else {
            donnee.lancerAuDemarrage = false
        }
        var dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        var path = dir[0] . stringByAppendingPathComponent("lancerAuDemarrage")
        NSKeyedArchiver.archiveRootObject(donnee, toFile: path)
    }

    @IBAction func animationsChange(sender: AnyObject) {
        // Le switch des animations est changé
        var donnee = MesDonnesAnimations()
        if (animations.on) {
            donnee.animations = true
        }
        else {
            donnee.animations = false
        }
        var dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        var path = dir[0] . stringByAppendingPathComponent("animations")
        NSKeyedArchiver.archiveRootObject(donnee, toFile: path)
    }
    
    @IBAction func choixNombreFaceChange(sender: AnyObject) {
        // Le nombre de face est changé
        var donnee = MesDonnesNombreFace()
        if (segmentChoixNombreFace.selectedSegmentIndex == 0) {
            donnee.nombreFace = 6
        }
        if (segmentChoixNombreFace.selectedSegmentIndex == 1) {
            donnee.nombreFace = 8
        }
        if (segmentChoixNombreFace.selectedSegmentIndex == 2) {
            donnee.nombreFace = 10
        }
            var dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
            var path = dir[0] . stringByAppendingPathComponent("nombreFace")
            NSKeyedArchiver.archiveRootObject(donnee, toFile: path)
            mettreAJourLabelFaceNumber()
    }
    
    @IBAction func choixNombreFaceChangeAutre(sender: AnyObject) {
        // Cette fonction affiche l'alerte pour le nombre personnalisé
        afficherAlerteChoixNombrePersonnalise()
    }
    
    @IBAction func switchRotationChange(sender: AnyObject!) {
        var donnee = MesDonnesRotation()
        if (switchRotation.on) {
            donnee.rotation = true
        }
        else {
            donnee.rotation = false
        }
        var dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        var path = dir[0] . stringByAppendingPathComponent("rotation")
        NSKeyedArchiver.archiveRootObject(donnee, toFile: path)
    }
    
    func afficherAlerteChoixNombrePersonnalise() {
        // On change le nombre de faces personnalisé
        var donnee = MesDonnesNombreFace()
        let alerte = UIAlertController(title: "Choix personnalisé", message: "Tapez le nombre de faces (entre 2 et 200)", preferredStyle: UIAlertControllerStyle.Alert)
        alerte.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
            textField.placeholder = "Nombre"
            textField.keyboardType = UIKeyboardType.NumberPad
        })
        alerte.addAction(UIAlertAction(title: "Annuler", style: UIAlertActionStyle.Destructive, handler: { (alertAction:UIAlertAction!) in
            self.mettreAJourFaceDe()
        }))
        alerte.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (alertAction:UIAlertAction!) in
            let textFields = alerte.textFields as [UITextField]
            let textField = textFields[0]
            var nombre:Int! = textField.text.toInt()
            if (nombre != nil && nombre >= 2 && nombre <= 200) {
                donnee.nombreFace = nombre!
                var dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
                var path = dir[0] . stringByAppendingPathComponent("nombreFace")
                NSKeyedArchiver.archiveRootObject(donnee, toFile: path)
            }
            else {
                let alerteErreurNombre = UIAlertController(title: "Erreur", message: "Attention, la saisie est incorrecte", preferredStyle: UIAlertControllerStyle.Alert)
                alerteErreurNombre.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (alertAction:UIAlertAction!) in
                    self.afficherAlerteChoixNombrePersonnalise()
                }))
                self.presentViewController(alerteErreurNombre, animated: true, completion: nil)
            }
            self.mettreAJourFaceDe()
            self.mettreAJourLabelFaceNumber()
        }))
        presentViewController(alerte, animated: true, completion: nil)
    }
    
    func mettreAJourLabelFaceNumber() {
        // Cette fonction met à jour le nombre de face
        var donnee = MesDonnesNombreFace()
        var dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        var path = dir[0] . stringByAppendingPathComponent("nombreFace")
        if (NSFileManager.defaultManager().fileExistsAtPath(path)) {
            donnee = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as MesDonnesNombreFace
            labelNombreFace.text = String(donnee.nombreFace)
        }
        else {
            labelNombreFace.text = String(6)
        }
    }
    
    func mettreAJourFaceDe() {
        // Cette fonction met à jour le UISegmentedControl du choix des faces du dé
        var donnee = MesDonnesNombreFace()
        var dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        var path = dir[0] . stringByAppendingPathComponent("nombreFace")
        if (NSFileManager.defaultManager().fileExistsAtPath(path)) {
            donnee = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as MesDonnesNombreFace
            if (donnee.nombreFace == 6) {
                self.segmentChoixNombreFace.selectedSegmentIndex = 0
            }
            else if (donnee.nombreFace == 8) {
                self.segmentChoixNombreFace.selectedSegmentIndex = 1
            }
            else if (donnee.nombreFace == 10) {
                self.segmentChoixNombreFace.selectedSegmentIndex = 2
            }
            else {
                self.segmentChoixNombreFace.selectedSegmentIndex = -1
            }
        }
        else {
            self.segmentChoixNombreFace.selectedSegmentIndex = 0
        }
        mettreAJourLabelFaceNumber()
    }
}
