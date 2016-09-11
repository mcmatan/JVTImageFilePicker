//
//  JVTRecentImagesVideoCollectionViewCell.m
//  ImagePicker
//
//  Created by Matan Cohen on 4/14/16.
//  Copyright © 2016 Matan Cohen. All rights reserved.
//

#import "JVTRecentImagesVideoCollectionViewCell.h"
@import AVFoundation;

@interface JVTRecentImagesVideoCollectionViewCell ()
@property (nonatomic, weak) UIView *viewToPresent;
@end

@implementation JVTRecentImagesVideoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
    }
    return self;
}

- (void)setViewToPresent:(UIView *)view {
    _viewToPresent = view;
    [self.contentView addSubview:_viewToPresent];
}

+ (NSString *)cellIdentifer {
    return NSStringFromClass([self class]);
}

@end
