//
//  MesDonnes.m
//  i-de
//
//  Created by DCF on 27/07/2014.
//  Copyright (c) 2014 Da Costa Faro Rémy. All rights reserved.
//

#import "MesDonnes.h"

@implementation MesDonnesNombreFace

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeInt:_nombreFace forKey:@"nombreFace"];
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    _nombreFace = [aDecoder decodeIntForKey:@"nombreFace"];
    return self;
}

- (void)dealloc {
    [super dealloc];
}
@end

@implementation MesDonnesLancerAuDemarrage

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeBool:_lancerAuDemarrage forKey:@"lancerAuDemarrage"];
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    _lancerAuDemarrage = [aDecoder decodeBoolForKey:@"lancerAuDemarrage"];
    return self;
}

- (void)dealloc {
    [super dealloc];
}
@end

@implementation MesDonnesAnimations

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeBool:_animations forKey:@"animations"];
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    _animations = [aDecoder decodeBoolForKey:@"animations"];
    return self;
}

- (void)dealloc {
    [super dealloc];
}
@end

#pragma mark - Secouer

@implementation MesDonnesSecouer

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeBool:_secouer forKey:@"secouer"];
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    _secouer = [aDecoder decodeBoolForKey:@"secouer"];
    return self;
}

- (void)dealloc {
    [super dealloc];
}
@end

@implementation MesDonnesSecouerRotation

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeBool:_secouerRotation forKey:@"secouerRotation"];
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    _secouerRotation = [aDecoder decodeBoolForKey:@"secouerRotation"];
    return self;
}

- (void)dealloc {
    [super dealloc];
}
@end