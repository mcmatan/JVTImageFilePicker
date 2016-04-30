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

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    UIImage *image = [UIImage imageNamed:@"background.jpg"];
    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:image];
    backgroundImage.contentMode = UIViewContentModeScaleAspectFill;
    backgroundImage.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [self.view addSubview:backgroundImage];
    [self.view sendSubviewToBack:backgroundImage];
}

-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (!self.filePicker) {
        self.filePicker = [[JVTImageFilePicker alloc] init];
        self.filePicker.delegate = self;
        [self presentActionSheet];
    }
}

-(void) presentActionSheet {
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
