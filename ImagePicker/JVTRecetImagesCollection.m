//
//  JVTRecentImagesCollectionView.m
//  ImagePicker
//
//  Created by Matan Cohen on 4/5/16.
//  Copyright © 2016 Matan Cohen. All rights reserved.
//

#import "JVTRecetImagesCollection.h"
#import "JVTRecentImagesCollectionViewCell.h"
#import "JVTOpenFullScreenTransitionDelegate.h"
#import "JVTOpenFullScreenTransitionDetailsVC.h"
static NSString *cellIdentifier = @"Cell";
@interface JVTRecetImagesCollection () <UICollectionViewDelegate, UICollectionViewDataSource, JVTOpenFullScreenTransitionDetailsVCDelegate>
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSArray<UIImage *> *imagesModel;

@property (nonatomic,strong) JVTOpenFullScreenTransitionDelegate *transitionDelegate;
@property (nonatomic,strong) JVTOpenFullScreenTransitionDetailsVC *vc;
@end

@implementation JVTRecetImagesCollection

-(instancetype) initWithFrame:(CGRect)frame
          withImagesToDisplay:(NSArray<UIImage *>*) imagesToDisplay{
    self = [super initWithFrame:frame];
    if (self) {
        self.imagesModel = imagesToDisplay;
        [self setupCollection];
    }
    return self;
}

-(void) setupCollection {
    CGFloat aspectRatio =  [UIScreen mainScreen].bounds.size.height / [UIScreen mainScreen].bounds.size.width;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat width = CGRectGetHeight(self.frame) * 0.6;
    flowLayout.itemSize = CGSizeMake(width, width * aspectRatio);
    flowLayout.minimumLineSpacing = 5.0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)) collectionViewLayout:flowLayout];
    [self.collectionView registerClass:[JVTRecentImagesCollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
    [self addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
}

#pragma mark - CollectionView deleegate data source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imagesModel.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JVTRecentImagesCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell setImage:self.imagesModel[indexPath.row]];
    return cell;
}

-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UIViewController *presentingViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UICollectionViewLayoutAttributes *att = [collectionView layoutAttributesForItemAtIndexPath:indexPath];
    CGRect attFrame = att.frame;
    CGRect frameToOpenFrom = [collectionView convertRect:attFrame toView:presentingViewController.view];
    
    self.transitionDelegate = [[JVTOpenFullScreenTransitionDelegate alloc] init];
    self.transitionDelegate.openingFrame = frameToOpenFrom;
    
    self.vc = [[JVTOpenFullScreenTransitionDetailsVC alloc] init];
    self.vc.delegate = self;
    [self.vc setImage:self.imagesModel[indexPath.row]];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:self.vc];
    nav.transitioningDelegate = self.transitionDelegate;
    nav.modalPresentationStyle = UIModalPresentationCustom;
    [presentingViewController presentViewController:nav animated:YES completion:nil];
    
}

-(void) didPressSendOnImage:(UIImage *)image {
    [self.delegate didPressSendOnImage:image];
}
@end
