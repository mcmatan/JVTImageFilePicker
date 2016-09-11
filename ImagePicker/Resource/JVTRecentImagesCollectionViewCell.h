//
//  JVTRecentImagesCollectionViewCell.h
//  ImagePicker
//
//  Created by Matan Cohen on 4/5/16.
//  Copyright © 2016 Matan Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JVTRecentImagesCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *imageView;
- (void)setImage:(UIImage *)image;
+ (NSString *)cellIdentifer;
@end
