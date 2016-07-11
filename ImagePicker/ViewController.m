//
//  ViewController.m
//  ImagePicker
//
//  Created by Matan Cohen on 4/5/16.
//  Copyright © 2016 Matan Cohen. All rights reserved.
//

#import "ViewController.h"
#import "JVTImageFilePicker.h"
#import "JVTRecentImagesProvider.h"
#import "JVTRecetImagesCollection.h"

#import "JVTActionSheetAction.h"
#import "JVTActionSheetView.h"

#import "LLSimpleCamera.h"
@import AVFoundation;

@interface ViewController ()<FilesPickerDelegate>
@property (nonatomic,strong) JVTImageFilePicker *filePicker;
@property (nonatomic,strong) JVTRecetImagesCollection *recentImagesCollection;
@property (nonatomic,strong) JVTActionSheetView *actionSheetView;


@property (nonatomic,strong) LLSimpleCamera *camera;
@end

@implementation ViewController {
    BOOL isFirstLoad;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        isFirstLoad = YES;
    }
    return self;
}

-(JVTImageFilePicker *) filePicker {
    if (!_filePicker) {
        _filePicker = [[JVTImageFilePicker alloc] init];
        _filePicker.delegate = self;
    }
    return _filePicker;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    UIImage *image = [UIImage imageNamed:@"background.jpg"];
    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:image];
    backgroundImage.contentMode = UIViewContentModeScaleAspectFill;
    backgroundImage.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [self.view addSubview:backgroundImage];
    [self.view sendSubviewToBack:backgroundImage];
    
    CGFloat paddnig = 100;
    CGFloat btnHeight = 50;
    UIButton *btnShowPicker = [[UIButton alloc] initWithFrame:CGRectMake(paddnig, self.view.frame.size.height * 0.6, self.view.frame.size.width - (paddnig *2) , btnHeight)];
    btnShowPicker.backgroundColor = [UIColor blackColor];
    [btnShowPicker addTarget:self action:@selector(tapShowPicker) forControlEvents:UIControlEventTouchUpInside];
    btnShowPicker.titleLabel.textColor = [UIColor whiteColor];
    [btnShowPicker setTitle:@"Show picker" forState:UIControlStateNormal];
    btnShowPicker.layer.masksToBounds = NO;
    btnShowPicker.layer.cornerRadius = 3.0;
    btnShowPicker.layer.shadowOffset = CGSizeMake(-15, 20);
    btnShowPicker.layer.shadowRadius = 5;
    btnShowPicker.layer.shadowOpacity = 0.5;
    [self.view addSubview:btnShowPicker];
}

-(void) tapShowPicker {
    [self showPicker];
}

-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (isFirstLoad) {
        [self showPicker];
    }
    isFirstLoad = NO;
}

-(void) showPicker {
    [self.filePicker presentFilesPickerOnController:self];
}


- (void)didPickFile:(NSData *)file
           fileName: (NSString *) fileName {
    NSLog(@"Did pick file");
}

- (void)didPickImage:(UIImage *)image
       withImageName:(NSString *) imageName {
    NSLog(@"Did pick image");
}


@end
