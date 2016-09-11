//
//  JVTRecentImagesCollectionViewCell.m
//  ImagePicker
//
//  Created by Matan Cohen on 4/5/16.
//  Copyright © 2016 Matan Cohen. All rights reserved.
//

#import "JVTRecentImagesCollectionViewCell.h"

@interface JVTRecentImagesCollectionViewCell ()
@end

@implementation JVTRecentImagesCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        [self.imageView setContentMode:UIViewContentModeScaleAspectFill];
        self.imageView.clipsToBounds = YES;
        [self addSubview:self.imageView];
    }
    return self;
}

- (void)setImage:(UIImage *)image {
    [self.imageView setImage:image];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.imageView.image = nil;
}

+ (NSString *)cellIdentifer {
    return NSStringFromClass([self class]);
}
@end
