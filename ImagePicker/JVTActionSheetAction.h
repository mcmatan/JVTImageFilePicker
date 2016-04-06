//
//  JVTActionSheetAction.h
//  ImagePicker
//
//  Created by Matan Cohen on 4/5/16.
//  Copyright © 2016 Matan Cohen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JVTActionSheetAction : NSObject
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) void(^handler)(JVTActionSheetAction *handlerResonse);
+ (JVTActionSheetAction *)actionWithTitle:(NSString *)title handler:(void (^)(JVTActionSheetAction *action))handler ;
@end
