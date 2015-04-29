//
//  AlbumView.h
//  CameraApp
//
//  Created by annutech on 2/11/15.
//  Copyright (c) 2015 annutech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h> 
#import <CoreMedia/CoreMedia.h>
#import "AlbumFullView.h"
#import "VideoPlayer.h"
#import "NADView.h"
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

@interface AlbumView : GAITrackedViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIAlertViewDelegate,GADInterstitialDelegate,NADViewDelegate,GADBannerViewDelegate>

{
    NSString *FilePath;
    NSString *Extension;
    NSString*fextpath;
   GADBannerView * bannerView;

}
@property(nonatomic, strong) NSArray *assets;
@property(nonatomic, strong) ALAsset *asset;
@property(nonatomic, strong) GADInterstitial *interstitial;
@property (weak, nonatomic) IBOutlet GADBannerView *globalAdview;
@property (nonatomic, retain) GADBannerView * bannerView;

@end
