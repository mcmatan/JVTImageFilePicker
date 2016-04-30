//
//  JVTCustomCamera.h
//  ImagePicker
//
//  Created by Matan Cohen on 4/14/16.
//  Copyright © 2016 Matan Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>
@import AVFoundation;

@interface JVTCustomCameraView : UIViewController

@property (nonatomic,strong) AVCaptureSession *session;

-(instancetype) init;
-(instancetype) initWithViewToPresentOn:(UIView *) viewToPresentOn;

-(void) takeImage:(void(^)(UIImage *image)) callback;
-(void) setViewToPresentOn:(UIView *) view ;
@end
