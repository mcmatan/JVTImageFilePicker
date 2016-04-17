//
//  JVTCustomCamera.m
//  ImagePicker
//
//  Created by Matan Cohen on 4/14/16.
//  Copyright © 2016 Matan Cohen. All rights reserved.
//

#import "JVTCustomCameraView.h"


@interface JVTCustomCameraView ()
@property (nonatomic,strong) AVCaptureStillImageOutput *stillImageOutput;
@property (nonatomic,strong) UIView *viewPresentingOn;
@property (nonatomic,strong) AVCaptureVideoPreviewLayer *previewLayer;
@end

@implementation JVTCustomCameraView

-(instancetype) init {
    self = [super init];
    if (self) {
        self.viewPresentingOn = [UIView new];
        [self startCamera];
    }
    return self;
}


-(instancetype) initWithViewToPresentOn:(UIView *) viewToPresentOn {
    self = [super init];
    if (self) {
        self.viewPresentingOn = viewToPresentOn;
        [self startCamera];
    }
    return self;
}

-(void) takeImage:(void(^)(UIImage *image)) callback {
    AVCaptureConnection *videoConnection = nil;
    for (AVCaptureConnection *connection in self.stillImageOutput.connections) {
        for (AVCaptureInputPort *port in [connection inputPorts]) {
            if ([[port mediaType] isEqual:AVMediaTypeVideo] ) {
                videoConnection = connection;
                break;
            }
        }
        if (videoConnection) { break; }
    }
}


-(void) startCamera {
    AVCaptureSession *session = [[AVCaptureSession alloc] init];
    session.sessionPreset = AVCaptureSessionPresetPhoto;
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    [session addInput:input];
    self.stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys: AVVideoCodecJPEG, AVVideoCodecKey, nil];
    [self.stillImageOutput setOutputSettings:outputSettings];
    
    [session addOutput:self.stillImageOutput];
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
    self.previewLayer.frame = self.viewPresentingOn.frame;
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.viewPresentingOn.layer addSublayer:self.previewLayer];
    [session startRunning];
}

-(void) setViewToPresentOn:(UIView *) view {
    self.previewLayer.frame = view.frame;
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [view.layer addSublayer:self.previewLayer];
}


//-(void) showImagePicker {
//    @weakify(self);
//    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
//    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
//    imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
//    [self.presentedFromController presentViewController:imagePickerController animated:YES completion:nil];
//    
//    imagePickerController.finalizationBlock = ^(UIImagePickerController *picker, NSDictionary *info) {
//        @strongify(self);
//        UIImage *image = (UIImage *) [info valueForKey:UIImagePickerControllerOriginalImage];
//        NSURL *imagePath = [info objectForKey:UIImagePickerControllerReferenceURL];
//        NSString *imageName = [imagePath lastPathComponent];
//        
//        JVTImagePreviewController *imagePreviewViewController = [[JVTImagePreviewController alloc] initWithImage:image imageName:imageName];
//        imagePreviewViewController.delegate = self;
//        [picker pushViewController:imagePreviewViewController animated:YES];
//        
//    };
//    imagePickerController.cancellationBlock = ^(UIImagePickerController *picker) {
//        @strongify(self);
//        [self dismissPresentedControllerAndInformDelegate:picker];
//    };
//
//}




//-(void) addCamera {
//
//    AVAuthorizationStatus authorizationState = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
//    switch (authorizationState) {
//        case AVAuthorizationStatusNotDetermined: {
//            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
//                if (granted) {
//                    [self havePermissionsToShowCamera];
//                } else {
//                    [self permissionDenied];
//                }
//            }];
//        }
//            break;
//        case AVAuthorizationStatusDenied:
//            [self permissionDenied];
//            break;
//        case AVAuthorizationStatusAuthorized:
//            [self havePermissionsToShowCamera];
//            break;
//        default:
//            break;
//    }
//    
//    
//}
//
//-(void) permissionDenied {
//    NSLog(@"Camera permissions denied");
//}
//
//-(void) havePermissionsToShowCamera {
//    //Find devices
//    AVCaptureDevice *backCameraDevice;
//    AVCaptureDevice *frontCameraDevice;
//    self.cameraSession = [[AVCaptureSession alloc] init];
//    NSArray *availableCameraDevices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
//    for (AVCaptureDevice *device in availableCameraDevices) {
//        if (device.position == AVCaptureDevicePositionBack) {
//            backCameraDevice = device;
//        } else if (device.position == AVCaptureDevicePositionFront) {
//            frontCameraDevice = device;
//        }
//    }
//    
//    NSError *error;
//    self.possibleCameraInput = [AVCaptureDeviceInput deviceInputWithDevice:backCameraDevice error:&error];
//    if ([self.cameraSession canAddInput:self.possibleCameraInput]) {
//        [self.cameraSession addInput:self.possibleCameraInput];
//    }
//    
//    //   [self.cameraSession startRunning];
//    
//    
//    self.stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
//    NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys: AVVideoCodecJPEG, AVVideoCodecKey, nil];
//    [self.stillImageOutput setOutputSettings:outputSettings];
//    
//    [self.cameraSession addOutput:self.stillImageOutput];
//    AVCaptureVideoPreviewLayer *previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.cameraSession];
//    previewLayer.frame = self.frame;
//    previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
//    [self.layer addSublayer:previewLayer];
//    [self.cameraSession startRunning];
//    
//}


@end
