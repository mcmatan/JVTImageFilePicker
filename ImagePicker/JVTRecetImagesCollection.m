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
#import "JVTCameraAccesebility.h"

@import GLKit;
static int cameraIndex = 0;
@interface JVTRecetImagesCollection () <UICollectionViewDelegate, UICollectionViewDataSource, JVTOpenFullScreenTransitionDetailsVCDelegate, JVTTransitionOpenImageFullScreenDismissCalles, AVCaptureVideoDataOutputSampleBufferDelegate, JVTTransitionOpenViewFullScreenDelegateDismissCalles, JVTOpenFullScreenTransitioinCameraVCDelegate>
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSArray<UIImage *> *imagesModel;

@property (nonatomic,strong) JVTTransitionOpenImageFullScreenDelegate *transitionImageOpenDelegate;
@property (nonatomic,strong) JVTTransitionOpenViewFullScreenDelegate *transitionViewOpenDelegate;

@property (nonatomic,strong) JVTOpenFullScreenTransitionDetailsVC *imageDisplayVC;
@property (nonatomic,strong) JVTOpenFullScreenTransitioinCameraVC *cameraInstantTakeDisplay;

@property (nonatomic,strong) JVTCustomCameraView *customCameraView;

@property (nonatomic,strong) LLSimpleCamera *camera;
@property (nonatomic, assign) BOOL cameraAccesible;

@end

@implementation JVTRecetImagesCollection {
    CGFloat itemWidth;
    CGFloat itemHeight;
    CGFloat cellPadding;
}

-(instancetype) initWithFrame:(CGRect)frame
          withImagesToDisplay:(NSArray<UIImage *>*) imagesToDisplay{
    self = [super initWithFrame:frame];
    if (self) {
        self.cameraAccesible = NO;
        self.imagesModel = imagesToDisplay;
        [self configureItemSize];
        [self setupPresentationControllerAndTransitions];
        [self setupCollection];
        [self checkForCameraAccesbiliyAnsAskIfNeeded];
        
    }
    return self;
}

-(void) checkForCameraAccesbiliyAnsAskIfNeeded {
    @weakify(self);
    [JVTCameraAccesebility getCameraAccessibilityAndRequestIfNeeded:^(BOOL allowedToUseCamera) {
        @strongify(self);
        self.cameraAccesible = allowedToUseCamera;
        if (allowedToUseCamera) {
            [self cameraStateAccessible];
            [self.collectionView reloadData];
        }
    }];
}

-(void) cameraStateAccessible {
    self.customCameraView = [[JVTCustomCameraView alloc] init];
    // create camera with standard settings
    self.camera = [[LLSimpleCamera alloc] init];
}

-(void) configureItemSize {
    cellPadding = 5;
    CGFloat aspectRatio =   [UIScreen mainScreen].bounds.size.width / [UIScreen mainScreen].bounds.size.height;
    CGFloat height = CGRectGetHeight(self.frame)  - (cellPadding * 2);
    CGFloat width = height * aspectRatio;
    
    itemWidth = width;
    itemHeight = height;
    
}

-(void) setupCollection {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(itemWidth, itemHeight);
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.minimumLineSpacing = cellPadding;
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
}

#pragma mark - CollectionView deleegate data source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imagesModel.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == cameraIndex && self.cameraAccesible) {
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
    
    if (indexPath.item == cameraIndex && self.cameraAccesible) {
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
    
    self.imageDisplayVC = [[JVTOpenFullScreenTransitionDetailsVC alloc] init];
    self.imageDisplayVC.delegate = self;
    [self.imageDisplayVC setImage:self.imagesModel[indexPath.row]];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:self.imageDisplayVC];
    nav.transitioningDelegate = self.transitionImageOpenDelegate;
    nav.modalPresentationStyle = UIModalPresentationCustom;
    [presentingViewController presentViewController:nav animated:YES completion:nil];
}

-(void) cameraCellPressed:(UICollectionView *) collectionView indexPath:(NSIndexPath *) indexPath {
    UIViewController *presentingViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UICollectionViewLayoutAttributes *att = [collectionView layoutAttributesForItemAtIndexPath:indexPath];
    CGRect attFrame = att.frame;
    CGRect frameToOpenFrom = [collectionView convertRect:attFrame toView:presentingViewController.view];
    
    self.cameraInstantTakeDisplay = [[JVTOpenFullScreenTransitioinCameraVC alloc] init];
    self.cameraInstantTakeDisplay.delegate = self;
    self.cameraInstantTakeDisplay.transitioningDelegate = self.transitionViewOpenDelegate;
    self.cameraInstantTakeDisplay.modalPresentationStyle = UIModalPresentationCustom;
    [self.cameraInstantTakeDisplay view];
    
    self.camera.view.frame = frameToOpenFrom;
    [presentingViewController.view addSubview:self.camera.view];
    
    self.transitionViewOpenDelegate.openingFrame = frameToOpenFrom;
    [self.transitionViewOpenDelegate setViewToPresentFrom:self.camera.view];
    [self.transitionViewOpenDelegate setViewToDissmissFrom:self.camera.view];
    [self.cameraInstantTakeDisplay setViewToPresent:self.camera.view];
    
    [presentingViewController presentViewController:self.cameraInstantTakeDisplay animated:YES completion:nil];
}

-(void) didPressSendOnImage:(UIImage *)image {
    [self.delegate didPressSendOnImage:image];
}

#pragma mark - JVTOpenFullScreenTransitionDelegateCalls delegate

-(void) didDissmiss {
    [self setupPresentationControllerAndTransitions];
    [self.collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:0 inSection:0]]];
}

#pragma mark - JVTOpenFullScreenTransitioinCameraVCDelegate

-(void) didPressTakeImage {
        __weak typeof(self) weakSelf = self;
    
            [self.camera capture:^(LLSimpleCamera *camera, UIImage *image, NSDictionary *metadata, NSError *error) {
                if(!error) {
                    
                    [weakSelf.delegate didPressSendOnImage:image];
                }
                else {
                    NSLog(@"An error has occured: %@", error);
                }
            } exactSeenImage:YES];
    
}
@end
