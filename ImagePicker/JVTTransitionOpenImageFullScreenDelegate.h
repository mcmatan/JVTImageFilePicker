//
//  JVTRecentImagesTransitionDelegate.h
//  ImagePicker
//
//  Created by Matan Cohen on 4/5/16.
//  Copyright © 2016 Matan Cohen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JVTTransitionOpenImageFullScreenDismissCalles <NSObject>

-(void) didDissmiss;

@end

@import UIKit;
@interface JVTTransitionOpenImageFullScreenDelegate : NSObject <UIViewControllerTransitioningDelegate>
@property (nonatomic,assign ) CGRect openingFrame;
@property (nonatomic) UIView *dissmissAnimatingView;
@property (nonatomic,weak) id<JVTTransitionOpenImageFullScreenDismissCalles> delegate;
@end
