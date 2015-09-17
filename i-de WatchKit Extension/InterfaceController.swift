//
//  InterfaceController.swift
//  i-de WatchKit Extension
//
//  Created by remy on 24/04/2015.
//  Copyright (c) 2015 DCF. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    @IBOutlet var chiffre: WKInterfaceLabel!
    var nombreFace:Int! = 6
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        tirage(self)
        // Configure interface objects here.
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
        let nombreTiré = Int((arc4random() % 6) + 1)
        self.chiffre.setText(String(nombreTiré))
    }
}
