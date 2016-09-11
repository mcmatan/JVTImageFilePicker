//
//  JVTCustomActionSheet.h
//  ImagePicker
//
//  Created by Matan Cohen on 4/5/16.
//  Copyright © 2016 Matan Cohen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JVTActionSheetActionDelegate <NSObject>

- (void)actionSheetDidDismiss;

@end

@class JVTActionSheetAction;
@import UIKit;
@interface JVTActionSheetView : NSObject
@property (nonatomic, weak) id<JVTActionSheetActionDelegate> delegate;
- (void)addHeaderView:(UIView *)headerView;
- (void)addAction:(JVTActionSheetAction *)action;
- (void)presentOnTopOfView:(UIView *)view;
- (void)dismiss;
- (void)show;
- (BOOL)isPresented;
@end
