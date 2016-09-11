//
//  JVTOpenFullScreenTransitionDetailsVC.m
//  ImagePicker
//
//  Created by Matan Cohen on 4/5/16.
//  Copyright © 2016 Matan Cohen. All rights reserved.
//

#import "JVTImagePreviewVC.h"
#import "EXTScope.h"

@interface JVTImagePreviewVC () {
    CGPoint startPosition;
}
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIView *backgroundBlackTransparentView;
@property (nonatomic, strong) UIImageView *imageView;
;

@end

@implementation JVTImagePreviewVC

- (instancetype)initWithImage:(UIImage *)image {
    self = [super init];
    if (self) {
        _image = image;
        _imageView = [[UIImageView alloc] init];
        [self view];
        [self.view setNeedsDisplay];
        [self.view setNeedsLayout];
        [self.view updateConstraints];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self setupImageView];
    
    self.backgroundBlackTransparentView = [UIView new];
    self.backgroundBlackTransparentView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    CGFloat backgroundViewHeight = 100;
    CGRect backgroundFrame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, backgroundViewHeight);
    [self.view addSubview:self.backgroundBlackTransparentView];
    self.backgroundBlackTransparentView.frame = backgroundFrame;
    
    CGFloat btnWidth = 70;
    CGFloat btnPaddingFromLeft = 0;
    UIButton *btnCancel = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnCancel setTitle:@"Cancel" forState:UIControlStateNormal];
    [btnCancel.titleLabel setTextColor:[UIColor whiteColor]];
    CGFloat btnCancelHeight = 50;
    CGRect btnCancelFrame = CGRectMake(btnPaddingFromLeft, (backgroundViewHeight / 2) - (btnCancelHeight / 2), btnWidth, btnCancelHeight);
    btnCancel.frame = btnCancelFrame;
    [btnCancel addTarget:self action:@selector(closeSelf) forControlEvents:UIControlEventTouchUpInside];
    [self.backgroundBlackTransparentView addSubview:btnCancel];
    
    UIButton *btnSend = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnSend setTitle:@"Send" forState:UIControlStateNormal];
    [btnSend.titleLabel setTextColor:[UIColor whiteColor]];
    CGRect btnSendFrame = CGRectMake([UIScreen mainScreen].bounds.size.width - btnWidth - btnPaddingFromLeft, (backgroundViewHeight / 2) - (btnCancelHeight / 2), btnWidth, btnCancelHeight);
    btnSend.frame = btnSendFrame;
    [btnSend addTarget:self action:@selector(pressSend) forControlEvents:UIControlEventTouchUpInside];
    [self.backgroundBlackTransparentView addSubview:btnSend];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self showBottomInteractionsViewAnimation];
}

- (void)setupImageView {
    [self.view addSubview:[self imageView]];
}

- (UIImageView *)imageView {
    //Configure the imageView
    _imageView = [[UIImageView alloc] init];
    [_imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView.clipsToBounds = YES;
    
    _imageView.userInteractionEnabled = YES;
    [self.view addSubview:_imageView];
    NSDictionary *metrics = @{ @"spacing" : @(0),
                               @"topLayout" : @(20) };
    NSDictionary *views = @{ @"imagePreview" : _imageView };
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[imagePreview]|" options:NSLayoutFormatAlignAllCenterY metrics:metrics views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[imagePreview]|" options:0 metrics:metrics views:views]];
    _imageView.image = self.image;
    
    [_imageView layoutIfNeeded];
    [self.view layoutIfNeeded];
    
    return _imageView;
}

- (CGRect)rectForImageView:(UIImage *)image {
    if (image.size.width > image.size.height) {
        CGFloat imageHeight = self.imageView.frame.size.width * (image.size.height / image.size.width);
        return CGRectMake(0, self.view.frame.size.height / 2 - (imageHeight / 2), self.imageView.frame.size.width, imageHeight);
    } else {
        CGFloat imageWidth = self.view.frame.size.width;
        CGFloat imageHeight = imageWidth * (image.size.height / image.size.width);
        return CGRectMake(0, self.view.frame.size.height / 2 - (imageHeight / 2), imageWidth, imageHeight);
    }
    
    return self.imageView.frame;
}

- (void)didTapOnScreen {
    [self closeSelf];
}

- (void)pressSend {
    [self.delegate didPressSendOnImage:self.image];
    [self closeSelf];
}

- (void)closeSelf {
    [self.backgroundBlackTransparentView removeFromSuperview];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    @weakify(self);
    [self dismissViewControllerAnimated:YES
                             completion:^{
                                 @strongify(self);
                                 if ([self.delegate respondsToSelector:@selector(didDismissImagePreview)]) {
                                     [self.delegate didDismissImagePreview];
                                 }
                             }];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self didTapOnScreen];
}

#pragma mark - animation

- (void)showBottomInteractionsViewAnimation {
    [self.view bringSubviewToFront:self.backgroundBlackTransparentView];
    CGFloat backgroundViewHeight = self.backgroundBlackTransparentView.frame.size.height;
    @weakify(self);
    CGRect backgroundFrame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - backgroundViewHeight, [UIScreen mainScreen].bounds.size.width, backgroundViewHeight);
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
