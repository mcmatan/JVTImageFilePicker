//
//  JVTTransitionOpenViewFullScreenDelegate.m
//  ImagePicker
//
//  Created by Matan Cohen on 4/15/16.
//  Copyright © 2016 Matan Cohen. All rights reserved.
//

#import "JVTTransitionOpenViewFullScreenDelegate.h"
#import "JVTTransitionOpenViewFullScreenPresentation.h"
#import "JVTTransitionOpenViewFullScreenDismiss.h"
#import "EXTScope.h"
@interface JVTTransitionOpenViewFullScreenDelegate ()
@property (nonatomic, weak) UIView *viewToPresentFrom;
@property (nonatomic, weak) UIView *viewToDissmissFrom;
@end

@implementation JVTTransitionOpenViewFullScreenDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    JVTTransitionOpenViewFullScreenPresentation *presentationAnimation = [JVTTransitionOpenViewFullScreenPresentation new];
    presentationAnimation.openingFrame = self.openingFrame;
    presentationAnimation.viewToPresentFrom = _viewToPresentFrom;
    return presentationAnimation;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    JVTTransitionOpenViewFullScreenDismiss *dissmissAnimation = [JVTTransitionOpenViewFullScreenDismiss new];
    dissmissAnimation.openingFrame = self.openingFrame;
    dissmissAnimation.viewToDissmissFrom = self.viewToDissmissFrom;
    @weakify(self);
    dissmissAnimation.dissmissBlock = ^{
        @strongify(self);
        if (self.delegate) {
            [self.delegate didDissmiss];
        }
    };
    return dissmissAnimation;
}

- (void)setViewToPresentFrom:(UIView *)view {
    _viewToPresentFrom = view;
}

- (void)setViewToDissmissFrom:(UIView *)view {
    _viewToDissmissFrom = view;
}

@end
