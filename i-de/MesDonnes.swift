//
//  MesDonnes.swift
//  i-de
//
//  Created by remy on 10/11/2014.
//  Copyright (c) 2014 DCF. All rights reserved.
//

import Foundation

class MesDonnesNombreFace : NSObject {
    var nombreFace: Int = 6
    
    override init() {
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeInteger(self.nombreFace, forKey: "nombreFace")
    }
    
    init(coder aDecoder: NSCoder) {
        super.init()
        self.nombreFace = aDecoder.decodeIntegerForKey("nombreFace")
    }
}

class MesDonnesLancerAuDemarrage : NSObject {
    var lancerAuDemarrage: Bool = true
    
    override init() {
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeBool(self.lancerAuDemarrage, forKey: "lancerAuDemarrage")
    }
    
    init(coder aDecoder: NSCoder) {
        super.init()
        self.lancerAuDemarrage = aDecoder.decodeBoolForKey("lancerAuDemarrage")
    }
}

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

class MesDonnesSecouerRotation : NSObject {
    var secouerRotation: Bool = true
    
    override init() {
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeBool(self.secouerRotation, forKey: "secouerRotation")
    }
    
    init(coder aDecoder: NSCoder) {
        super.init()
        self.secouerRotation = aDecoder.decodeBoolForKey("secouerRotation")
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