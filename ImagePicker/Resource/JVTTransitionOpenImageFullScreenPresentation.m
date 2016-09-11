//
//  JVTTransitionOpenImageFullScreenPresentation.m
//  ImagePicker
//
//  Created by Matan Cohen on 4/5/16.
//  Copyright © 2016 Matan Cohen. All rights reserved.
//

#import "JVTTransitionOpenImageFullScreenPresentation.h"
#import "EXTScope.h"

static NSTimeInterval transitionDuration = 0.5;

@implementation JVTTransitionOpenImageFullScreenPresentation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return transitionDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    __block UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    __block UIView *containerView = [transitionContext containerView];
    
    UIView *backgroundBlackView = [UIView new];
    backgroundBlackView.backgroundColor = [UIColor blackColor];
    backgroundBlackView.frame = CGRectMake(0, 0, CGRectGetWidth(containerView.frame), CGRectGetHeight(containerView.frame));
    backgroundBlackView.alpha = 0;
    
    [containerView addSubview:backgroundBlackView];
    
    NSTimeInterval animationDuration = [self transitionDuration:transitionContext];
    
    __block UIView *fromViewSnapShot = [toViewController.view resizableSnapshotViewFromRect:self.endingFrame afterScreenUpdates:YES withCapInsets:UIEdgeInsetsZero];
    fromViewSnapShot.frame = self.openingFrame;
    [containerView addSubview:fromViewSnapShot];
    
    toViewController.view.alpha = 0;
    [containerView addSubview:toViewController.view];
    
    @weakify(self);
    [UIView animateWithDuration:animationDuration
                          delay:0
         usingSpringWithDamping:0.8
          initialSpringVelocity:20.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         @strongify(self);
                         fromViewSnapShot.frame = self.endingFrame;
                         backgroundBlackView.alpha = 1;
                     }
                     completion:^(BOOL finished) {
                         toViewController.view.alpha = 1.0;
                         [backgroundBlackView removeFromSuperview];
                         [fromViewSnapShot removeFromSuperview];
                         [transitionContext completeTransition:finished];
                     }];
}

@end
