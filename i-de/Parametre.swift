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
    let listeLabel: Array<String> = []
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
        let path = dir[0] + "lancerAuDemarrage"
        if (NSFileManager.defaultManager().fileExistsAtPath(path)) {
            donneelancerAuDemarrage = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as! MesDonnesLancerAuDemarrage
            if (donneelancerAuDemarrage.lancerAuDemarrage) {
                lancerAuDemarrage.setOn(true, animated: true)
            }
        }
        else {
            donneelancerAuDemarrage.lancerAuDemarrage = false
            NSKeyedArchiver.archiveRootObject(donneelancerAuDemarrage, toFile: path)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func secouerDeChange(sender: AnyObject) {
        // Le switch de Secouer est changé
        let donnee = MesDonnesSecouer()
        donnee.secouer = secouerDe.on
        var dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let path = dir[0] + "secouer"
        NSKeyedArchiver.archiveRootObject(donnee, toFile: path)
        AppValues.secouer = secouerDe.on
        if (secouerDe.on == false) {
            boutonParametreSecouer.enabled = false
            boutonParametreSecouer.borderColor = UIColor(red:0.79, green:0.79, blue:0.79, alpha:1)
        }
        else {
            boutonParametreSecouer.enabled = true
            boutonParametreSecouer.borderColor = UIColor(red:0, green:0.64, blue:0.98, alpha:1)
        }
    }
    
    
    @IBAction func lancerDemarrageChange(sender: AnyObject) {
        // Le switch de lancer au demarrage est changé
        let donnee = MesDonnesLancerAuDemarrage()
        donnee.lancerAuDemarrage = lancerAuDemarrage.on
        var dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let path = dir[0] + "lancerAuDemarrage"
        NSKeyedArchiver.archiveRootObject(donnee, toFile: path)
    }
    
    @IBAction func animationsChange(sender: AnyObject) {
        // Le switch des animations est changé
        let donnee = MesDonnesAnimations()
        donnee.animations = animations.on
        var dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let path = dir[0] + "animations"
        NSKeyedArchiver.archiveRootObject(donnee, toFile: path)
        AppValues.animationsAutorisés = animations.on
    }
    
    @IBAction func choixNombreFaceChange(sender: AnyObject) {
        // Le nombre de face est changé
        let donnee = MesDonnesNombreFace()
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
        let path = dir[0] + "nombreFace"
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
        let donnee = MesDonnesNombreFace()
            let alerte = UIAlertController(title: NSLocalizedString("choixPerso", tableName: "", bundle: NSBundle.mainBundle(), value: "", comment: ""), message: NSLocalizedString("nombreFace", tableName: "", bundle: NSBundle.mainBundle(), value: "", comment: ""), preferredStyle: UIAlertControllerStyle.Alert)
            alerte.addTextFieldWithConfigurationHandler({(textField: UITextField) in
                textField.placeholder = NSLocalizedString("nombre", tableName: "", bundle: NSBundle.mainBundle(), value: "", comment: "")
                textField.keyboardType = UIKeyboardType.NumberPad
            })
            alerte.addAction(UIAlertAction(title: NSLocalizedString("annuler", tableName: "", bundle: NSBundle.mainBundle(), value: "", comment: ""), style: UIAlertActionStyle.Destructive, handler: { (alertAction:UIAlertAction) in
                self.mettreAJourFaceDe()
            }))
            alerte.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (alertAction:UIAlertAction) in
                let textFields = alerte.textFields as [UITextField]!
                let textField = textFields[0]
                let nombre:Int! = Int(textField.text!)
                if (nombre != nil && nombre >= 2 && nombre <= 200) {
                    donnee.nombreFace = nombre!
                    var dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
                    let path = dir[0] + "nombreFace"
                    NSKeyedArchiver.archiveRootObject(donnee, toFile: path)
                    AppValues.nombreFace = nombre!
                }
                else {
                    let alerteErreurNombre = UIAlertController(title: NSLocalizedString("erreur", tableName: "", bundle: NSBundle.mainBundle(), value: "", comment: ""), message: NSLocalizedString("saisieIncorrecte", tableName: "", bundle: NSBundle.mainBundle(), value: "", comment: ""), preferredStyle: UIAlertControllerStyle.Alert)
                    alerteErreurNombre.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (alertAction:UIAlertAction) in
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
        let path = dir[0] + "nombreFace"
        if (NSFileManager.defaultManager().fileExistsAtPath(path)) {
            donnee = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as! MesDonnesNombreFace
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
        let path = dir[0] + "nombreFace"
        if (NSFileManager.defaultManager().fileExistsAtPath(path)) {
            donnee = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as! MesDonnesNombreFace
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
    @IBAction func ouvrirTwitter(sender: AnyObject!) {
        UIApplication.sharedApplication().openURL(NSURL(string: "https://twitter.com/i_de_app")!)
    }
}
