//
//  JVTCameraAccesebility.h
//  ImagePicker
//
//  Created by Matan Cohen on 4/17/16.
//  Copyright © 2016 Matan Cohen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JVTCameraAccesebility : NSObject
+(void) getCameraAccessibilityAndRequestIfNeeded:(void(^)(BOOL allowedToUseCamera))callback  ;
+(void) getPhotoRollAccessibilityAndRequestIfNeeded:(void(^)(BOOL allowedToUseCamera))callback  ;
@end
