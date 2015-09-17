//
//  MesDonnes.swift
//  i-de
//
//  Created by remy on 10/11/2014.
//  Copyright (c) 2014 DCF. All rights reserved.
//

import UIKit

class MesDonnesAnimations : NSObject {
    var animations: Bool = true
    
    override init() {
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeBool(self.animations, forKey: "animations")
    }
    
    init(coder aDecoder: NSCoder) {
        super.init()
        self.animations = aDecoder.decodeBoolForKey("animations")
    }
}

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

class MesDonnesSecouerAnimations : NSObject {
    var secouerAnimations: Bool = true
    
    override init() {
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeBool(self.secouerAnimations, forKey: "secouerAnimations")
    }
    
    init(coder aDecoder: NSCoder) {
        super.init()
        self.secouerAnimations = aDecoder.decodeBoolForKey("secouerAnimations")
    }
}