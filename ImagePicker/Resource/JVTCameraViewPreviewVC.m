//
//  JVTOpenFullScreenTransitioinCameraVC.m
//  ImagePicker
//
//  Created by Matan Cohen on 4/14/16.
//  Copyright © 2016 Matan Cohen. All rights reserved.
//

#import "JVTCameraViewPreviewVC.h"
#import "UIImagePickerController+Block.h"
#import "EXTScope.h"
#import "LLSimpleCamera.h"

@interface JVTCameraViewPreviewVC ()
@property (nonatomic, weak) UIView *viewToPresent;
@property (nonatomic, strong) UIButton *snapButton;
@property (nonatomic, weak) UIView *originalSuperView;

@property (nonatomic, strong) UIView *backgroundBlackTransparentView;
@end

@implementation JVTCameraViewPreviewVC

- (instancetype)init {
    self = [super init];
    if (self) {
        [self configureBottomInteractionsView];
    }
    return self;
}

- (void)configureBottomInteractionsView {
    self.backgroundBlackTransparentView = [UIView new];
    self.backgroundBlackTransparentView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    CGFloat backgroundViewHeight = 100;
    CGRect backgroundFrame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, backgroundViewHeight);
    [self.view addSubview:self.backgroundBlackTransparentView];
    
    self.backgroundBlackTransparentView.frame = backgroundFrame;
    
    UIButton *btnCancel = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnCancel setTitle:@"Cancel" forState:UIControlStateNormal];
    [btnCancel.titleLabel setTextColor:[UIColor whiteColor]];
    CGFloat btnCancelHeight = 50;
    CGRect btnCancelFrame = CGRectMake(20, (backgroundViewHeight / 2) - (btnCancelHeight / 2), 70, btnCancelHeight);
    btnCancel.frame = btnCancelFrame;
    [btnCancel addTarget:self action:@selector(dissmiss) forControlEvents:UIControlEventTouchUpInside];
    [self.backgroundBlackTransparentView addSubview:btnCancel];
    
    self.snapButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat snapBtnHeight = 70.0f;
    self.snapButton.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width / 2) - (70.0 / 2), (backgroundViewHeight / 2) - (snapBtnHeight / 2), snapBtnHeight, snapBtnHeight);
    self.snapButton.clipsToBounds = YES;
    self.snapButton.layer.cornerRadius = self.snapButton.frame.size.width / 2.0f;
    self.snapButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.snapButton.layer.borderWidth = 2.0f;
    self.snapButton.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    self.snapButton.layer.rasterizationScale = [UIScreen mainScreen].scale;
    self.snapButton.layer.shouldRasterize = YES;
    [self.snapButton addTarget:self action:@selector(snapButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.backgroundBlackTransparentView addSubview:self.snapButton];
}

- (void)setViewToPresent:(UIView *)view {
    _viewToPresent = view;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.originalSuperView = self.viewToPresent.superview;
    [self.view addSubview:self.viewToPresent];
    
    [self.view bringSubviewToFront:self.backgroundBlackTransparentView];
    
    [self showBottomInteractionsViewAnimation];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dissmiss:YES];
}

- (void)snapButtonPressed:(UIButton *)button {
    [self.delegate didPressTakeImage];
}

- (void)dissmiss:(BOOL)animated {
    [self.originalSuperView addSubview:self.viewToPresent];
    [self dismissViewControllerAnimated:animated completion:nil];
}

- (void)dissmiss {
    [self dissmiss:YES];
}

#pragma mark - animation

- (void)showBottomInteractionsViewAnimation {
    CGFloat backgroundViewHeight = self.backgroundBlackTransparentView.frame.size.height;
    CGRect backgroundFrame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - backgroundViewHeight, [UIScreen mainScreen].bounds.size.width, backgroundViewHeight);
    @weakify(self);
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         @strongify(self);
                         self.backgroundBlackTransparentView.frame = backgroundFrame;
                     }
                     completion:^(BOOL finished){
                     }];
}
@end
