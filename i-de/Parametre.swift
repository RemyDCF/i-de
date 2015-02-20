//
//  ChoixFace.swift
//  i-de
//
//  Created by DCF on 27/07/2014.
//  Copyright (c) 2014 Da Costa Faro Rémy. All rights reserved.
//

import UIKit

class Parametres: UITableViewController, UIAlertViewDelegate {
    @IBOutlet weak var secouerDe: UISwitch!
    @IBOutlet weak var segmentChoixNombreFace: UISegmentedControl!
    @IBOutlet weak var labelNombreFace: UILabel!
    @IBOutlet weak var lancerAuDemarrage: UISwitch!
    @IBOutlet weak var animations: UISwitch!
    @IBOutlet weak var boutonParametreSecouer: RYButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Personnalisation des boutons
        boutonParametreSecouer.setImage(UIImage(named: "parametresDisabled"), forState: UIControlState.Disabled)
        // Mise en place des données existantes
        if (!AppValues.secouer) {
            secouerDe.setOn(false, animated: true)
            //boutonParametreSecouer.setRoundedRectangleDisabled()
        }
        if (AppValues.animationsAutorisés == true) {
            animations.setOn(true, animated: true)
        }
        var donneelancerAuDemarrage = MesDonnesLancerAuDemarrage()
        var dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        var path = dir[0] . stringByAppendingPathComponent("lancerAuDemarrage")
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
        mettreAJourFaceDe()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func secouerDeChange(sender: AnyObject) {
        // Le switch de Secouer est changé
        var donnee = MesDonnesSecouer()
        donnee.secouer = secouerDe.on
        var dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        var path = dir[0] . stringByAppendingPathComponent("secouer")
        NSKeyedArchiver.archiveRootObject(donnee, toFile: path)
        AppValues.secouer = secouerDe.on
        if (secouerDe.on == false) {
            boutonParametreSecouer.enabled = false
            boutonParametreSecouer.borderColor = UIColor(red:0.79, green:0.79, blue:0.79, alpha:1)
        }
        else {
            boutonParametreSecouer.enabled = true
        }
    }
    
    
    @IBAction func lancerDemarrageChange(sender: AnyObject) {
        // Le switch de lancer au demarrage est changé
        var donnee = MesDonnesLancerAuDemarrage()
        donnee.lancerAuDemarrage = lancerAuDemarrage.on
        var dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        var path = dir[0] . stringByAppendingPathComponent("lancerAuDemarrage")
        NSKeyedArchiver.archiveRootObject(donnee, toFile: path)
    }
    
    @IBAction func animationsChange(sender: AnyObject) {
        // Le switch des animations est changé
        var donnee = MesDonnesAnimations()
        donnee.animations = animations.on
        var dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        var path = dir[0] . stringByAppendingPathComponent("animations")
        NSKeyedArchiver.archiveRootObject(donnee, toFile: path)
        AppValues.animationsAutorisés = animations.on
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
        AppValues.nombreFace = donnee.nombreFace
        mettreAJourLabelFaceNumber()
    }
    
    @IBAction func choixNombreFaceChangeAutre(sender: AnyObject) {
        // Cette fonction affiche l'alerte pour le nombre personnalisé
        afficherAlerteChoixNombrePersonnalise()
    }
    
    func afficherAlerteChoixNombrePersonnalise() {
        // On change le nombre de faces personnalisé
        var donnee = MesDonnesNombreFace()
        if controllerAvailable() {
            let alerte = UIAlertController(title: "Choix personnalisé", message: "Tapez le nombre de faces (entre 2 et 2147483647)", preferredStyle: UIAlertControllerStyle.Alert)
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
                if (nombre != nil && nombre >= 2 && nombre <= 2147483647) {
                    donnee.nombreFace = nombre!
                    var dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
                    var path = dir[0] . stringByAppendingPathComponent("nombreFace")
                    NSKeyedArchiver.archiveRootObject(donnee, toFile: path)
                    AppValues.nombreFace = nombre!
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
        else {
            var alerte = UIAlertView(title: "Choix personnalisé", message: "Tapez le nombre de faces (entre 2 et 2147483647)", delegate: self, cancelButtonTitle: "Annuler", otherButtonTitles: "OK")
            alerte.alertViewStyle = UIAlertViewStyle.PlainTextInput
            alerte.textFieldAtIndex(0)!.keyboardType = UIKeyboardType.NumberPad
            alerte.textFieldAtIndex(0)!.placeholder = "Nombre"
            alerte.show()
        }
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
    
    func controllerAvailable() -> Bool {
        if let gotModernAlert: AnyClass = NSClassFromString("UIAlertController") {
            return true;
        }
        else {
            return false;
        }
        
    }
    func alertView(alertView: UIAlertView, didDismissWithButtonIndex buttonIndex: Int) {
        if (alertView.tag == 1) {
            afficherAlerteChoixNombrePersonnalise()
        }
        if (buttonIndex == 1) {
            var donnee = MesDonnesNombreFace()
            var textField: UITextField! = alertView.textFieldAtIndex(0)
            var nombre:Int! = textField.text.toInt()
            if (nombre != nil && nombre >= 2 && nombre <= 2147483647) {
                donnee.nombreFace = nombre!
                var dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
                var path = dir[0] . stringByAppendingPathComponent("nombreFace")
                NSKeyedArchiver.archiveRootObject(donnee, toFile: path)
                AppValues.nombreFace = nombre!
            }
            else {
                var alerte = UIAlertView(title: "Erreur", message: "Attention, la saisie est incorrecte", delegate: self, cancelButtonTitle: "OK")
                alerte.tag = 1
                alerte.show()
            }
            self.mettreAJourFaceDe()
            self.mettreAJourLabelFaceNumber()
        }
    }
}
