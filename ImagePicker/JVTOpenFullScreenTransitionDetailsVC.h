//
//  JVTOpenFullScreenTransitionDetailsVC.h
//  ImagePicker
//
//  Created by Matan Cohen on 4/5/16.
//  Copyright © 2016 Matan Cohen. All rights reserved.
//

@import UIKit;

@protocol JVTOpenFullScreenTransitionDetailsVCDelegate <NSObject>

-(void) didPressSendOnImage:(UIImage *) image;

@end

@interface JVTOpenFullScreenTransitionDetailsVC : UIViewController
-(instancetype) initWithImage:(UIImage *) image;
@property (nonatomic,weak) id<JVTOpenFullScreenTransitionDetailsVCDelegate> delegate;
@end
