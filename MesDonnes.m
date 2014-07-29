//
//  MesDonnes.m
//  Aleatoire
//
//  Created by DCF on 27/07/2014.
//  Copyright (c) 2014 Da Costa Faro Rémy. All rights reserved.
//

#import "MesDonnes.h"

@implementation MesDonnes

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_laChaine forKey:@"nombreFace"];
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    _laChaine = [aDecoder decodeObjectForKey:@"nombreFace"];
    [_laChaine retain];
    return self;
}

- (void)dealloc {
    [_laChaine release];
    _laChaine = nil;
    [super dealloc];
}
@end
