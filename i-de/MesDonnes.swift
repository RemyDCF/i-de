//
//  MesDonnes.swift
//  i-de
//
//  Created by remy on 10/11/2014.
//  Copyright (c) 2014 DCF. All rights reserved.
//

import UIKit

// MARK: Secouer

class MesDonnesSecouer : NSObject {
    var secouer: Bool = true
    
    override init() {
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeBool(self.secouer, forKey: "secouer")
    }
    
    init(coder aDecoder: NSCoder) {
        super.init()
        self.secouer = aDecoder.decodeBoolForKey("secouer")
    }
}

class MesDonnesRotation : NSObject {
    var rotation: Bool = true
    
    override init() {
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeBool(self.rotation, forKey: "rotation")
    }
    
    init(coder aDecoder: NSCoder) {
        super.init()
        self.rotation = aDecoder.decodeBoolForKey("rotation")
    }
}