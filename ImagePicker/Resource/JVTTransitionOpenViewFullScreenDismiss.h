//
//  JVTTransitionOpenViewFullScreenDismiss.h
//  ImagePicker
//
//  Created by Matan Cohen on 4/15/16.
//  Copyright © 2016 Matan Cohen. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface JVTTransitionOpenViewFullScreenDismiss : NSObject <UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign)    CGRect openingFrame;
@property (nonatomic,weak) UIView *viewToDissmissFrom;
@property (nonatomic,strong) void (^dissmissBlock)();

@end
