//
//  JVTOpenFullScreenTransitionDetailsVC.m
//  ImagePicker
//
//  Created by Matan Cohen on 4/5/16.
//  Copyright © 2016 Matan Cohen. All rights reserved.
//

#import "JVTOpenFullScreenTransitionDetailsVC.h"

@interface JVTOpenFullScreenTransitionDetailsVC () {
    CGPoint startPosition;
}
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UIImage *image;
@end

@implementation JVTOpenFullScreenTransitionDetailsVC

-(instancetype) initWithImage:(UIImage *) image
{
    self = [super init];
    if (self) {
        _image = image;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupImageView];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    UIBarButtonItem *sendButton = [[UIBarButtonItem alloc] initWithTitle:@"Send" style:UIBarButtonItemStyleDone target:self action:@selector(pressSend)];
    self.navigationItem.rightBarButtonItem = sendButton;

    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self action:@selector(closeSelf)];
    self.navigationItem.leftBarButtonItem = back;

}

-(void) setupImageView {
    
    self.imageView = [[UIImageView alloc] initWithFrame:[self rectForImageView:_image]];
    [self.imageView setImage:self.image];
    [self.imageView setContentMode:UIViewContentModeScaleAspectFill];
    [self.view addSubview:self.imageView];
    
}

-(CGRect) rectForImageView:(UIImage *) image {
    CGFloat screenWidth = CGRectGetWidth(self.view.frame);
    CGFloat screenHeight = CGRectGetHeight(self.view.frame);
    CGFloat screenAspectRatio =  screenWidth / screenHeight;
    if (image.size.width > image.size.height) {
        CGFloat imageHeight = screenWidth * screenAspectRatio;
        CGFloat imageWidth = screenWidth;
        return CGRectMake(0, (screenHeight / 2) - (imageHeight / 2), imageWidth, imageHeight);
    } else {
        return CGRectMake(0, 0, screenWidth, screenHeight);
    }
}

-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}


-(void) didTapOnScreen{
    [self closeSelf];
}

-(void) pressSend {
    [self.delegate didPressSendOnImage:self.image];
    [self closeSelf];    
}

-(void) closeSelf {
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self didTapOnScreen];

}


@end
