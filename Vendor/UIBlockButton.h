//
//  UIButton+UIBlockButton.h
//  ImagePicker
//
//  Created by Matan Cohen on 4/5/16.
//  Copyright © 2016 Matan Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ActionBlock)();
@interface UIBlockButton : UIButton
-(void) handleControlEvent:(UIControlEvents)event
                 withBlock:(ActionBlock) action;
@end
