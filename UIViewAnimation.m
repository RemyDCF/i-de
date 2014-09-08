//
//  UIViewAnimation.m
//  i-de
//
//  Created by DCF on 08/09/2014.
//  Copyright (c) 2014 DCF. All rights reserved.
//

#import "UIViewAnimation.h"

@implementation UIView (Animation)

- (void) moveTo:(CGPoint)destination duration:(float)secs option:(UIViewAnimationOptions)option
{
    [UIView animateWithDuration:secs delay:0.0 options:option
                     animations:^{
                         self.frame = CGRectMake(destination.x,destination.y, self.frame.size.width, self.frame.size.height);
                     }
                     completion:nil];
}
@end
