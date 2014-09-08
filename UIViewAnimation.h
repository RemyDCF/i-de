//
//  UIViewAnimation.h
//  i-de
//
//  Created by DCF on 08/09/2014.
//  Copyright (c) 2014 DCF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Animation)

- (void) moveTo:(CGPoint)destination duration:(float)secs option:(UIViewAnimationOptions)option;

@end
