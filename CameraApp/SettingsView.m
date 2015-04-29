//
//  SettingsView.m
//  CameraApp
//
//  Created by annutech on 2/11/15.
//  Copyright (c) 2015 annutech. All rights reserved.
//
@import GoogleMobileAds;

#import "SettingsView.h"
#import "GAI.h"
#import <Parse/Parse.h>
#import "GAIDictionaryBuilder.h"
#import "GAI.h"
#import "GAIFields.h"
#import "GAITracker.h"
#define MAX_LENGTH 150
//#define AP_APPKEY @"FDOJ3AJ2JSWQ43UZ"
#define AP_APPKEY @"YJSUK04G6D9KQSW4"

@interface SettingsView ()
@property (weak, nonatomic) IBOutlet UIButton *cameraButton;
@property (weak, nonatomic) IBOutlet UIButton *videoButton;
- (IBAction)appliAction:(id)sender;
- (IBAction)appliFullAction:(id)sender;

@end

@implementation SettingsView
@synthesize passCode,vibrateSettings,passCodeView,passcodeOff,sortSwitch,bannerView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    passCode.transform = CGAffineTransformMakeScale(0.75, 0.75);
    sortSwitch.transform = CGAffineTransformMakeScale(0.75, 0.75);
    vibrateSettings.transform = CGAffineTransformMakeScale(0.75, 0.75);
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"Settings View"];
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
    [tracker set:kGAIScreenName value:nil];

    
  
    NSLocale *currentLocale = [NSLocale currentLocale];  // get the current locale.
    NSString *countryCode = [currentLocale objectForKey:NSLocaleCountryCode];
    self.passcodeOff = FALSE;
    
    /*
    NSLog(@"Country name: %@", countryCode);
    
    if([countryCode isEqualToString:@"JP"])
        
    {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
        }
        else {
            
            
        }
        
        
        
        self.bannerAdsView.delegate = self;
        self.bannerAdsView.adUnitID=@"ca-app-pub-8337981281366372/7697065240";
        
        self.bannerAdsView.rootViewController = self;
        GADRequest *request = [GADRequest request];
        [self.bannerAdsView loadRequest:request];
       
        
        
    }
    
    else{
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
        }
        else {
            
            
        }
        
       
        
        self.bannerAdsView.adUnitID=@"ca-app-pub-8337981281366372/9173798446";
        self.bannerAdsView.rootViewController = self;
        GADRequest *request = [GADRequest request];
        [self.bannerAdsView loadRequest:request];
        
        
        
    }
    */
    
    
    
    if([countryCode isEqualToString:@"JP"])
    {
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            self.bannerView = [[GADBannerView alloc] initWithAdSize:GADAdSizeFullWidthPortraitWithHeight(100)];
        }
        else {
            
            self.bannerView = [[GADBannerView alloc] initWithAdSize:GADAdSizeFullWidthPortraitWithHeight(50)];
            
        }
        self.bannerView.adUnitID = @"ca-app-pub-8337981281366372/7697065240";
        
    }
    
    else
    {
        
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
           // self.bannerView = [[GADBannerView alloc] initWithAdSize:GADAdSizeFullWidthPortraitWithHeight(100)];
        }
        else {
            
            self.bannerView = [[GADBannerView alloc] initWithAdSize:GADAdSizeFullWidthPortraitWithHeight(50)];
            
        }
        self.bannerView.adUnitID = @"ca-app-pub-8337981281366372/9173798446";
        
    }
    
    self.bannerView.delegate = self;
    self.bannerView.rootViewController = self;
    GADRequest *request = [GADRequest request];
    [self.bannerView loadRequest:request];
    [self.globalAdview addSubview:self.bannerView];

    

    self.interstitial = [[GADInterstitial alloc] init];
    //self.interstitial.adUnitID = @"ca-app-pub-9874128266588393/6433190665";
    self.interstitial.adUnitID = @"ca-app-pub-8337981281366372/6220332042";
    self.interstitial.delegate = self;
    GADRequest *request1 = [GADRequest request];
    [self.interstitial loadRequest:request1];   
    
    
    NSUserDefaults *cameraButton = [NSUserDefaults standardUserDefaults];
    Boolean isdefaultCamera =    [cameraButton boolForKey:@"isdefaultCameraOn"];
    NSLog(@"isdefaultCamera%d",isdefaultCamera);
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated
{
        
    
    [super viewWillAppear:animated];
    BOOL isPassCode = [[NSUserDefaults standardUserDefaults] boolForKey:@"isPasscodeOn"];
    NSLog(@"%@",isPassCode?@"YES":@"NO");
    
    if(isPassCode) {
        
        [self.passCode setOn:FALSE animated:YES];
        
    }
    else {
    
        [self.passCode setOn:TRUE animated:YES];
    
    }
    
    
    
 
    
    BOOL darkCameVibrate = [[NSUserDefaults standardUserDefaults] boolForKey:@"isVibrateOn"];
    
    
    [self.vibrateSettings setOn:darkCameVibrate animated:YES];
   
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *getUrl =    [defaults objectForKey:@"startPage"];
    NSLog(@"start page url : %@", getUrl);
    
    if(getUrl==nil)
    {
        self.shadowCameraStartUrl.text = @"http://yahoo.co.jp";
        
    }
    else
    {
        
        self.shadowCameraStartUrl.text = getUrl;
        
    }
    
    
    
    NSUserDefaults *NewOLDSort = [NSUserDefaults standardUserDefaults];
    Boolean isascendng =    [NewOLDSort boolForKey:@"isAscending"];
    NSLog(@"isdefaultCamera%d",isascendng);
    if(isascendng==TRUE)
        
    {
       
        [self.sortSwitch setOn:TRUE animated:YES];


    }
    
    else
    {
      
        
        
        [self.sortSwitch setOn:FALSE animated:YES];
    }
    
    
    
    NSUserDefaults *cameraButton = [NSUserDefaults standardUserDefaults];
    Boolean isdefaultCamera =    [cameraButton boolForKey:@"isdefaultCameraOn"];
    NSLog(@"isdefaultCamera%d",isdefaultCamera);
    
    
    if(isdefaultCamera == TRUE)
        
    {
        
        
        [self.cameraButton setImage:[UIImage imageNamed:@"icon_camera_off.png"] forState:UIControlStateNormal];
        [self.videoButton setImage:[UIImage imageNamed:@"icon_video_on.png"] forState:UIControlStateNormal];
        
       
        
        
        self.videoButton.enabled = TRUE;
        
        
    }
    
    else
    {
        
        
        [self.cameraButton setImage:[UIImage imageNamed:@"icon_camera_on.png"] forState:UIControlStateNormal];
        [self.videoButton setImage:[UIImage imageNamed:@"icon_video_off.png"] forState:UIControlStateNormal];
        
       
        self.cameraButton.enabled = TRUE;
        
        
        
    }

    
}



- (IBAction)unwindToSettings:(UIStoryboardSegue *)segue
{
    NSLog(@"unwind called");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:FALSE forKey:@"isPasscodeOn"];
    [defaults synchronize];
    BOOL test= [[NSUserDefaults standardUserDefaults] boolForKey:@"isPasscodeOn"];
    NSLog(@"%@",test?@"YES":@"NO");
    
    [self.passCode setOn:test animated:YES];
    
}


- (IBAction)sortSwitchAction:(id)sender {
    
    if(self.sortSwitch.on)
    {
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:TRUE forKey:@"isAscending"];
        [defaults synchronize];
        
        
    }
    else
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:FALSE forKey:@"isAscending"];
        [defaults synchronize];
        
    }
    
    
}

- (IBAction)passcodeAction:(id)sender {
        NSLog(@"Switch current state %@", passCode.on ? @"On" : @"Off");
    
    if(passCode.on)
    {
        
        
       
        
        self.passcodeOff=TRUE;
        [self performSegueWithIdentifier:@"PasscodeSegue" sender:self];
        
    }
    else 
    {
        
        self.passcodeOff = FALSE;
        [self performSegueWithIdentifier:@"PasscodeSegue" sender:self];
        
       
    }
    
    
}
- (IBAction)vibrateSettingsAction:(id)sender {
    
    if(vibrateSettings.on)
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:TRUE forKey:@"isVibrateOn"];
        [defaults synchronize];
    }
    else
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:FALSE forKey:@"isVibrateOn"];
        [defaults synchronize];
    }
}

- (IBAction)CameraAction:(id)sender {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:FALSE forKey:@"isdefaultCameraOn"];
    [defaults synchronize];
    
    
    self.cameraButton.highlighted = TRUE;
    self.videoButton.highlighted = FALSE;
    self.cameraButton.selected = TRUE;
    self.videoButton.selected = FALSE;
    [self.cameraButton setImage:[UIImage imageNamed:@"icon_camera_on.png"] forState:UIControlStateNormal];
    [self.videoButton setImage:[UIImage imageNamed:@"icon_video_off.png"] forState:UIControlStateNormal];

    

}

- (IBAction)VideoAction:(id)sender {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:TRUE forKey:@"isdefaultCameraOn"];
    [defaults synchronize];
    self.cameraButton.highlighted = TRUE;
    self.videoButton.highlighted = FALSE;
    
    self.cameraButton.selected = FALSE;
    self.videoButton.selected = TRUE;
    
    [self.cameraButton setImage:[UIImage imageNamed:@"icon_camera_off.png"] forState:UIControlStateNormal];
    [self.videoButton setImage:[UIImage imageNamed:@"icon_video_on.png"] forState:UIControlStateNormal];

}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    
    if([[segue identifier ] isEqualToString:@"PasscodeSegue"])
    {
        
        PasscodeLockScreen *passcodeSet = [segue destinationViewController];
        passcodeSet.delegate = self;
        if(self.passcodeOff == TRUE)
        {
        
              
              passcodeSet.isCheckPassword = TRUE;
        }
        else
        {
            
            passcodeSet.isCheckPassword = FALSE;
            
        }
        
        
    }
    
        
}

-(void)SetPasscode:(NSString *)result
{


    
    if(self.passcodeOff == TRUE)
        
    {
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:FALSE forKey:@"isPasscodeOn"];
        [defaults synchronize];
        
       
    }
    
    else
    {
    
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:TRUE forKey:@"isPasscodeOn"];
        [defaults synchronize];
        [defaults setObject: result forKey:@"Passcode_key"];
        [defaults synchronize];
        

    }
    
    
    BOOL isPassCode = [[NSUserDefaults standardUserDefaults] boolForKey:@"isPasscodeOn"];
    NSLog(@"%@",isPassCode?@"YES":@"NO");
    
    if(isPassCode) {
        
        [self.passCode setOn:FALSE animated:YES];
        
    }
    else {
        
        [self.passCode setOn:TRUE animated:YES];
        
    }

    


}

-(void)passwordSet:(NSString *)result
{

    NSLog(@"hello");
    
    
    
    if([result isEqualToString:@"NO"]) {
    
        [self.passCode setOn:FALSE animated:YES];
    
    }

    

}


- (IBAction)unwindSettingsView:(UIStoryboardSegue *)segue
{
    // [self performSegueWithIdentifier:@"unwindTopView" sender:self];
    
}



- (IBAction)StartPageAction:(id)sender {
    [self performSegueWithIdentifier:@"StartPageSegue" sender:self];
    
}
- (IBAction)NxtbuttonAction:(id)sender {
    [self performSegueWithIdentifier:@"StartPageSegue" sender:self];
}
- (IBAction)appliAction:(id)sender {

    NSLocale *currentLocale = [NSLocale currentLocale];  // get the current locale.
    NSString *countryCode = [currentLocale objectForKey:NSLocaleCountryCode];
    
    NSLog(@"Country name: %@", countryCode);
    
    
    if([countryCode isEqualToString:@"JP"]) {
    
    [AMoAdSDK showAppliPromotionWall:self
                         orientation:UIInterfaceOrientationPortrait
                     wallDrawSetting:APSDK_Ad_Key_WallDrawSetting_hiddenStatusBar
                              appKey:AP_APPKEY
                    onWallCloseBlock:^{
                        
                       
                        //[[Toast makeText:nil text:@"ウォールが閉じた" duration:TOAST_LENGTH_SHORT] show];
                    }];
    [ AMoAdSDK sendUUID ] ;
        
        
        
    }
    else {
    
    
    
        if (self.interstitial.isReady) {
            
            [self.interstitial presentFromRootViewController:self];
            
        } else {
            
                        
        }

        
        
    
    }
    
    
    
    

}

- (IBAction)appliFullAction:(id)sender {
    
    NSLocale *currentLocale = [NSLocale currentLocale];  // get the current locale.
    NSString *countryCode = [currentLocale objectForKey:NSLocaleCountryCode];
    
    NSLog(@"Country name: %@", countryCode);
    
    
    if([countryCode isEqualToString:@"JP"]) {
        
        [AMoAdSDK showAppliPromotionWall:self
                             orientation:UIInterfaceOrientationPortrait
                         wallDrawSetting:APSDK_Ad_Key_WallDrawSetting_hiddenStatusBar
                                  appKey:AP_APPKEY
                        onWallCloseBlock:^{
                            
                            
                            //[[Toast makeText:nil text:@"ウォールが閉じた" duration:TOAST_LENGTH_SHORT] show];
                        }];
        [ AMoAdSDK sendUUID ] ;
        
        
        
    }
    else {
        
        
        
        if (self.interstitial.isReady) {
            
            [self.interstitial presentFromRootViewController:self];
            
        } else {
            
            
        }
        
        
        
        
    }

    
    
    
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
@end
