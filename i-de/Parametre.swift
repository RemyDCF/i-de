//
//  ChoixFace.swift
//  i-de
//
//  Created by DCF on 27/07/2014.
//  Copyright (c) 2014 Da Costa Faro Rémy. All rights reserved.
//

import UIKit

class Parametres: UITableViewController {
    @IBOutlet weak var segmentChoixDe: UISegmentedControl!
    @IBOutlet weak var segmentChoixNombreFace: UISegmentedControl!
    @IBOutlet weak var labelNombreFace: UILabel!
    @IBOutlet weak var lancerAuDemmarage: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Mise en place des données existantes
        // Secouer
        var donneeSecouer = MesDonnesSecouer()
        var dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        var path = dir[0] . stringByAppendingPathComponent("secouer")
        if (NSFileManager.defaultManager().fileExistsAtPath(path)) {
            donneeSecouer = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as MesDonnesSecouer
            if (!donneeSecouer.secouer) {
                segmentChoixDe.selectedSegmentIndex = 1
            }
        }
        else {
            donneeSecouer.secouer = true
            var dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
            var path = dir[0] . stringByAppendingPathComponent("secouer")
            var erreur = NSKeyedArchiver.archiveRootObject(donneeSecouer, toFile: path)
        }
        // Lancer au demmarage
        var donneeLancerAuDemmarage = MesDonnesLancerAuDemmarage()
        dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        path = dir[0] . stringByAppendingPathComponent("lancerAuDemmarage")
        if (NSFileManager.defaultManager().fileExistsAtPath(path)) {
            donneeLancerAuDemmarage = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as MesDonnesLancerAuDemmarage
            if (donneeLancerAuDemmarage.lancerAuDemmarage) {
                lancerAuDemmarage.setOn(true, animated: true)
            }
        }
        else {
            donneeLancerAuDemmarage.lancerAuDemmarage = false
            var dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
            var path = dir[0] . stringByAppendingPathComponent("lancerAuDemmarage")
            var erreur = NSKeyedArchiver.archiveRootObject(donneeLancerAuDemmarage, toFile: path)
        }
        mettreAJourFaceDe()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func choixTypeLanceDeChange(sender: AnyObject) {
        var donnee = MesDonnesSecouer()
        if (segmentChoixDe.selectedSegmentIndex == 0) {
            donnee.secouer = true
        }
        else {
            donnee.secouer = false
        }
        var dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        var path = dir[0] . stringByAppendingPathComponent("secouer")
        NSKeyedArchiver.archiveRootObject(donnee, toFile: path)
    }

    
    @IBAction func lancerDemmarageChange(sender: AnyObject) {
        var donnee = MesDonnesLancerAuDemmarage()
        if (lancerAuDemmarage.on) {
            donnee.lancerAuDemmarage = true
        }
        else {
            donnee.lancerAuDemmarage = false
        }
        var dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        var path = dir[0] . stringByAppendingPathComponent("lancerAuDemmarage")
        NSKeyedArchiver.archiveRootObject(donnee, toFile: path)
    }

    @IBAction func choixNombreFaceChange(sender: AnyObject) {
        var inputTextField: UITextField?
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
        if (segmentChoixNombreFace.selectedSegmentIndex == 3) {
            let alerte = UIAlertController(title: "Choix personnalisé", message: "Tapez le nombre de faces (entre 2 et 200)", preferredStyle: UIAlertControllerStyle.Alert)
            alerte.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
                textField.placeholder = "Nombre"
                textField.keyboardType = UIKeyboardType.NumberPad
                inputTextField = textField
            })
            alerte.addAction(UIAlertAction(title: "Annuler", style: UIAlertActionStyle.Destructive, handler: { (alertAction:UIAlertAction!) in
                self.mettreAJourFaceDe()
            }))
            alerte.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (alertAction:UIAlertAction!) in
                var string:String! = inputTextField?.text
                let chiffre = inputTextField?.text!.toInt()
                if (chiffre != nil && chiffre >= 2 && chiffre <= 200) {
                    donnee.nombreFace = Int32(chiffre!)
                    var dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
                    var path = dir[0] . stringByAppendingPathComponent("nombreFace")
                    var erreur = NSKeyedArchiver.archiveRootObject(donnee, toFile: path)
                }
                else {
                    let alerteErreurNombre = UIAlertController(title: "Erreur", message: "Attention, la saisie est incorrecte", preferredStyle: UIAlertControllerStyle.ActionSheet)
                    alerteErreurNombre.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alerteErreurNombre, animated: true, completion: nil)
                    self.mettreAJourFaceDe()
                }
                self.mettreAJourLabelFaceNumber()
            }))
            presentViewController(alerte, animated: true, completion: nil)
        }
        if (segmentChoixNombreFace.selectedSegmentIndex != 3) {
            var dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
            var path = dir[0] . stringByAppendingPathComponent("nombreFace")
            var erreur = NSKeyedArchiver.archiveRootObject(donnee, toFile: path)
            mettreAJourLabelFaceNumber()
        }
    }
    
    func mettreAJourLabelFaceNumber() {
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
                self.segmentChoixNombreFace.selectedSegmentIndex = 3
            }
        }
        else {
            self.segmentChoixNombreFace.selectedSegmentIndex = 0
        }
        mettreAJourLabelFaceNumber()
    }
}
