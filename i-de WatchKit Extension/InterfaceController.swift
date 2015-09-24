//
//  InterfaceController.swift
//  i-de WatchKit Extension
//
//  Created by remy on 24/04/2015.
//  Copyright (c) 2015 DCF. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController, WCSessionDelegate {
    @IBOutlet var chiffre: WKInterfaceLabel!
    @IBOutlet var labelTirage: WKInterfaceLabel!
    var session : WCSession!
    var nombreFace:Int! = 6
    let defaults = NSUserDefaults.standardUserDefaults()
    override init() {
        super.init()
        if (WCSession.isSupported()) {
            session = WCSession.defaultSession()
            session.delegate = self
            session.activateSession()
        }
    }
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        tirage(self)
        // Configure interface objects here.
        if defaults.integerForKey("nombreFace") == 0 {
            defaults.setInteger(6, forKey: "nombreFace")
            nombreFace = 6
        }
        labelTirage.setText(NSLocalizedString("labelTirage", tableName: "", bundle: NSBundle.mainBundle(), value: "", comment: "") + String(defaults.integerForKey("nombreFace")))
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    @IBAction func tirage(sender: AnyObject!) {
        let nombreTiré = Int((arc4random() % UInt32(nombreFace)) + 1)
        self.chiffre.setText(String(nombreTiré))
    }
    func session(session: WCSession, didReceiveApplicationContext applicationContext: [String : AnyObject]) {
        let nombreFace = applicationContext["nombreFace"] as? Int
        self.nombreFace = nombreFace
        defaults.setInteger(nombreFace!, forKey: "nombreFace")
        self.labelTirage.setText(NSLocalizedString("labelTirage", tableName: "", bundle: NSBundle.mainBundle(), value: "", comment: "") + String(nombreFace!))
    }
}
