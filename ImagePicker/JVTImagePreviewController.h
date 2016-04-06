//
// Created by Matan Lachmish on 29/03/2016.
// Copyright (c) 2016 Jive. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JVTImagePreviewController;

@protocol JVTImagePreviewControllerDelegate <NSObject>

@optional
- (void)imagePreviewController:(JVTImagePreviewController *)controller didConfirmImageSelection:(UIImage *)image ImageName:(NSString *)imageName;

@end

@interface JVTImagePreviewController : UIViewController

@property (nonatomic, weak) id<JVTImagePreviewControllerDelegate> delegate;

- (id)initWithImage:(UIImage *)image imageName:(NSString *)imageName;

@end