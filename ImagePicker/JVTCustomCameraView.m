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



@end
