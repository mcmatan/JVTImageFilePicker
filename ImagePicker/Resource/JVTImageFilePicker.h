//
//  FilesPicker.h
//  ImagePickerMC
//
//  Created by Matan Cohen on 1/13/16.
//  Copyright © 2016 Matan Cohen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JVTImagePreviewVC.h"

@import UIKit;
@class JVTActionSheetAction;
@protocol FilesPickerDelegate <NSObject>
- (void)didPickFile:(NSData *)file
           fileName:(NSString *)fileName;
- (void)didPickImage:(UIImage *)image
       withImageName:(NSString *)imageName;
@optional
- (void)didDismissFilesPicker;
@end

@interface JVTImageFilePicker : NSObject <UIDocumentPickerDelegate, UIDocumentMenuDelegate, JVTImagePreviewVCDelegate>
@property (nonatomic,assign) CGSize imageResizeSize;
@property (weak) id<FilesPickerDelegate> delegate;

- (void)presentFilesPickerOnController:(UIViewController *)presentFromController;
- (void)presentFilesPickerOnController:(UIViewController *)presentFromController
  withAddingCustomActionsToActionSheet:(NSArray<JVTActionSheetAction *> *)customAlertActions;
@end
