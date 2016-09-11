//
//  JVTRecentImagesCollectionView.h
//  ImagePicker
//
//  Created by Matan Cohen on 4/5/16.
//  Copyright © 2016 Matan Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JVTRecetImagesCollectionDelegate <NSObject>

-(void) didChooseImagesFromCollection:(UIImage *)image ;

@end

@interface JVTRecetImagesCollection : UIView
-(instancetype) initWithFrame:(CGRect)frame
          withImagesToDisplay:(NSArray<UIImage *>*) imagesToDisplay;
@property (nonatomic, weak) id<JVTRecetImagesCollectionDelegate> delegate;
@property (nonatomic, weak) UIViewController *presentingViewController;
@end
