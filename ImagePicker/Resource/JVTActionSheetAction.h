//
//  JVTActionSheetAction.h
//  ImagePicker
//
//  Created by Matan Cohen on 4/5/16.
//  Copyright © 2016 Matan Cohen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, kActionType) {
    kActionType_default,
    kActionType_cancel,
};

@interface JVTActionSheetAction : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) kActionType actionType;
@property (nonatomic, strong) void (^handler)(JVTActionSheetAction *handlerResonse);
+ (JVTActionSheetAction *)actionWithTitle:(NSString *)title actionType:(kActionType)actionType handler:(void (^)(JVTActionSheetAction *action))handler;
@end
