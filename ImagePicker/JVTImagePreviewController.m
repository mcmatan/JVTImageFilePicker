//
// Created by Matan Lachmish on 29/03/2016.
// Copyright (c) 2016 Jive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JVTImagePreviewController.h"

@interface JVTImagePreviewController ()

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, strong) UIImageView *imagePreview;

@end

@implementation JVTImagePreviewController


- (id)initWithImage:(UIImage *)image imageName:(NSString *)imageName {
    self = [super init];
    if (self) {
        _image = image;
        _imageName = imageName;
        _imagePreview = [[UIImageView alloc] init];
    }
    return self;
}

- (void)dealloc {
    self.delegate = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = NSLocalizedString(@"image.preview.title", @"Preview");
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"image.preview.send", @"Send") style:UIBarButtonItemStylePlain target:self action:@selector(confirmSelection:)];

    //Force the navigation bar to be present before display.
    [self.navigationController setNavigationBarHidden:NO animated:NO];

    //Configure the imageView
    [self.imagePreview setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.imagePreview.contentMode = UIViewContentModeScaleAspectFit;
    self.imagePreview.userInteractionEnabled = YES;
    [self.view addSubview:self.imagePreview];
    NSDictionary *metrics = @{@"spacing" : @(10), @"topLayout" : @(20)};
    NSDictionary *views = @{@"imagePreview":self.imagePreview};

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(==spacing)-[imagePreview]-(==spacing)-|" options:NSLayoutFormatAlignAllCenterY metrics:metrics views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(==topLayout)-[imagePreview]-(==spacing)-|" options:0 metrics:metrics views:views]];
    self.imagePreview.image = self.image;

    //Simple tap gesture to show/hide the navigation bar
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    [self.imagePreview addGestureRecognizer:tapGestureRecognizer];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma mark - Private

- (void)handleTapGesture:(id)sender {
    [self.navigationController setNavigationBarHidden:self.navigationController.navigationBarHidden animated:YES];
}

- (void)confirmSelection:(id)sender {
    if ([self.delegate respondsToSelector:@selector(imagePreviewController:didConfirmImageSelection:ImageName:)]) {
        [self.delegate imagePreviewController:self didConfirmImageSelection:self.image ImageName:self.imageName];
    }
}

@end
