//
//  JVTOpenFullScreenTransitioinCameraVC.h
//  ImagePicker
//
//  Created by Matan Cohen on 4/14/16.
//  Copyright © 2016 Matan Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>
@import AVFoundation;

@protocol JVTOpenFullScreenTransitioinCameraVCDelegate <NSObject>

-(void) didPressTakeImage;

@end

@interface JVTOpenFullScreenTransitioinCameraVC : UIViewController
-(void) setViewToPresent:(UIView *) view ;
@property (nonatomic, weak) id<JVTOpenFullScreenTransitioinCameraVCDelegate> delegate;
@end
