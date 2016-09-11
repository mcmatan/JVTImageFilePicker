//
//  JVTOpenFullScreenPresentationDismiss.h
//  ImagePicker
//
//  Created by Matan Cohen on 4/5/16.
//  Copyright © 2016 Matan Cohen. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;
@interface JVTTransitionOpenImageFullScreenDismiss : NSObject <UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign) CGRect openingFrame;
@property (nonatomic, assign) CGRect endingFrame;
@property (nonatomic, weak) UIView *animatingView;
@property (nonatomic, strong) void (^dissmissBlock)();
@end
