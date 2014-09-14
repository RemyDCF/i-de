//
//  MesDonnes.m
//  i-de
//
//  Created by DCF on 27/07/2014.
//  Copyright (c) 2014 Da Costa Faro Rémy. All rights reserved.
//

#import "MesDonnes.h"

@implementation MesDonnes

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeInt:_leNombre forKey:@"nombreFace"];
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    _leNombre = [aDecoder decodeIntForKey:@"nombreFace"];
    return self;
}

- (void)dealloc {
    [super dealloc];
}
@end
