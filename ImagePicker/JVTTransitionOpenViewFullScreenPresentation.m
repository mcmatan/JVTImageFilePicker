//
//  JVTTransitionOpenViewFullScreenPresentation.m
//  ImagePicker
//
//  Created by Matan Cohen on 4/15/16.
//  Copyright © 2016 Matan Cohen. All rights reserved.
//

#import "JVTTransitionOpenViewFullScreenPresentation.h"
#import "EXTScope.h"
static NSTimeInterval transitionDuration = 0.5;
@implementation JVTTransitionOpenViewFullScreenPresentation

-(NSTimeInterval) transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return transitionDuration;
}

-(void) animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    __block UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    __block UIView *containerView = [transitionContext containerView];
    
    NSTimeInterval animationDuration = [self transitionDuration:transitionContext];
    
    toViewController.view.alpha = 0;
    [containerView addSubview:toViewController.view];
    
    @weakify(self);
    [UIView animateWithDuration:animationDuration delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:20.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        @strongify(self);
        self.viewToPresentFrom.frame = fromViewController.view.frame;
    } completion:^(BOOL finished) {
        toViewController.view.alpha = 1.0;
        [transitionContext completeTransition:finished];
    }];
    
    
}

@end
