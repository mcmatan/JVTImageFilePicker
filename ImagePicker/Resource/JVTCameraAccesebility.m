//
//  JVTCameraAccesebility.m
//  ImagePicker
//
//  Created by Matan Cohen on 4/17/16.
//  Copyright © 2016 Matan Cohen. All rights reserved.
//

#import "JVTCameraAccesebility.h"
@import AVFoundation;
@import Photos;
@import AssetsLibrary;

@implementation JVTCameraAccesebility

+ (void)getCameraAccessibilityAndRequestIfNeeded:(void (^)(BOOL allowedToUseCamera))callback {
    AVAuthorizationStatus authorizationState = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (authorizationState) {
        case AVAuthorizationStatusNotDetermined: {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo
                                     completionHandler:^(BOOL granted) {
                                         dispatch_async(dispatch_get_main_queue(), ^{
                                             callback(granted);
                                         });
                                     }];
        } break;
        case AVAuthorizationStatusDenied:
            callback(NO);
            break;
        case AVAuthorizationStatusAuthorized:
            callback(YES);
            break;
        default:
            break;
    }
}

+ (void)getPhotoRollAccessibilityAndRequestIfNeeded:(void (^)(BOOL allowedToUseCamera))callback {
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        switch (status) {
            case PHAuthorizationStatusAuthorized:
                callback(YES);
                break;
            case PHAuthorizationStatusRestricted:
            case PHAuthorizationStatusDenied:
                callback(NO);
                break;
            default:
                break;
        }
    }];
}
@end
