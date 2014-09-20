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
    var segmentChoixFaceSelectionne:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        if (pref.boolForKey("secouer") == false) {
            segmentChoixDe.selectedSegmentIndex = 1
        }
        /*var donnee = MesDonnes()
        var dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        var path = dir[0] . stringByAppendingPathComponent("nombreFace")
        if (NSFileManager.defaultManager().fileExistsAtPath(path)) {
            donnee = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as MesDonnes
            if (donnee.leNombre == 6) {
                self.segmentChoixFaceSelectionne = 0
            }
            if (donnee.leNombre == 8) {
                self.segmentChoixFaceSelectionne = 1
            }
            if (donnee.leNombre == 10) {
                self.segmentChoixFaceSelectionne = 2
            }
            else {
                self.segmentChoixFaceSelectionne = 3
            }
        }
        else {
            self.segmentChoixFaceSelectionne = 0
        }*/
        segmentChoixNombreFace.selectedSegmentIndex = -1
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
            let alerte = UIAlertController(title: "Choix personnalisé", message: "Tapez le nombre de faces (Maximum : 180)", preferredStyle: UIAlertControllerStyle.Alert)
            alerte.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
                textField.placeholder = "Name"
                textField.secureTextEntry = false
                inputTextField = textField
            })
            alerte.addAction(UIAlertAction(title: "Annuler", style: UIAlertActionStyle.Destructive, handler: nil))
            alerte.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (alertAction:UIAlertAction!) in
                var string:String! = inputTextField?.text
                let chiffre = inputTextField?.text!.toInt()
                if (chiffre != nil && chiffre >= 1 && chiffre <= 180) {
                    donnee.leNombre = Int32(chiffre!)
                    println(donnee.leNombre)
                    println(chiffre)
                    var dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
                    var path = dir[0] . stringByAppendingPathComponent("nombreFace")
                    var erreur = NSKeyedArchiver.archiveRootObject(donnee, toFile: path)
                }
                else {
                    donnee.leNombre = 6
                }
            }))
            presentViewController(alerte, animated: true, completion: nil)
        }
        if (segmentChoixNombreFace.selectedSegmentIndex != 3) {
            var dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
            var path = dir[0] . stringByAppendingPathComponent("nombreFace")
            var erreur = NSKeyedArchiver.archiveRootObject(donnee, toFile: path)
        }
    }
}
