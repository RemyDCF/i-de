//
//  MesDonnes.h
//  i-de
//
//  Created by DCF on 27/07/2014.
//  Copyright (c) 2014 Da Costa Faro Rémy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MesDonnesNombreFace : NSObject <NSCoding>

@property(readwrite, nonatomic) int nombreFace;

@end

@interface MesDonnesSecouer : NSObject <NSCoding>

@property(readwrite, nonatomic) bool secouer;

@end

@interface MesDonnesLancerAuDemmarage : NSObject <NSCoding>

@property(readwrite, nonatomic) bool lancerAuDemmarage;

@end