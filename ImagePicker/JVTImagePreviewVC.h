//
//  JVTOpenFullScreenTransitionDetailsVC.h
//  ImagePicker
//
//  Created by Matan Cohen on 4/5/16.
//  Copyright © 2016 Matan Cohen. All rights reserved.
//

@import UIKit;

@protocol JVTImagePreviewVCDelegate <NSObject>

-(void) didPressSendOnImage:(UIImage *) image;

@end

@interface JVTImagePreviewVC : UIViewController
-(instancetype) initWithImage:(UIImage *) image;
-(CGRect) rectForImageView:(UIImage *) image ;
@property (nonatomic,weak) id<JVTImagePreviewVCDelegate> delegate;
@end
