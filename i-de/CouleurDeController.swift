//
//  CouleurDeController.swift
//  i-de
//
//  Created by remy on 17/02/2015.
//  Copyright (c) 2015 DCF. All rights reserved.
//

import UIKit

class CouleurDeController: UIViewController {
    @IBOutlet weak var vueCouleur: UIView!
    @IBOutlet weak var sliderR: UISlider!
    @IBOutlet weak var sliderG: UISlider!
    @IBOutlet weak var sliderB: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let couleurDe = AppValues.couleurDe as UIColor
        vueCouleur.backgroundColor = couleurDe
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        if AppValues.couleurDe.getRed(&r, green: &g, blue: &b, alpha: &a){
            sliderR.setValue(Float(r), animated: true)
            sliderG.setValue(Float(g), animated: true)
            sliderB.setValue(Float(b), animated: true)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didSliderValueChanged(sender: AnyObject!) {
        vueCouleur.backgroundColor = UIColor(red: CGFloat(sliderR.value), green: CGFloat(sliderG.value), blue: CGFloat(sliderB.value), alpha: 1.0)
        enregistrerCouleur(UIColor(red: CGFloat(sliderR.value), green: CGFloat(sliderG.value), blue: CGFloat(sliderB.value), alpha: 1.0))
    }
    
    @IBAction func revenir(sender: AnyObject!) {
        sliderR.setValue(0, animated: true)
        sliderG.setValue(0.64, animated: true)
        sliderB.setValue(0.98, animated: true)
        enregistrerCouleur(UIColor(red: CGFloat(sliderR.value), green: CGFloat(sliderG.value), blue: CGFloat(sliderB.value), alpha: 1.0))
    }
    
    func enregistrerCouleur(couleur: UIColor) {
        let donnee = MesDonnesCouleurDe()
        donnee.couleurDe = couleur
        var dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let path = dir[0] + "couleurDe"
        NSKeyedArchiver.archiveRootObject(donnee, toFile: path)
        AppValues.couleurDe = couleur
        vueCouleur.backgroundColor = couleur
    }
}
