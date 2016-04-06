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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    [self.imageView setImage:self.image];
    [self.imageView setContentMode:UIViewContentModeScaleAspectFill];
    [self.view addSubview:self.imageView];
    self.view.backgroundColor = [UIColor redColor];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    UIBarButtonItem *sendButton = [[UIBarButtonItem alloc] initWithTitle:@"Send" style:UIBarButtonItemStyleDone target:self action:@selector(pressSend)];
    self.navigationItem.rightBarButtonItem = sendButton;

    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self action:@selector(closeSelf)];
    self.navigationItem.leftBarButtonItem = back;

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

-(void) setImage:(UIImage *) image {
    _image = image;
}

-(void) closeSelf {
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self didTapOnScreen];

}


@end
