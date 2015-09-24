//
//  ChoixFace.swift
//  i-de
//
//  Created by DCF on 27/07/2014.
//  Copyright (c) 2014 Da Costa Faro Rémy. All rights reserved.
//

import UIKit
import WatchConnectivity

class Parametres: UITableViewController, UIAlertViewDelegate, WCSessionDelegate {
    @IBOutlet weak var secouerDe: UISwitch!
    @IBOutlet weak var segmentChoixNombreFace: UISegmentedControl!
    @IBOutlet weak var labelNombreFace: UILabel!
    @IBOutlet weak var lancerAuDemarrage: UISwitch!
    @IBOutlet weak var animations: UISwitch!
    let listeLabel: Array<String> = []
    let defaults = NSUserDefaults.standardUserDefaults()
    var session : WCSession!
    override func viewDidLoad() {
        super.viewDidLoad()
        // WatchConnectivity
        if (WCSession.isSupported()) {
            session = WCSession.defaultSession()
            session.delegate = self
            session.activateSession()
        }
        // Personnalisation des boutons
        // Mise en place des données existantes
        if (!AppValues.secouer) {
            secouerDe.setOn(false, animated: true)
            //boutonParametreSecouer.setRoundedRectangleDisabled()
        }
        if (AppValues.animationsAutorisés == true) {
            animations.setOn(true, animated: true)
        }
        let lancerAuDemmarageDonnee = defaults.boolForKey(NSUserDefaultsKeys.LancerAuDemmarage)
        if (lancerAuDemmarageDonnee) {
            lancerAuDemarrage.setOn(true, animated: true)
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
    }
    
    
    @IBAction func lancerDemarrageChange(sender: AnyObject) {
        // Le switch de lancer au demarrage est changé
        defaults.setBool(lancerAuDemarrage.on, forKey: NSUserDefaultsKeys.LancerAuDemmarage)
    }
    
    @IBAction func animationsChange(sender: AnyObject) {
        // Le switch des animations est changé
        defaults.setBool(animations.on, forKey: NSUserDefaultsKeys.Animations)
        AppValues.animationsAutorisés = animations.on
    }
    
    @IBAction func choixNombreFaceChange(sender: AnyObject) {
        // Le nombre de face est changé
        switch segmentChoixNombreFace.selectedSegmentIndex {
        case 1:
            defaults.setInteger(8, forKey: NSUserDefaultsKeys.NombreFace)
            AppValues.nombreFace = 8
            setNombreFaceWatchConnectivity(8)
            break
        case 2:
            defaults.setInteger(10, forKey: NSUserDefaultsKeys.NombreFace)
            AppValues.nombreFace = 10
            setNombreFaceWatchConnectivity(10)
            break
        default:
            defaults.setInteger(6, forKey: NSUserDefaultsKeys.NombreFace)
            AppValues.nombreFace = 6
            setNombreFaceWatchConnectivity(6)
            break
        }
        mettreAJourLabelFaceNumber()
    }
    
    func setNombreFaceWatchConnectivity(nombreFace: Int) {
        let applicationDict = ["nombreFace":nombreFace]
        do {
            try session.updateApplicationContext(applicationDict)
            print("ok")
        } catch {
            print("error")
        }
    }
    
    @IBAction func choixNombreFaceChangeAutre(sender: AnyObject) {
        // Cette fonction affiche l'alerte pour le nombre personnalisé
        afficherAlerteChoixNombrePersonnalise()
    }
    
    func afficherAlerteChoixNombrePersonnalise() {
        // On change le nombre de faces personnalisé
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
                    self.defaults.setInteger(nombre!, forKey: NSUserDefaultsKeys.NombreFace)
                    self.setNombreFaceWatchConnectivity(nombre!)
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
        let nombreFace = defaults.integerForKey(NSUserDefaultsKeys.NombreFace)
        labelNombreFace.text = String(nombreFace)
    }
    
    func mettreAJourFaceDe() {
        // Cette fonction met à jour le UISegmentedControl du choix des faces du dé
        let nombreFace = defaults.integerForKey(NSUserDefaultsKeys.NombreFace)
        switch nombreFace {
        case 6:
            self.segmentChoixNombreFace.selectedSegmentIndex = 0
            break
        case 8:
            self.segmentChoixNombreFace.selectedSegmentIndex = 1
            break
        case 6:
            self.segmentChoixNombreFace.selectedSegmentIndex = 2
            break
        default:
            self.segmentChoixNombreFace.selectedSegmentIndex = -1
            break
        }
        mettreAJourLabelFaceNumber()
    }
    @IBAction func ouvrirTwitter(sender: AnyObject!) {
        UIApplication.sharedApplication().openURL(NSURL(string: "https://twitter.com/i_de_app")!)
    }
}
