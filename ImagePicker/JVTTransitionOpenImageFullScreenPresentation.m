//
//  JVTTransitionOpenImageFullScreenPresentation.m
//  ImagePicker
//
//  Created by Matan Cohen on 4/5/16.
//  Copyright © 2016 Matan Cohen. All rights reserved.
//

#import "JVTTransitionOpenImageFullScreenPresentation.h"

static NSTimeInterval transitionDuration = 0.5;

@implementation JVTTransitionOpenImageFullScreenPresentation

-(NSTimeInterval) transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return transitionDuration;
}

-(void) animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    __block UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    __block UIView *containerView = [transitionContext containerView];
    
    NSTimeInterval animationDuration = [self transitionDuration:transitionContext];
    
    //Add blured background
    CGRect fromViewFrame = fromViewController.view.frame;
    
    UIGraphicsBeginImageContext(fromViewFrame.size);
    [fromViewController.view drawViewHierarchyInRect:fromViewFrame afterScreenUpdates:NO];
    UIGraphicsEndImageContext();
    
    __block UIView *snapShotView = [toViewController.view resizableSnapshotViewFromRect:toViewController.view.frame afterScreenUpdates:YES withCapInsets:UIEdgeInsetsZero];
    snapShotView.frame = self.openingFrame;
    [containerView addSubview:snapShotView];
    
    toViewController.view.alpha = 0;
    [containerView addSubview:toViewController.view];
    
    [UIView animateWithDuration:animationDuration delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:20.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        snapShotView.frame = fromViewController.view.frame;
    } completion:^(BOOL finished) {
        [snapShotView removeFromSuperview];
        toViewController.view.alpha = 1.0;
        [transitionContext completeTransition:finished];
    }];
    
    
}

@end
