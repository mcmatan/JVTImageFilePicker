//
//  JVTActionSheetAction.m
//  ImagePicker
//
//  Created by Matan Cohen on 4/5/16.
//  Copyright © 2016 Matan Cohen. All rights reserved.
//

#import "JVTActionSheetAction.h"

@implementation JVTActionSheetAction

+ (JVTActionSheetAction *)actionWithTitle:(NSString *)title actionType:(kActionType) actionType handler:(void (^)(JVTActionSheetAction *action))handler {
    return [[JVTActionSheetAction alloc] initWithActionWithTitle:title actionType:actionType handler:handler];
}

- (instancetype)initWithActionWithTitle:(NSString *)title actionType:(kActionType) actionType handler:(void (^)(JVTActionSheetAction *action))handler {
    self = [super init];
    if (self) {
        self.actionType = actionType;
        self.handler = handler;
        self.title = title;
    }
    return self;
}

@end
