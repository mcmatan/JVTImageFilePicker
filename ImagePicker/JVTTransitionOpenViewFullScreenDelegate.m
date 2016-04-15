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

@interface JVTTransitionOpenViewFullScreenDelegate ()
@property (nonatomic,strong) UIView *viewToPresentFrom;
@property (nonatomic,strong) UIView *viewToDissmissFrom;
@end

@implementation JVTTransitionOpenViewFullScreenDelegate
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    JVTTransitionOpenViewFullScreenPresentation *presentationAnimation = [JVTTransitionOpenViewFullScreenPresentation new];
    presentationAnimation.openingFrame = self.openingFrame;
    presentationAnimation.viewToPresentFrom = _viewToPresentFrom;
    return presentationAnimation;
}

-(id<UIViewControllerAnimatedTransitioning>) animationControllerForDismissedController:(UIViewController *)dismissed {
    JVTTransitionOpenViewFullScreenDismiss *dissmissAnimation = [JVTTransitionOpenViewFullScreenDismiss new];
    dissmissAnimation.openingFrame = self.openingFrame;
    dissmissAnimation.viewToDissmissFrom = self.viewToDissmissFrom;
    dissmissAnimation.dissmissBlock = ^{
        if (self.delegate) {
            [self.delegate didDissmiss];
        }
    };
    return dissmissAnimation;
    
}

-(void) setViewToPresentFrom:(UIView *) view {
    _viewToPresentFrom = view;
}

-(void) setViewToDissmissFrom:(UIView *) view {
    _viewToDissmissFrom = view;
}

@end
