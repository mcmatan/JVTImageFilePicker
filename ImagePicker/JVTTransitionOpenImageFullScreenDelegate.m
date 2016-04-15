//
//  JVTRecentImagesTransitionDelegate.m
//  ImagePicker
//
//  Created by Matan Cohen on 4/5/16.
//  Copyright © 2016 Matan Cohen. All rights reserved.
//

#import "JVTTransitionOpenImageFullScreenDelegate.h"
#import "JVTTransitionOpenImageFullScreenPresentation.h"
#import "JVTTransitionOpenImageFullScreenDismiss.h"

@implementation JVTTransitionOpenImageFullScreenDelegate {
    
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
 
    JVTTransitionOpenImageFullScreenPresentation *presentationAnimation = [JVTTransitionOpenImageFullScreenPresentation new];
    presentationAnimation.openingFrame = self.openingFrame;
    return presentationAnimation;
}

-(id<UIViewControllerAnimatedTransitioning>) animationControllerForDismissedController:(UIViewController *)dismissed {
    JVTTransitionOpenImageFullScreenDismiss *dissmissAnimation = [JVTTransitionOpenImageFullScreenDismiss new];
    dissmissAnimation.openingFrame = self.openingFrame;
    dissmissAnimation.dissmissBlock = ^{
        if (self.delegate) {
            [self.delegate didDissmiss];
        }
    };
    return dissmissAnimation;
    
}

@end
