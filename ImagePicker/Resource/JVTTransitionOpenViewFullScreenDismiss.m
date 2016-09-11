//
//  JVTTransitionOpenViewFullScreenDismiss.m
//  ImagePicker
//
//  Created by Matan Cohen on 4/15/16.
//  Copyright © 2016 Matan Cohen. All rights reserved.
//

#import "JVTTransitionOpenViewFullScreenDismiss.h"
#import "EXTScope.h"
static NSTimeInterval transitionDuration = 0.3;

@implementation JVTTransitionOpenViewFullScreenDismiss

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return transitionDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    NSTimeInterval animationDuration = [self transitionDuration:transitionContext];
    
    fromViewController.view.alpha = 0;
    @weakify(self);
    [UIView animateWithDuration:animationDuration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         @strongify(self);
                         self.viewToDissmissFrom.frame = self.openingFrame;
                     }
                     completion:^(BOOL finished) {
                         //[snapShotView removeFromSuperview];
                         [fromViewController.view removeFromSuperview];
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                         if (self.dissmissBlock) {
                             self.dissmissBlock();
                         }
                     }];
}

@end
