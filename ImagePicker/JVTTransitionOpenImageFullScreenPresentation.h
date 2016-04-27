//
//  JVTTransitionOpenImageFullScreenPresentation.h
//  ImagePicker
//
//  Created by Matan Cohen on 4/5/16.
//  Copyright © 2016 Matan Cohen. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface JVTTransitionOpenImageFullScreenPresentation : NSObject <UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign)    CGRect openingFrame;
@property (nonatomic,assign ) CGRect endingFrame;
@end
