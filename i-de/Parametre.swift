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
        super.viewDidLoad()
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
            var passwordAlert : UIAlertView = UIAlertView(title: "Choix personnalisé", message: "Tapez le nombre de faces (Maximum : 180)", delegate: self, cancelButtonTitle: "Annuler", otherButtonTitles: "Valider")
            passwordAlert.alertViewStyle = UIAlertViewStyle.PlainTextInput
            passwordAlert.textFieldAtIndex(0)!.keyboardType = UIKeyboardType.NumberPad
            passwordAlert.show()
        }
        if (segmentChoixNombreFace.selectedSegmentIndex != 3) {
            var dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
            var path = dir[0] . stringByAppendingPathComponent("nombreFace")
            var erreur = NSKeyedArchiver.archiveRootObject(donnee, toFile: path)
        }
    }
    
    func alertView(alertView: UIAlertView!, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == 1 {
            var donnee = MesDonnes()
            if ((alertView.textFieldAtIndex(0)!.text.toInt()) != nil) {
                if ((alertView.textFieldAtIndex(0)!.text.toInt()) <= 180) {
                    donnee.leNombre = Int32(alertView.textFieldAtIndex(0)!.text.toInt()!)
                    var dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
                    var path = dir[0] . stringByAppendingPathComponent("nombreFace")
                    var erreur = NSKeyedArchiver.archiveRootObject(donnee, toFile: path)
                }
                else {
                    alertView.dismissWithClickedButtonIndex(0, animated: true)
                }
            }
        }
    }
}
