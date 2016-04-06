//
// Created by Matan Cohen on 1/13/16.
// Copyright (c) 2016 Matan Cohen. All rights reserved.
//

#import <Foundation/Foundation.h>


#import <UIKit/UIKit.h>

typedef void (^UIImagePickerControllerFinalizationBlock)(UIImagePickerController *picker, NSDictionary *info);
typedef void (^UIImagePickerControllerCancellationBlock)(UIImagePickerController *picker);

/**
 A category class adding block support to UIImagePickerController, replacing delegation implementation.
 */
@interface UIImagePickerController (Block)

/** A block to be executed whenever the user picks a new photo. Use this block to replace delegate method imagePickerController:didFinishPickingPhotoWithInfo: */
@property (nonatomic, strong) UIImagePickerControllerFinalizationBlock finalizationBlock;
/** A block to be executed whenever the user cancels the pick operation. Use this block to replace delegate method imagePickerControllerDidCancel: */
@property (nonatomic, strong) UIImagePickerControllerCancellationBlock cancellationBlock;

@end