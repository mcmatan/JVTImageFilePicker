//
//  JVTActionSheetAction.m
//  ImagePicker
//
//  Created by Matan Cohen on 4/5/16.
//  Copyright © 2016 Matan Cohen. All rights reserved.
//

#import "JVTActionSheetAction.h"

@implementation JVTActionSheetAction

+ (JVTActionSheetAction *)actionWithTitle:(NSString *)title handler:(void (^)(JVTActionSheetAction *action))handler {
    return [[JVTActionSheetAction alloc] initWithActionWithTitle:title handler:handler];
}

- (instancetype)initWithActionWithTitle:(NSString *)title handler:(void (^)(JVTActionSheetAction *action))handler {
    self = [super init];
    if (self) {
        self.handler = handler;
        self.title = title;
    }
    return self;
}

@end
