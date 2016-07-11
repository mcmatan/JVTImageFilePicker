//
//  JVTCustomActionSheet.m
//  ImagePicker
//
//  Created by Matan Cohen on 4/5/16.
//  Copyright © 2016 Matan Cohen. All rights reserved.
//

#import "JVTActionSheetView.h"
#import "JVTActionSheetAction.h"
#import "UIBlockButton.h"
#import "EXTScope.h"
@import UIKit;

static CGFloat itemHeight = 50;

@interface JVTActionSheetView () {}
@property (nonatomic,strong) NSMutableArray<JVTActionSheetAction *> *actions;
@property (nonatomic,weak) UIView *headerView;
@property (nonatomic,assign) CGFloat sheetWidth;
@property (nonatomic,strong) UIView *sheetView;
@property (nonatomic,weak) UIView *presentingOnView;
@property (nonatomic, assign) BOOL isPresented;
@end

@implementation JVTActionSheetView

-(instancetype) init {
    self = [super init];
    if (self) {
        self.actions = [NSMutableArray array];    }
    return self;
}

- (void)addAction:(JVTActionSheetAction *)action {
    [self.actions addObject:action];
}

-(void)addHeaderView:(UIView *) headerView {
    self.headerView = headerView;
}

-(void) dismiss {
    [self endPresentationAnimation];
}

-(void) show {
    [self startPresentationAnimation];
}

-(void) presentOnTopOfView:(UIView *) view {
    if (self.isPresented) {
        return;
    }
    self.isPresented = YES;
    self.presentingOnView = view;
    self.sheetWidth = view.frame.size.width;
    
    CGFloat topPadding = 0;
    self.sheetView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.sheetWidth, topPadding)];
    self.sheetView.backgroundColor = [UIColor whiteColor];
    
    if (self.headerView) {
        
        CGRect oldSheetViewFrame = self.sheetView.frame;
        oldSheetViewFrame.size.height += self.headerView.frame.size.height;
        self.sheetView.frame = oldSheetViewFrame;
        
        CGRect itemViewFrame = self.headerView.frame;
        itemViewFrame.origin.y = 0;
        self.headerView.frame = itemViewFrame;
        
        [self.sheetView addSubview:self.headerView];
    }
    
    for (JVTActionSheetAction *action in self.actions) {
        
        UIView *itemView = [self itemViewForAction:action];
        
        CGRect oldSheetViewFrame = self.sheetView.frame;
        oldSheetViewFrame.size.height += itemView.frame.size.height;
        self.sheetView.frame = oldSheetViewFrame;
        
        CGRect itemViewFrame = itemView.frame;
        itemViewFrame.origin.y = self.sheetView.frame.size.height - itemViewFrame.size.height;
        itemView.frame = itemViewFrame;
        
        [self.sheetView addSubview:itemView];
    }
    
    
    [self.sheetView setHidden:YES];
    
    [view addSubview:self.sheetView];
    
    [self startPresentationAnimation];
}

-(void) startPresentationAnimation {
    CGRect startFrame = self.sheetView.frame;
    startFrame.origin.y = self.presentingOnView.bounds.size.height;
    CGRect endFrame = startFrame;
    endFrame.origin.y = self.presentingOnView.bounds.size.height - startFrame.size.height;
    
    [self.sheetView setFrame:startFrame];
    [self.sheetView setHidden:NO];
    
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.sheetView setFrame:endFrame];
    } completion:^(BOOL finished) {}];
}

-(void) endPresentationAnimation {
    CGRect endFrame = self.sheetView.frame;
    endFrame.origin.y = self.presentingOnView.bounds.size.height;

    @weakify(self);
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        @strongify(self);
        [self.sheetView setFrame:endFrame];
    } completion:^(BOOL finished) {
        @strongify(self);
        self.isPresented = NO;

        if (self.delegate) {
            [self.delegate actionSheetDidDismiss];
        }
    }];
}

-(UIView *) itemViewForAction:(JVTActionSheetAction *) action {
    UIView *view = [[UIView alloc] init];
    CGFloat linePaddingFromLeft = 10;
    UIView *topLineView = [[UIView alloc] initWithFrame:CGRectMake(linePaddingFromLeft, 0, self.sheetWidth - linePaddingFromLeft, 0.5)];
    topLineView.backgroundColor = [UIColor colorWithRed:221.0/255.0 green:221.0/255.0 blue:221.0/255.0 alpha:1.0];
    [view addSubview:topLineView];
    UIBlockButton *btn = [[UIBlockButton alloc] init];
    [btn setTitle:action.title forState:UIControlStateNormal];
    [btn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [btn setTitleColor:[UIColor colorWithRed:46.0/255.0 green:145.0/255.0 blue:255.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    
    [view setFrame:CGRectMake(0, 0, self.sheetWidth, itemHeight)];
    [btn setFrame:view.frame];
    [view addSubview:btn];
    
    CGFloat fontSize = 18;
    CGFloat fontWeight = action.actionType == kActionType_default ? UIFontWeightRegular : UIFontWeightSemibold;
    [btn.titleLabel setFont:[UIFont systemFontOfSize:fontSize weight:fontWeight]];
    
    @weakify(self);
    [btn handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        @strongify(self);
        [self endPresentationAnimation];
        action.handler(action);
    }];
    
    return view;
}

-(void) didTapOnDimmedBackground {
    [self dismiss];
}

@end
