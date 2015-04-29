//
//  ShadowViewController.h
//  CameraApp
//
//  Created by Admin on 1/22/15.
//  Copyright (c) 2015 CWD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "GAITrackedViewController.h"
#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import "NADView.h"
@class GADBannerView;


@interface ShadowViewController : GAITrackedViewController<UITextFieldDelegate, UIWebViewDelegate,NADViewDelegate, GADInterstitialDelegate,GADBannerViewDelegate>


{
    
        SystemSoundID SoundID;
        BOOL FrontCamera;
        BOOL haveImage;
    AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;
    AVCaptureSession *CaptureSession;
    AVCaptureMovieFileOutput *MovieFileOutput;
    AVCaptureDeviceInput *VideoInputDevice;
    BOOL WeAreRecording;
    BOOL cameraMode;
    
    
    BOOL isRequireTakePhoto;
    BOOL isProcessingTakePhoto;
    void *bitmap;
    AVCaptureSession *captureImageSession;
    GADBannerView * bannerView;



}
@property(nonatomic, retain) AVCaptureStillImageOutput *stillImageOutput;
@property (weak, nonatomic) IBOutlet UIView *imagePreview;
@property (weak, nonatomic) IBOutlet UIImageView *captureImage;
@property (weak, nonatomic) IBOutlet GADBannerView *globalAdview;
@property (nonatomic, retain) GADBannerView * bannerView;


@end
