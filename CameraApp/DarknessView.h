//
//  DarknessView.h
//  CameraApp
//
//  Created by annutech on 2/11/15.
//  Copyright (c) 2015 annutech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AudioToolbox/AudioToolbox.h>
#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import "GAITrackedViewController.h"
#import "NADView.h"
#import <AVFoundation/AVFoundation.h>
@interface DarknessView : GAITrackedViewController <GADInterstitialDelegate>
{
    BOOL FrontCamera;
    BOOL haveImage;
    UIView *darkView;
    
    BOOL isShown;
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

@property(nonatomic, retain) UIView *darkView;
@property(nonatomic, strong) GADInterstitial *interstitial;
@property (nonatomic, retain) GADBannerView * bannerView;


@end
