//
//  ViewController.h
//  CameraApp
//
//  Created by annutech on 2/10/15.
//  Copyright (c) 2015 annutech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import "CheckPassword.h"
#import "GAITrackedViewController.h"
#import "NADView.h"
#import "ImobileSdkAds/ImobileSdkAds.h"
#import "AMoAdSDK.h"
#import "PasscodeLockScreen.h"

@class GADBannerView;
@interface ViewController : GAITrackedViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIImagePickerControllerDelegate,PasswordDelegate,GADInterstitialDelegate,NADViewDelegate,IMobileSdkAdsDelegate,PassCodeDelegate,GADBannerViewDelegate>
{
    BOOL FrontCamera;
    BOOL haveImage;
    NSString *passwordCheckSegue;
    GADBannerView *bannerView;
    
}

@property(nonatomic, retain) AVCaptureStillImageOutput *stillImageOutput;
@property(nonatomic, strong) GADInterstitial *interstitial;
@property (nonatomic, retain) NADView *nadView;
@property (weak, nonatomic) IBOutlet UIView *globalAdview;
@property (nonatomic, retain) GADBannerView *bannerView;

@end

