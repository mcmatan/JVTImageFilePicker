//
//  JVTRecentImagesCollectionView.m
//  ImagePicker
//
//  Created by Matan Cohen on 4/5/16.
//  Copyright © 2016 Matan Cohen. All rights reserved.
//

#import "JVTRecetImagesCollection.h"
#import "JVTRecentImagesCollectionViewCell.h"
#import "JVTTransitionOpenImageFullScreenDelegate.h"
#import "JVTOpenFullScreenTransitionDetailsVC.h"
#import "JVTRecentImagesVideoCollectionViewCell.h"
#import "UIImagePickerController+Block.h"
#import "EXTScope.h"
#import "JVTOpenFullScreenTransitioinCameraVC.h"
#import "JVTCustomCameraView.h"
#import "JVTTransitionOpenViewFullScreenDelegate.h"
#import "LLSimpleCamera.h"

@import GLKit;
static int cameraIndex = 0;
@interface JVTRecetImagesCollection () <UICollectionViewDelegate, UICollectionViewDataSource, JVTOpenFullScreenTransitionDetailsVCDelegate, JVTTransitionOpenImageFullScreenDismissCalles, AVCaptureVideoDataOutputSampleBufferDelegate, JVTTransitionOpenViewFullScreenDelegateDismissCalles>
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSArray<UIImage *> *imagesModel;

@property (nonatomic,strong) JVTTransitionOpenImageFullScreenDelegate *transitionImageOpenDelegate;
@property (nonatomic,strong) JVTTransitionOpenViewFullScreenDelegate *transitionViewOpenDelegate;

@property (nonatomic,strong) JVTOpenFullScreenTransitionDetailsVC *vc;
@property (nonatomic,strong) JVTOpenFullScreenTransitioinCameraVC *cameraVC;

@property (nonatomic,strong) JVTCustomCameraView *customCameraView;

@property (nonatomic,strong) LLSimpleCamera *camera;

@end

@implementation JVTRecetImagesCollection {
    CGFloat itemWidth;
    CGFloat itemHeight;
}

-(instancetype) initWithFrame:(CGRect)frame
          withImagesToDisplay:(NSArray<UIImage *>*) imagesToDisplay{
    self = [super initWithFrame:frame];
    if (self) {
        self.imagesModel = imagesToDisplay;
        [self configureItemSize];
        [self setupPresentationControllerAndTransitions];
        [self setupCollection];
        self.customCameraView = [[JVTCustomCameraView alloc] init];
        
        // create camera with standard settings
        self.camera = [[LLSimpleCamera alloc] init];
        
    }
    return self;
}

-(void) configureItemSize {
    CGFloat aspectRatio =   [UIScreen mainScreen].bounds.size.width / [UIScreen mainScreen].bounds.size.height;
    CGFloat height = CGRectGetHeight(self.frame);
    CGFloat width = height * aspectRatio;
    
    itemWidth = width;
    itemHeight = height;
    
}

-(void) setupCollection {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(itemWidth, itemHeight);
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.minimumLineSpacing = 5.0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)) collectionViewLayout:flowLayout];
    [self.collectionView registerClass:[JVTRecentImagesCollectionViewCell class] forCellWithReuseIdentifier:[JVTRecentImagesCollectionViewCell cellIdentifer]];
    [self.collectionView registerClass:[JVTRecentImagesVideoCollectionViewCell class] forCellWithReuseIdentifier:[JVTRecentImagesVideoCollectionViewCell cellIdentifer]];
    [self addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    
}

-(void) setupPresentationControllerAndTransitions {
    self.transitionImageOpenDelegate = [[JVTTransitionOpenImageFullScreenDelegate alloc] init];
    self.transitionImageOpenDelegate.delegate = self;
    self.transitionViewOpenDelegate = [[JVTTransitionOpenViewFullScreenDelegate alloc] init];
    self.transitionViewOpenDelegate.delegate = self;
    self.cameraVC = [[JVTOpenFullScreenTransitioinCameraVC alloc] init];
    self.cameraVC.transitioningDelegate = self.transitionViewOpenDelegate;
    self.cameraVC.modalPresentationStyle = UIModalPresentationCustom;
    [self.cameraVC view];
}

#pragma mark - CollectionView deleegate data source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imagesModel.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == cameraIndex) {
        JVTRecentImagesVideoCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:[JVTRecentImagesVideoCollectionViewCell cellIdentifer] forIndexPath:indexPath];
        
        
        self.camera.view.frame = CGRectMake(0, 0, itemWidth, itemHeight);
        self.camera.view.userInteractionEnabled = NO;
        [self.camera start];
        [cell setViewToPresent:self.camera.view];
        
        return cell;
    }
    JVTRecentImagesCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:[JVTRecentImagesCollectionViewCell cellIdentifer] forIndexPath:indexPath];
    [cell setImage:self.imagesModel[indexPath.row]];
    return cell;
}

-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.item == cameraIndex) {
          [self cameraCellPressed:collectionView indexPath:indexPath];
    } else {
        [self imageCellPressed:collectionView indexPath:indexPath];
    }
    
}

-(void) imageCellPressed:(UICollectionView *) collectionView indexPath:(NSIndexPath *) indexPath {
    UIViewController *presentingViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UICollectionViewLayoutAttributes *att = [collectionView layoutAttributesForItemAtIndexPath:indexPath];
    CGRect attFrame = att.frame;
    CGRect frameToOpenFrom = [collectionView convertRect:attFrame toView:presentingViewController.view];
    
    self.transitionImageOpenDelegate.openingFrame = frameToOpenFrom;
    
    self.vc = [[JVTOpenFullScreenTransitionDetailsVC alloc] init];
    self.vc.delegate = self;
    [self.vc setImage:self.imagesModel[indexPath.row]];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:self.vc];
    nav.transitioningDelegate = self.transitionImageOpenDelegate;
    nav.modalPresentationStyle = UIModalPresentationCustom;
    [presentingViewController presentViewController:nav animated:YES completion:nil];
}

-(void) cameraCellPressed:(UICollectionView *) collectionView indexPath:(NSIndexPath *) indexPath {
    UIViewController *presentingViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UICollectionViewLayoutAttributes *att = [collectionView layoutAttributesForItemAtIndexPath:indexPath];
    CGRect attFrame = att.frame;
    CGRect frameToOpenFrom = [collectionView convertRect:attFrame toView:presentingViewController.view];
    
    self.camera.view.frame = frameToOpenFrom;
    [presentingViewController.view addSubview:self.camera.view];
    
    self.transitionViewOpenDelegate.openingFrame = frameToOpenFrom;
    [self.transitionViewOpenDelegate setViewToPresentFrom:self.camera.view];
    [self.transitionViewOpenDelegate setViewToDissmissFrom:self.camera.view];
    [self.cameraVC setViewToPresent:self.camera.view];
    
    [presentingViewController presentViewController:self.cameraVC animated:YES completion:nil];
}

-(void) didPressSendOnImage:(UIImage *)image {
    [self.delegate didPressSendOnImage:image];
}

#pragma mark - JVTOpenFullScreenTransitionDelegateCalls delegate

-(void) didDissmiss {
    [self setupPresentationControllerAndTransitions];
    [self.collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:0 inSection:0]]];
}

@end
