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

- (void) downUnder:(float)secs option:(UIViewAnimationOptions)option
{
    [UIView animateWithDuration:secs delay:0.0 options:option
                     animations:^{
                         self.transform = CGAffineTransformRotate(self.transform, M_PI);
                     }
                     completion:nil];
}

- (void) addSubviewWithZoomInAnimation:(UIView*)view duration:(float)secs option:(UIViewAnimationOptions)option
{
    // first reduce the view to 1/100th of its original dimension
    CGAffineTransform trans = CGAffineTransformScale(view.transform, 0.01, 0.01);
    view.transform = trans;	// do it instantly, no animation
    [self addSubview:view];
    // now return the view to normal dimension, animating this tranformation
    [UIView animateWithDuration:secs delay:0.0 options:option
                     animations:^{
                         view.transform = CGAffineTransformScale(view.transform, 100.0, 100.0);
                     }
                     completion:nil];
}

- (void) removeWithZoomOutAnimation:(float)secs option:(UIViewAnimationOptions)option
{
    [UIView animateWithDuration:secs delay:0.0 options:option
                     animations:^{
                         self.transform = CGAffineTransformScale(self.transform, 0.01, 0.01);
                     }
                     completion:^(BOOL finished) {
                         [self removeFromSuperview];
                     }];
}

// add with a fade-in effect
- (void) addSubviewWithFadeAnimation:(UIView*)view duration:(float)secs option:(UIViewAnimationOptions)option
{
    view.alpha = 0.0;	// make the view transparent
    [self addSubview:view];	// add it
    [UIView animateWithDuration:secs delay:0.0 options:option
                     animations:^{view.alpha = 1.0;}
                     completion:nil];	// animate the return to visible
}

// remove self making it "drain" from the sink!
- (void) removeWithSinkAnimation:(int)steps
{
    NSTimer *timer;
    if (steps > 0 && steps < 100)	// just to avoid too much steps
        self.tag = steps;
    else
        self.tag = 50;
    timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(removeWithSinkAnimationRotateTimer:) userInfo:nil repeats:YES];
}
- (void) removeWithSinkAnimationRotateTimer:(NSTimer*) timer
{
    CGAffineTransform trans = CGAffineTransformRotate(CGAffineTransformScale(self.transform, 0.9, 0.9),0.314);
    self.transform = trans;
    self.alpha = self.alpha * 0.98;
    self.tag = self.tag - 1;
    if (self.tag <= 0)
    {
        [timer invalidate];
        [self removeFromSuperview];
    }
}
@end
