//
//  NoSoundView.h
//  CameraApp
//
//  Created by annutech on 2/11/15.
//  Copyright (c) 2015 annutech. All rights reserved.
//

#import <UIKit/UIKit.h>
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

@class GADBannerView;
@interface NoSoundView : GAITrackedViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIImagePickerControllerDelegate,GADInterstitialDelegate,NADViewDelegate,GADBannerViewDelegate>

{
    BOOL FrontCamera;
    BOOL haveImage;
    AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;
    AVCaptureSession *CaptureSession;
    AVCaptureMovieFileOutput *MovieFileOutput;
    AVCaptureDeviceInput *VideoInputDevice;
     BOOL WeAreRecording;
    BOOL cameraMode;
      SystemSoundID soundID ;
        AVAudioPlayer *volumeOverridePlayer;
    
    
    BOOL isRequireTakePhoto;
    BOOL isProcessingTakePhoto;
    void *bitmap;
    
    AVCaptureSession *captureImageSession;
     GADBannerView * bannerView;

    
}
@property (weak, nonatomic) IBOutlet UIButton *cameraButton;
@property (weak, nonatomic) IBOutlet UIButton *videoButton;
- (IBAction)videoAction:(id)sender;
@property(nonatomic, strong) NSArray *assets;
@property(nonatomic, retain) AVCaptureStillImageOutput *stillImageOutput;
@property (weak, nonatomic) IBOutlet UIButton *shootingImage;

@property (weak, nonatomic) IBOutlet UIView *imagePreview;
- (IBAction)CameraAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *captureImage;
@property (nonatomic, strong) UISlider *volumeSlider;
@property (weak, nonatomic) IBOutlet GADBannerView *globalAdview;
@property (weak, nonatomic) IBOutlet UIImageView *shootingBaseImage;
@property (nonatomic, retain) GADBannerView * bannerView;


@end
