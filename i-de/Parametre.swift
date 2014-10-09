//
//  ChoixFace.swift
//  i-de
//
//  Created by DCF on 27/07/2014.
//  Copyright (c) 2014 Da Costa Faro Rémy. All rights reserved.
//

import UIKit

class Parametres: UIViewController, UIAlertViewDelegate {
    let pref = NSUserDefaults.standardUserDefaults()
    @IBOutlet weak var segmentChoixDe: UISegmentedControl!
    @IBOutlet weak var segmentChoixNombreFace: UISegmentedControl!
    @IBOutlet weak var labelNombreFace: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        if (pref.boolForKey("secouer") == false) {
            segmentChoixDe.selectedSegmentIndex = 1
        }
        var donnee = MesDonnes()
        var dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        var path = dir[0] . stringByAppendingPathComponent("nombreFace")
        if (NSFileManager.defaultManager().fileExistsAtPath(path)) {
            donnee = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as MesDonnes
            if (donnee.leNombre == 6) {
                self.segmentChoixNombreFace.selectedSegmentIndex = 0
            }
            else if (donnee.leNombre == 8) {
                self.segmentChoixNombreFace.selectedSegmentIndex = 1
            }
            else if (donnee.leNombre == 10) {
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        let message = UIAlertController(title: "Erreur mémoire", message: "Attention à la mémoire", preferredStyle: .Alert)
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        message.addAction(defaultAction)
        
        presentViewController(message, animated: true, completion: nil)
    }
    
    @IBAction func choixTypeLanceDeChange(sender: AnyObject) {
        var appDefault:NSDictionary?
        if (segmentChoixDe.selectedSegmentIndex == 0) {
            appDefault = NSDictionary(object: true, forKey: "secouer")
        }
        else {
            appDefault = NSDictionary(object: false, forKey: "secouer")
        }
        pref.registerDefaults(appDefault!)
        pref.synchronize()
    }
    
    @IBAction func choixNombreFaceChange(sender: AnyObject) {
        var inputTextField: UITextField?
        var donnee = MesDonnes()
        if (segmentChoixNombreFace.selectedSegmentIndex == 0) {
            donnee.leNombre = 6
        }
        if (segmentChoixNombreFace.selectedSegmentIndex == 1) {
            donnee.leNombre = 8
        }
        if (segmentChoixNombreFace.selectedSegmentIndex == 2) {
            donnee.leNombre = 10
        }
        if (segmentChoixNombreFace.selectedSegmentIndex == 3) {
            let alerte = UIAlertController(title: "Choix personnalisé", message: "Tapez le nombre de faces (entre 2 et 200)", preferredStyle: UIAlertControllerStyle.Alert)
            alerte.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
                textField.placeholder = "Nombre"
                textField.keyboardType = UIKeyboardType.NumberPad
                inputTextField = textField
            })
            alerte.addAction(UIAlertAction(title: "Annuler", style: UIAlertActionStyle.Destructive, handler: nil))
            alerte.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (alertAction:UIAlertAction!) in
                var string:String! = inputTextField?.text
                let chiffre = inputTextField?.text!.toInt()
                if (chiffre != nil && chiffre >= 2 && chiffre <= 200) {
                    donnee.leNombre = Int32(chiffre!)
                    var dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
                    var path = dir[0] . stringByAppendingPathComponent("nombreFace")
                    var erreur = NSKeyedArchiver.archiveRootObject(donnee, toFile: path)
                }
                else {
                    let alerteErreurNombre = UIAlertController(title: "Erreur", message: "Attention, la saisie est incorrecte", preferredStyle: UIAlertControllerStyle.ActionSheet)
                    alerteErreurNombre.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alerteErreurNombre, animated: true, completion: nil)
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
        var donnee = MesDonnes()
        var dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        var path = dir[0] . stringByAppendingPathComponent("nombreFace")
        if (NSFileManager.defaultManager().fileExistsAtPath(path)) {
            donnee = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as MesDonnes
            labelNombreFace.text = String(donnee.leNombre)
        }
        else {
            labelNombreFace.text = String(6)
        }
    }
}
