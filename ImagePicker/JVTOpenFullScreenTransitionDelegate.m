//
//  JVTRecentImagesTransitionDelegate.m
//  ImagePicker
//
//  Created by Matan Cohen on 4/5/16.
//  Copyright © 2016 Matan Cohen. All rights reserved.
//

#import "JVTOpenFullScreenTransitionDelegate.h"
#import "JVTOpenFullScreenPresentationAnimator.h"
#import "JVTOpenFullScreenDismiss.h"

@implementation JVTOpenFullScreenTransitionDelegate  {
    
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
 
    JVTOpenFullScreenPresentationAnimator *presentationAnimation = [JVTOpenFullScreenPresentationAnimator new];
    presentationAnimation.openingFrame = self.openingFrame;
    return presentationAnimation;
}

-(id<UIViewControllerAnimatedTransitioning>) animationControllerForDismissedController:(UIViewController *)dismissed {
    JVTOpenFullScreenDismiss *dissmissAnimation = [JVTOpenFullScreenDismiss new];
    dissmissAnimation.openingFrame = self.openingFrame;
    return dissmissAnimation;
    
}

@end
