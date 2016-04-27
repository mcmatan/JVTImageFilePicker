//
//  JVTOpenFullScreenPresentationDismiss.m
//  ImagePicker
//
//  Created by Matan Cohen on 4/5/16.
//  Copyright © 2016 Matan Cohen. All rights reserved.
//

#import "JVTTransitionOpenImageFullScreenDismiss.h"
#import "EXTScope.h"
static NSTimeInterval transitionDuration = 0.3;

@implementation JVTTransitionOpenImageFullScreenDismiss

-(NSTimeInterval) transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return transitionDuration;
}

-(void) animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    __block UIView *containerView = [transitionContext containerView];
    
    NSTimeInterval animationDuration = [self transitionDuration:transitionContext];
    
    __block UIView *openigViewSnapShot = [fromViewController.view resizableSnapshotViewFromRect:self.endingFrame afterScreenUpdates:YES withCapInsets:UIEdgeInsetsZero];
    openigViewSnapShot.frame = self.endingFrame;
    [containerView addSubview:openigViewSnapShot];
    
    fromViewController.view.alpha = 0;
    @weakify(self);
    [UIView animateWithDuration:animationDuration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        @strongify(self);
        openigViewSnapShot.frame = self.openingFrame;
    } completion:^(BOOL finished) {
        [fromViewController.view removeFromSuperview];
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        if (self.dissmissBlock) {
            self.dissmissBlock();
        }
    }];
    
}

@end
