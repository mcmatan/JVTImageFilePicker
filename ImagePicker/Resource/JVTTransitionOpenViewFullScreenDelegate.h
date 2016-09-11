//
//  JVTTransitionOpenViewFullScreenDelegate.h
//  ImagePicker
//
//  Created by Matan Cohen on 4/15/16.
//  Copyright © 2016 Matan Cohen. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@protocol JVTTransitionOpenViewFullScreenDelegateDismissCalles <NSObject>

- (void)didDissmiss;

@end

@interface JVTTransitionOpenViewFullScreenDelegate : NSObject <UIViewControllerTransitioningDelegate>
@property (nonatomic, assign) CGRect openingFrame;
@property (nonatomic, weak) id<JVTTransitionOpenViewFullScreenDelegateDismissCalles> delegate;
- (void)setViewToPresentFrom:(UIView *)view;
- (void)setViewToDissmissFrom:(UIView *)view;
@end
