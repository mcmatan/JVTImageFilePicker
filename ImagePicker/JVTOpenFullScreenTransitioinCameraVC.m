//
//  JVTOpenFullScreenTransitioinCameraVC.m
//  ImagePicker
//
//  Created by Matan Cohen on 4/14/16.
//  Copyright © 2016 Matan Cohen. All rights reserved.
//

#import "JVTOpenFullScreenTransitioinCameraVC.h"
#import "UIImagePickerController+Block.h"
#import "EXTScope.h"
#import "LLSimpleCamera.h"

@interface JVTOpenFullScreenTransitioinCameraVC ()
@property (nonatomic,strong) UIView *viewToPresent;
@property (nonatomic,strong) UIButton *snapButton;
@property (nonatomic, weak) UIView * originalSuperView;
@end


@implementation JVTOpenFullScreenTransitioinCameraVC

-(instancetype) init {
    self = [super init];
    if (self) {
        [self startImagePicker];
        [self configureButtons];
    }
    return self;
}

-(void) configureButtons {
    // snap button to capture image
    self.snapButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.snapButton.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width/2) - (70.0/2), [UIScreen mainScreen].bounds.size.height - 100.0, 70.0f, 70.0f);
    self.snapButton.clipsToBounds = YES;
    self.snapButton.layer.cornerRadius = self.snapButton.frame.size.width / 2.0f;
    self.snapButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.snapButton.layer.borderWidth = 2.0f;
    self.snapButton.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    self.snapButton.layer.rasterizationScale = [UIScreen mainScreen].scale;
    self.snapButton.layer.shouldRasterize = YES;
    [self.snapButton addTarget:self action:@selector(snapButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.snapButton];
}



-(void) setViewToPresent:(UIView *) view {
    _viewToPresent = view;
}

-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.originalSuperView = self.viewToPresent.superview;
    [self.view addSubview:self.viewToPresent];
    
    [self.view bringSubviewToFront:self.snapButton];
}

-(void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.originalSuperView addSubview:self.viewToPresent];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) startImagePicker {

}

-(void) snapButtonPressed:(UIButton *) button {
    [self.delegate didPressTakeImage];
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

@end
