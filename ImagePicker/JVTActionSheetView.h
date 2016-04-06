//
//  JVTCustomActionSheet.h
//  ImagePicker
//
//  Created by Matan Cohen on 4/5/16.
//  Copyright © 2016 Matan Cohen. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JVTActionSheetAction;
@import UIKit;
@interface JVTActionSheetView : NSObject
-(void)addHeaderView:(UIView *) headerView ;
- (void)addAction:(JVTActionSheetAction *)action;
-(void) presentOnTopOfView:(UIView *) view;
-(void) dismiss;
@end
