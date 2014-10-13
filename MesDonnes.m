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

@implementation MesDonnesLancerAuDemmarage

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeBool:_lancerAuDemmarage forKey:@"lancerAuDemmarage"];
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    _lancerAuDemmarage = [aDecoder decodeBoolForKey:@"lancerAuDemmarage"];
    return self;
}

- (void)dealloc {
    [super dealloc];
}
@end