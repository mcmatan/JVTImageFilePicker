//
//  JVTOpenFullScreenPresentationDismiss.m
//  ImagePicker
//
//  Created by Matan Cohen on 4/5/16.
//  Copyright © 2016 Matan Cohen. All rights reserved.
//

#import "JVTOpenFullScreenDismiss.h"
#import "EXTScope.h"
static NSTimeInterval transitionDuration = 0.3;

@implementation JVTOpenFullScreenDismiss

-(NSTimeInterval) transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return transitionDuration;
}

-(void) animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    __block UIView *containerView = [transitionContext containerView];
    
    NSTimeInterval animationDuration = [self transitionDuration:transitionContext];
    
    __block UIView *snapShotView = [fromViewController.view resizableSnapshotViewFromRect:fromViewController.view.bounds afterScreenUpdates:YES withCapInsets:UIEdgeInsetsZero];
    [containerView addSubview:snapShotView];
    
    fromViewController.view.alpha = 0;
    @weakify(self);
    [UIView animateWithDuration:animationDuration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        @strongify(self);
        snapShotView.frame = self.openingFrame;
    } completion:^(BOOL finished) {
        [snapShotView removeFromSuperview];
        [fromViewController.view removeFromSuperview];
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
    
}

@end
