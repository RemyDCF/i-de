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

@interface MesDonnesLancerAuDemarrage : NSObject <NSCoding>

@property(readwrite, nonatomic) bool lancerAuDemarrage;

@end

@interface MesDonnesAnimations : NSObject <NSCoding>

@property(readwrite, nonatomic) bool animations;

@end

#pragma mark - Secouer

@interface MesDonnesSecouer : NSObject <NSCoding>

@property(readwrite, nonatomic) bool secouer;

@end

@interface MesDonnesSecouerRotation : NSObject <NSCoding>

@property(readwrite, nonatomic) bool secouerRotation;

@end