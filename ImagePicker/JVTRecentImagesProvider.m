//
//  JVTRecentImagesProvider.m
//  ImagePicker
//
//  Created by Matan Cohen on 4/5/16.
//  Copyright © 2016 Matan Cohen. All rights reserved.
//

#import "JVTRecentImagesProvider.h"
@import Photos;
@import AssetsLibrary;

static NSInteger maxResults = 15;

@implementation JVTRecentImagesProvider

+(void) getRecentImages:(void(^)(NSArray<UIImage *> *images)) callback {
    
    PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    [smartAlbums enumerateObjectsUsingBlock:^(PHAssetCollection *collection, NSUInteger idx, BOOL *stop) {

    }];
    
    
    PHFetchOptions *fetchOptions = [PHFetchOptions new];
    fetchOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    PHFetchResult *allPhotosResult = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:fetchOptions];
    
    if (allPhotosResult.count == 0) {
        callback(nil);
        return;
    }
    
    __block NSMutableArray *allImages = [NSMutableArray array];
    
    //   Get assets from the PHFetchResult object
    [allPhotosResult enumerateObjectsUsingBlock:^(PHAsset *asset, NSUInteger idx, BOOL *stop) {
        CGSize size=CGSizeMake(200, 200);
        PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
        options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat; //I only want the highest possible quality
        options.synchronous = YES;
        options.networkAccessAllowed = YES;
        options.progressHandler = ^(double progress, NSError *error, BOOL *stop, NSDictionary *info) {
            NSLog(@"%f", progress); //follow progress + update progress bar
        };
        
        __block PHImageRequestID reqId =[[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeAspectFill options:options resultHandler:^(UIImage *image, NSDictionary *info) {
          
            [allImages addObject:image];
            
            if (allImages.count == allPhotosResult.count || allImages.count >= maxResults) {
                *stop = YES;
                [[PHImageManager defaultManager] cancelImageRequest:reqId];
                callback(allImages);
            }
        }];
    }];

}

@end
