//
//  ResultatDesTirages.swift
//  Aleatoire
//
//  Created by DCF on 01/08/2014.
//  Copyright (c) 2014 Da Costa Faro Rémy. All rights reserved.
//

import UIKit

class ResultatDesTirages: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var donnee = MesDonnes()
        var dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        var i = 1
        var resultat = [String]()
        while i < 10 {
            var path = dir[0] . stringByAppendingPathComponent(String(i))
            donnee = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as MesDonnes
            resultat[i - 1] = donnee.laChaine
            i++
        }
        let navBar = UINavigationBar(frame: CGRectMake(0, 00, UIScreen.mainScreen().bounds.size.width, 64))
        navBar.barStyle = UIBarStyle.Default
        let titre = UINavigationItem(title: "Résultat")
        navBar.pushNavigationItem(titre, animated: true)

        self.view.addSubview(navBar)
    }
    
    func afficherParametre() -> Void {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func userClickedOnLineKeyPoint(point: CGPoint, lineIndex: Int, keyPointIndex: Int)
    {
    }
    
    func userClickedOnLinePoint(point: CGPoint, lineIndex: Int)
    {
    }
    
    func userClickedOnBarCharIndex(barIndex: Int)
    {
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func disablesAutomaticKeyboardDismissal() -> Bool {
        return false
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
}
