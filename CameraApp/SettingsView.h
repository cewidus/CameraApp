//
//  SettingsView.h
//  CameraApp
//
//  Created by annutech on 2/11/15.
//  Copyright (c) 2015 annutech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PassCodeView.h"
#import "NADView.h"
#import "AMoAdSDK.h"
#import "PasscodeLockScreen.h"

@class GADBannerView;
@interface SettingsView : UIViewController<PasswordSetDelegate,NADViewDelegate, GADInterstitialDelegate, PassCodeDelegate,GADBannerViewDelegate>{

    PassCodeView *passCodeView ;
    BOOL passcodeOff;
    GADBannerView * bannerView;

}
@property BOOL passcodeOff;
@property (weak, nonatomic) IBOutlet UISwitch *passCode;
@property (weak, nonatomic) IBOutlet UISwitch *sortSwitch;
- (IBAction)sortSwitchAction:(id)sender;
- (IBAction)passcodeAction:(id)sender;
@property (weak, nonatomic) IBOutlet UISwitch *vibrateSettings;
- (IBAction)vibrateSettingsAction:(id)sender;
- (IBAction)CameraAction:(id)sender;
- (IBAction)VideoAction:(id)sender;
@property (nonatomic,retain)PassCodeView *passCodeView ;
@property (weak, nonatomic) IBOutlet UIButton *startPagebutton;
- (IBAction)StartPageAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *NextButton;
- (IBAction)NxtbuttonAction:(id)sender;
@property(nonatomic, strong) GADInterstitial *interstitial;
@property (weak, nonatomic) IBOutlet GADBannerView *bannerAdsView;
@property (weak, nonatomic) IBOutlet UILabel *shadowCameraStartUrl;
@property (nonatomic, retain) GADBannerView * bannerView;

@property (weak, nonatomic) IBOutlet UIView *globalAdview;


@end
