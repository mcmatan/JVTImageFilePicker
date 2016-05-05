//
//  FilesPicker.m
//  ImagePickerMC
//
//  Created by Matan Cohen on 1/13/16.
//  Copyright © 2016 Matan Cohen. All rights reserved.
//

#import "JVTImageFilePicker.h"
#import "UIImagePickerController+Block.h"
#import "JVTWorker.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "JVTRecentImagesProvider.h"
#import "JVTRecetImagesCollection.h"
#import "EXTScope.h"
#import <AVFoundation/AVFoundation.h>
#import "JVTActionSheetAction.h"
#import "JVTActionSheetView.h"
#import "EXTScope.h"
#import "JVTCameraAccesebility.h"

@interface JVTImageFilePicker () <JVTRecetImagesCollectionDelegate>
@property(nonatomic, strong) JVTActionSheetView *actionSheet;
@property(nonatomic, weak) UIViewController *presentedFromController;
@property (nonatomic,strong) JVTRecetImagesCollection *recetImagesCollection;
@end

@implementation JVTImageFilePicker


- (void)presentFilesPickerOnController:(UIViewController *)presentFromController
  withAddingCustomActionsToActionSheet:(NSArray *) customAlertActions {
    
    self.presentedFromController = presentFromController;
    [self.presentedFromController.view endEditing:YES];
    
    NSString *photoLibraryTxt = @"Photo Library";
    NSString *takePhotoOrVideoTxt = @"Take Photo";
    NSString *uploadFileTxt = @"Upload File";
    NSString *cancelTxt = @"Cancel";
    self.actionSheet = [[JVTActionSheetView alloc] init];
    
    @weakify(self);
    JVTActionSheetAction *photoLibrary = [JVTActionSheetAction actionWithTitle:photoLibraryTxt actionType:kActionType_default handler:^(JVTActionSheetAction *action) {
        @strongify(self);
        [self photoLibraryPress];
    }];
    JVTActionSheetAction *takePhotoOrVideo = [JVTActionSheetAction actionWithTitle:takePhotoOrVideoTxt actionType:kActionType_default handler:^(JVTActionSheetAction *action) {
        @strongify(self);
        [self takePhotoOrVideoPress];
    }];
    JVTActionSheetAction *uploadFile = [JVTActionSheetAction actionWithTitle:uploadFileTxt actionType:kActionType_default handler:^(JVTActionSheetAction *action) {
        @strongify(self);
        [self uploadFilePress];
    }];
    JVTActionSheetAction *cancel = [JVTActionSheetAction actionWithTitle:cancelTxt actionType:kActionType_cancel handler:^(JVTActionSheetAction *action) {
        @strongify(self);
            [self dismissPresentedControllerAndInformDelegate:nil];
    }];
    
    [self.actionSheet addAction:photoLibrary];
    [self.actionSheet addAction:takePhotoOrVideo];
    [self.actionSheet addAction:uploadFile];
    [self.actionSheet addAction:cancel];
    
    if (customAlertActions) {
        for (JVTActionSheetAction *alertAction in customAlertActions) {
            [self.actionSheet addAction:alertAction];
        }
    }
    
    
    [self addCollectionImagesPreviewToSheetAndPresent:self.actionSheet];
    
}

-(void) addCollectionImagesPreviewToSheetAndPresent:(JVTActionSheetView *) alertController {
    
    @weakify(self);
    [JVTRecentImagesProvider getRecentImages:^(NSArray<UIImage *> *images) {
        @strongify(self);
        
        if (images.count > 0) {
            CGFloat width = self.presentedFromController.view.bounds.size.width;
            CGRect frame = CGRectMake(0, 0, width, 163.0F);
            self.recetImagesCollection = [[JVTRecetImagesCollection alloc] initWithFrame:frame withImagesToDisplay:images];
            self.recetImagesCollection.delegate = self;
            [alertController addHeaderView:self.recetImagesCollection];
        }
        
        [self.actionSheet presentOnTopOfView:self.presentedFromController.view];
    }];
}

- (void)presentFilesPickerOnController:(UIViewController *)presentFromController {
    [self presentFilesPickerOnController:presentFromController withAddingCustomActionsToActionSheet:nil];
}

#pragma mark - type of action presses

- (void)photoLibraryPress {
    @weakify(self);
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    [self.presentedFromController presentViewController:imagePickerController animated:YES completion:nil];

    imagePickerController.finalizationBlock = ^(UIImagePickerController *picker, NSDictionary *info) {
        @strongify(self);
        UIImage *image = (UIImage *) [info valueForKey:UIImagePickerControllerOriginalImage];

        [self showPreviewForImage:image];
    };
    imagePickerController.cancellationBlock = ^(UIImagePickerController *picker) {
        @strongify(self);
        [picker dismissViewControllerAnimated:YES completion:^{
            [self.actionSheet show];
        }];
    };
}

- (void)takePhotoOrVideoPress {
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(authStatus == AVAuthorizationStatusAuthorized || authStatus == AVAuthorizationStatusNotDetermined) {
        
        @weakify(self);
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
        imagePickerController.allowsEditing = NO;
        [self.presentedFromController presentViewController:imagePickerController animated:YES completion:nil];
        
        imagePickerController.finalizationBlock = ^(UIImagePickerController *picker, NSDictionary *info) {
            @strongify(self);
            UIImage *image = (UIImage *) [info valueForKey:UIImagePickerControllerOriginalImage];

            [self didPressSendOnImage:image];
            
        };
        imagePickerController.cancellationBlock = ^(UIImagePickerController *picker) {
            @strongify(self);
            [picker dismissViewControllerAnimated:YES completion:^{
                [self.actionSheet show];
            }];
        };
        
    } else if(authStatus == AVAuthorizationStatusDenied){
        [self presentPermissionDenied];
    } else if(authStatus == AVAuthorizationStatusRestricted){
        // restricted, normally won't happen
        [self presentPermissionDenied];
    }
}

- (void)uploadFilePress {
    UIDocumentMenuViewController *documentMenuViewController = [[UIDocumentMenuViewController alloc] initWithDocumentTypes:@[(__bridge NSString *) kUTTypeItem] inMode:UIDocumentPickerModeImport];
    documentMenuViewController.delegate = self;

    [self.presentedFromController presentViewController:documentMenuViewController animated:YES completion:nil];
}

#pragma mark - documents picker

- (void)documentMenu:(UIDocumentMenuViewController *)documentMenu didPickDocumentPicker:(UIDocumentPickerViewController *)documentPicker {
    documentPicker.delegate = self;
    [self.presentedFromController presentViewController:documentPicker animated:YES completion:^{
        NSLog(@"Document menu dismissed");
    }];
}

- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentAtURL:(NSURL *)url {

    @weakify(self);
    [[JVTWorker shared] addOperationWithBlock:^{
        @strongify(self);

        NSLog(@"Document picker picked %@", url);
        NSData *file = [self fileFromFileURL:url];
        NSString *fileName = [url lastPathComponent];

        dispatch_async(dispatch_get_main_queue(), ^{
        @strongify(self);
            
            if ([self isFileOfTypeImage:[url absoluteString]]) {
                
                    UIImage *image = [UIImage imageWithData: file];
                    if (!image) {
                        [self presentFileNotSupportedAlert];
                    } else {
                        [self.delegate didPickImage:image withImageName:fileName];
                    }
                
            } else {
                [self.delegate didPickFile:file fileName:fileName];
            }
            
        });

    }];
}

-(BOOL) isFileOfTypeImage: (NSString *) filePath {
    NSString *file = filePath;
    CFStringRef fileExtension = (__bridge CFStringRef) [file pathExtension];
    CFStringRef fileUTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, fileExtension, NULL);
    
    if (UTTypeConformsTo(fileUTI, kUTTypeImage)) {
        CFRelease(fileUTI);
        return YES;
    } else {
        CFRelease(fileUTI);
        return NO;
    }
}

-(NSData *) fileFromFileURL: (NSURL *) fileURL{
    NSString *stringURL = [fileURL absoluteString];
    NSURL  *url = [NSURL URLWithString:stringURL];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    if ( urlData )
    {
        NSArray       *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString  *documentsDirectory = [paths objectAtIndex:0];
        
        NSString *fileName = [NSString stringWithFormat:@"filename%@", [fileURL lastPathComponent]];
        NSString  *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,fileName];
        [urlData writeToFile:filePath atomically:YES];
    }
    
    return urlData;
}

#pragma mark - delegate updates

- (void)dismissPresentedControllerAndInformDelegate:(UIViewController *) presentedController {
    [presentedController dismissViewControllerAnimated:YES completion:^(void) {
        [self updateDelegateOnDissmiss];
    }];
}

- (void)updateDelegateOnDissmiss {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didDismissFilesPicker)]) {
        [self.delegate didDismissFilesPicker];
    }
}

#pragma mark - Alerts

-(void) presentFileNotSupportedAlert {
    @weakify(self);
    
    NSString *title = @"Unable to Upload";
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okBtn = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {}];
    [alert addAction:okBtn];
    [self.presentedFromController presentViewController:alert animated:YES completion:^{
@strongify(self);
        [self updateDelegateOnDissmiss];
    }];
}

-(void) presentPermissionDenied {
    @weakify(self);
    NSString *title = @"Permission Denied";
    NSString *subtitle = @"App isn't allowed to access to the camera. You can change this from Settings > Privacy > Camera";
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:subtitle preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okBtn = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {}];
    [alert addAction:okBtn];
    [self.presentedFromController presentViewController:alert animated:YES completion:^{
@strongify(self);
        [self updateDelegateOnDissmiss];
    }];
}

#pragma mark - CollectionView picker delegat

-(void)didChooseImagesFromCollection:(UIImage *)image {
    [self.actionSheet dismiss];
    [self.delegate didPickImage:image withImageName:@"asset"];
}

#pragma mark - ImagePreview delegate

-(void) didPressSendOnImage:(UIImage *) image {
    [self.presentedFromController dismissViewControllerAnimated:YES completion:nil];
    [self.delegate didPickImage:image withImageName:@"asset"];
}

#pragma mark - image preview

-(void) showPreviewForImage:(UIImage *) image {
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    if (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    JVTImagePreviewVC *imagePreviewViewController = [[JVTImagePreviewVC alloc] initWithImage:image];
    imagePreviewViewController.delegate = self;
    if (topController.navigationController) {
        [topController.navigationController pushViewController:imagePreviewViewController animated:YES];
    } else {
        [topController presentViewController:imagePreviewViewController animated:YES completion:nil];
    }
}


@end
