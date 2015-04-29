//
//  ViewController.m
//  CameraApp
//
//  Created by annutech on 2/10/15.
//  Copyright (c) 2015 annutech. All rights reserved.
//
@import GoogleMobileAds;
#import "ViewController.h"
#import "GAI.h"
#import <Parse/Parse.h>
#import "GAIDictionaryBuilder.h"
#import "GAI.h"
#import "GAIFields.h"
#import "GAITracker.h"
#define AP_APPKEY               @"FDOJ3AJ2JSWQ43UZ"
@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *shadowCamera;
@property (weak, nonatomic) IBOutlet UIButton *darknessCamera;
@property (weak, nonatomic) IBOutlet UIButton *noSoundCamera;
- (IBAction)ShadowAction:(id)sender;
- (IBAction)DarknessAction:(id)sender;
- (IBAction)NoSoundAction:(id)sender;
- (IBAction)HelpAction:(id)sender;
- (IBAction)AlbumAction:(id)sender;
- (IBAction)SettingsAction:(id)sender;
@property (nonatomic) UIImagePickerController *imagePickerController;

- (IBAction)albumButtonAction:(id)sender;

@end

@implementation ViewController
@synthesize stillImageOutput,bannerView;;

- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appplicationIsActive:)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
    /*
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didRotate:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
    */

    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"TopView"];
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
    [tracker set:kGAIScreenName value:nil];
    
    NSLocale *currentLocale = [NSLocale currentLocale];
    NSString *countryCode = [currentLocale objectForKey:NSLocaleCountryCode];
    
    NSLog(@"Country name: %@", countryCode);

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
            self.bannerView = [[GADBannerView alloc] initWithAdSize:GADAdSizeFullWidthPortraitWithHeight(100)];
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
    
    /*
    self.globalAdview.delegate = self;z
    self.globalAdview.rootViewController = self;
    GADRequest *request = [GADRequest request];
    [self.globalAdview loadRequest:request];
    */
    
    self.interstitial = [[GADInterstitial alloc] init];
    self.interstitial.adUnitID = @"ca-app-pub-8337981281366372/6220332042";
    self.interstitial.delegate = self;
    GADRequest *request1 = [GADRequest request];
    [self.interstitial loadRequest:request1];
    
    
}


/*
- (void)didRotate:(NSNotification *)notification
{
    
    NSLocale *currentLocale = [NSLocale currentLocale];
    NSString *countryCode = [currentLocale objectForKey:NSLocaleCountryCode];
    
    NSLog(@"Country name: %@", countryCode);
    
    UIDeviceOrientation  orientation = [[UIDevice currentDevice] orientation];
    if ((orientation == UIDeviceOrientationLandscapeLeft)||(orientation == UIDeviceOrientationLandscapeRight))
    {
        
        
        if([countryCode isEqualToString:@"JP"])
        {
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                self.bannerView = [[GADBannerView alloc] initWithAdSize:GADAdSizeFullWidthLandscapeWithHeight(50)];
            }
            else {
                
                self.bannerView = [[GADBannerView alloc] initWithAdSize:GADAdSizeFullWidthLandscapeWithHeight(100)];
                
            }
            self.bannerView.adUnitID = @"ca-app-pub-8337981281366372/7697065240";
            
        }
        
        else
        {
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                self.bannerView = [[GADBannerView alloc] initWithAdSize:GADAdSizeFullWidthLandscapeWithHeight(100)];
            }
            else {
                
                self.bannerView = [[GADBannerView alloc] initWithAdSize:GADAdSizeFullWidthLandscapeWithHeight(50)];
                
            }
            self.bannerView.adUnitID = @"ca-app-pub-8337981281366372/9173798446";
            
        }

        
        
        
        
    }
    if((orientation == UIDeviceOrientationPortrait)||(orientation == UIDeviceOrientationPortraitUpsideDown))
    {
        
        
        
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
                self.bannerView = [[GADBannerView alloc] initWithAdSize:GADAdSizeFullWidthPortraitWithHeight(100)];
            }
            else {
                
                self.bannerView = [[GADBannerView alloc] initWithAdSize:GADAdSizeFullWidthPortraitWithHeight(50)];
                
            }
            self.bannerView.adUnitID = @"ca-app-pub-8337981281366372/9173798446";
            
        }

        
        
    }
    
    
    self.bannerView.delegate = self;
    self.bannerView.rootViewController = self;
    GADRequest *request = [GADRequest request];
    [self.bannerView loadRequest:request];
    [self.globalAdview addSubview:self.bannerView];
    

    
}

*/

- (void)appplicationIsActive:(NSNotification *)notification {
    
    
    
    
    NSLog(@"Application Did Become Active");
    
    [self displayAds];
    
}





/// Called when an ad request loaded an ad.
- (void)adViewDidReceiveAd:(GADBannerView *)adView {
    NSLog(@"adViewDidReceiveAd");
    
    NSLog(@"Banner adapter class name: %@", adView.adNetworkClassName);
    
    
    
}

/// Called when an ad request failed.
- (void)adView:(GADBannerView *)adView didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"adViewDidFailToReceiveAdWithError: %@", [error localizedDescription]);
    
}

/// Called just before presenting the user a full screen view, such as
/// a browser, in response to clicking on an ad.
- (void)adViewWillPresentScreen:(GADBannerView *)adView {
    NSLog(@"adViewWillPresentScreen");
    
    
}

/// Called just before dismissing a full screen view.
- (void)adViewWillDismissScreen:(GADBannerView *)adView {
    NSLog(@"adViewWillDismissScreen");
    
    
}

/// Called just after dismissing a full screen view.
- (void)adViewDidDismissScreen:(GADBannerView *)adView {
    NSLog(@"adViewDidDismissScreen");
    
    
}

/// Called just before the application will background or terminate
/// because the user clicked on an ad that will launch another
/// application (such as the App Store).
- (void)adViewWillLeaveApplication:(GADBannerView *)adView {
    NSLog(@"adViewDidLeaveApplication");
    
    
}



- (void)displayAds
{
    NSLog(@"ping");
    
    
    NSUserDefaults *checkDefault = [NSUserDefaults standardUserDefaults];
    int value =    [checkDefault integerForKey:@"StartAppCont"];
    NSLog(@"app launch value%d",value);
    
    
    NSLog(@"show add");
    
    
    
    NSLocale *currentLocale = [NSLocale currentLocale];  // get the current locale.
    NSString *countryCode = [currentLocale objectForKey:NSLocaleCountryCode];
    
    NSLog(@"Country name: %@", countryCode);
    
    
    if([countryCode isEqualToString:@"JP"]) {
        
        //dispatch_async(dispatch_get_main_queue(), ^{
            
             //if((value % 2) == 0)  {
                 
            BOOL result0 = [ImobileSdkAds registerWithPublisherID:@"27405"
                                                          MediaID:@"140739"
                                                           SpotID:@"364597"];
            
            [ImobileSdkAds startBySpotID:@"364597"];
            [ImobileSdkAds showBySpotID:@"364597"];
            
            
            NSLog(@"loading imobile ads\n");
            
            if (!result0) {
                
                NSLog(@"failed in loading imobile ads\n");
                
                NSLog(@"テキストポップアップ広告の登録に失敗しました。");
            }
            
            [ImobileSdkAds showBySpotID:@"364597"];
             //}
            
        //});
        
        
        
         if((value % 5) == 0){
         
         BOOL appreview = [[NSUserDefaults standardUserDefaults] boolForKey:@"Pref_DontShowAppReview"];
         
         
         if(appreview == FALSE) {
         
         [self showReviewDilog];
             
         }
         
         }
        
        
    }
    else
    {
        
        if((value % 2) == 0)  {
            
            if (self.interstitial.isReady) {
                
                [self.interstitial presentFromRootViewController:self];
                
            } else {
                
                
                /*[[[UIAlertView alloc] initWithTitle:@"Interstitial not ready"
                 message:@"The interstitial didn't finish loading or failed to load"
                 delegate:self
                 cancelButtonTitle:@"cancel"
                 otherButtonTitles:nil] show];
                 */
                
            }
            
            
        }
        
         else if((value % 5) == 0){
         
             BOOL appreview = [[NSUserDefaults standardUserDefaults] boolForKey:@"Pref_DontShowAppReview"];
         
         
             if(appreview == FALSE) {
         
                 [self showReviewDilog];
             }
         
         }
        
        
        
        
        
        
        
    }
    
    
    
    
    
    //BackAppCont
    
    
    
    
    
    
    
    
    
}



- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)showImobileAds:(NSTimer *)timer {
    
}



-(void)viewDidAppear:(BOOL)animated
{

    
    
    
 
}

-(void)viewWillAppear:(BOOL)animated
{
  
    
  
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ShadowAction:(id)sender {
    [self performSegueWithIdentifier:@"ShadowCamera" sender:self];
    
}

- (IBAction)DarknessAction:(id)sender {
    [self performSegueWithIdentifier:@"DarkSegue" sender:self];
    
   
}

- (IBAction)NoSoundAction:(id)sender {
    
    
    [self performSegueWithIdentifier:@"NoSoundSegue" sender:self];
    
    
}





- (IBAction)HelpAction:(id)sender {
    [self performSegueWithIdentifier:@"HelpSegue" sender:self];

    
}

- (IBAction)AlbumAction:(id)sender {
    
    

    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    Boolean ispasscodeOn =    [defaults boolForKey:@"isPasscodeOn"];
     NSLog(@"switchcase%d",ispasscodeOn);
    if(ispasscodeOn==TRUE)
        
    {
        passwordCheckSegue = @"album";
        [self performSegueWithIdentifier:@"PasscodeFromTop" sender:self];
        

    }
    else
    {
    [self performSegueWithIdentifier:@"albumSegue" sender:self];
    }

}

- (IBAction)SettingsAction:(id)sender {
   

    
    
    [self performSegueWithIdentifier:@"SettingsSegue" sender:self];


    
}



- (IBAction)unwindTopView:(UIStoryboardSegue *)unwindSegue
{
    
    

    
    
    NSLog(@"unwind segue :%@", [unwindSegue identifier ] );
    
    if([[unwindSegue identifier ] isEqualToString:@"CloseNoSound"])
    {
        
        
        NSUserDefaults *checkDefault = [NSUserDefaults standardUserDefaults];
        int value =    [checkDefault integerForKey:@"Pref_NoSoundClose"];
        value++;
        
        [checkDefault setInteger:value forKey:@"Pref_NoSoundClose"];
        [checkDefault synchronize];
        NSLog(@"NoSoundCameraClosed value%d",value);
        
        if((value % 3) == 0)  {
            
            self.interstitial = [[GADInterstitial alloc] init];
            self.interstitial.adUnitID = @"ca-app-pub-8337981281366372/6220332042";
            self.interstitial.delegate = self;
            GADRequest *request1 = [GADRequest request];
            [self.interstitial loadRequest:request1];
      
        
            [NSTimer scheduledTimerWithTimeInterval:2.0
                                         target:self
                                       selector:@selector(NoSoundCameraClosed:)
                                       userInfo:nil
                                        repeats:NO];
        }
        
        
        
    }
    
    
    else if([[unwindSegue identifier ] isEqualToString:@"CloseShadow"])
    {
        
        
        
        NSUserDefaults *checkDefault = [NSUserDefaults standardUserDefaults];
        int value =    [checkDefault integerForKey:@"Pref_ShadowClose"];
        value++;
        
        [checkDefault setInteger:value forKey:@"Pref_ShadowClose"];
        [checkDefault synchronize];
        NSLog(@"ShadowCameraClosed value%d",value);
        
        if((value % 3) == 0)  {
            
            self.interstitial = [[GADInterstitial alloc] init];
            self.interstitial.adUnitID = @"ca-app-pub-8337981281366372/6220332042";
            self.interstitial.delegate = self;
            GADRequest *request1 = [GADRequest request];
            [self.interstitial loadRequest:request1];

        
            [NSTimer scheduledTimerWithTimeInterval:2.0
                                         target:self
                                       selector:@selector(ShadowCameraClosed:)
                                       userInfo:nil
                                        repeats:NO];
            
        }
        
        
        

    }
    
    
    else if([[unwindSegue identifier ] isEqualToString:@"CloseDarkness"])
    {
        
        NSUserDefaults *checkDefault = [NSUserDefaults standardUserDefaults];
        int value =    [checkDefault integerForKey:@"Pref_DarknessClose"];
        value++;
        
        [checkDefault setInteger:value forKey:@"Pref_DarknessClose"];
        [checkDefault synchronize];
        NSLog(@"DarknessCameraClosed value%d",value);
        
        if((value % 3) == 0)  {
            
            self.interstitial = [[GADInterstitial alloc] init];
            self.interstitial.adUnitID = @"ca-app-pub-8337981281366372/6220332042";
            self.interstitial.delegate = self;
            GADRequest *request1 = [GADRequest request];
            [self.interstitial loadRequest:request1];

            
            [NSTimer scheduledTimerWithTimeInterval:2.0
                                         target:self
                                       selector:@selector(DarknessCameraClosed:)
                                       userInfo:nil
                                        repeats:NO];
            
        }
        
    }
    
    
}



- (void)NoSoundCameraClosed:(NSTimer *)timer

{
    
        if (self.interstitial.isReady) {
            
            NSLog(@"ready to display ads\n");
            [self.interstitial presentFromRootViewController:self];
            
            
        }
        else {
            
            NSLog(@"not ready to display ads\n");
            
           /* [[[UIAlertView alloc] initWithTitle:@"Interstitial not ready"
                                        message:@"The interstitial didn't finish loading or failed to load"
                                       delegate:self
                              cancelButtonTitle:@"cancel"
                              otherButtonTitles:nil] show];
            */
            
        }
   
    
}

-(void)DarknessCameraClosed:(NSTimer *)timer
{
    
    
    
        if (self.interstitial.isReady) {
            
            [self.interstitial presentFromRootViewController:self];
            
            
        }
        else {
            
            /*
            [[[UIAlertView alloc] initWithTitle:@"Interstitial not ready"
                                        message:@"The interstitial didn't finish loading or failed to load"
                                       delegate:self
                              cancelButtonTitle:@"cancel"
                              otherButtonTitles:nil] show];
            */
            
        }
        
   
    
    
}


-(void)ShadowCameraClosed:(NSTimer *)timer

{
    
        
        if (self.interstitial.isReady) {
            
            
            [self.interstitial presentFromRootViewController:self];
            
        }
        else {
            
            /*
            [[[UIAlertView alloc] initWithTitle:@"Interstitial not ready"
                                        message:@"The interstitial didn't finish loading or failed to load"
                                       delegate:self
                              cancelButtonTitle:@"cancel"
                              otherButtonTitles:nil] show];
            */
            
            
        }
    
    
    
}






/// Called when an interstitial ad request succeeded.
-(void)interstitialDidReceiveAd:(GADInterstitial *)ad {
    NSLog(@"interstitialDidReceiveAd");
    
    
}

/// Called when an interstitial ad request failed.
-(void)interstitial:(GADInterstitial *)ad didFailToReceiveAdWithError:(GADRequestError *)error {
    
    NSLog(@"interstitialDidFailToReceiveAdWithError: %@", [error localizedDescription]);
    
    
}

/// Called just before presenting an interstitial.
-(void)interstitialWillPresentScreen:(GADInterstitial *)ad {
    NSLog(@"interstitialWillPresentScreen");
    
    
    
}

/// Called before the interstitial is to be animated off the screen.
-(void)interstitialWillDismissScreen:(GADInterstitial *)ad {
    NSLog(@"interstitialWillDismissScreen");
    
    
}

/// Called just after dismissing an interstitial and it has animated off the screen.
-(void)interstitialDidDismissScreen:(GADInterstitial *)ad {
    NSLog(@"interstitialDidDismissScreen");
    
    self.interstitial = [[GADInterstitial alloc] init];
    self.interstitial.adUnitID = @"ca-app-pub-8337981281366372/6220332042";
    self.interstitial.delegate = self;
    GADRequest *request1 = [GADRequest request];
    [self.interstitial loadRequest:request1];
    

    
    
    
}

/// Called just before the application will background or terminate because the user clicked on an
/// ad that will launch another application (such as the App Store).
- (void)interstitialWillLeaveApplication:(GADInterstitial *)ad {
    NSLog(@"interstitialWillLeaveApplication");
    
    
    
    
}


- (IBAction)CanceloverlayAction:(id)sender {
    
}
- (IBAction)CameraOverlayActiom:(id)sender {
    
}

- (IBAction)ShootOverlayAction:(id)sender {
    [self.imagePickerController takePicture];

}

- (IBAction)VideoOverlayAction:(id)sender {
    
}

-(void)passwordAuth:(NSString *)result
{

    if([result isEqualToString:@"OK"])
    {
        if([passwordCheckSegue isEqualToString:@"settings"])
        {
        

        [self performSegueWithIdentifier:@"SettingsSegue" sender:self];
        }
        else if([passwordCheckSegue isEqualToString:@"album"])
        {
            
            
            [self performSegueWithIdentifier:@"albumSegue" sender:self];
        }
    }
    
    

}




-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    
    if([[segue identifier ] isEqualToString:@"PasscodeFromTop"])
    {
       
        
        //CheckPassword *checkPassword = [segue destinationViewController];
        
        //checkPassword.delegate = self;
        PasscodeLockScreen *checkPassword = [segue destinationViewController];
        checkPassword.delegate = self;
        checkPassword.isCheckPassword = TRUE;
        
    }
    
}


- (void)createAndLoadInterstitial {
    NSLog(@"Called");
    self.interstitial = [[GADInterstitial alloc] init];
    //self.interstitial.adUnitID = @"ca-app-pub-9874128266588393/6433190665";
    self.interstitial.adUnitID = @"ca-app-pub-8337981281366372/6220332042";

    self.interstitial.delegate = self;
    GADRequest *request = [GADRequest request];
    // Request test ads on devices you specify. Your test device ID is printed to the console when
    // an ad request is made. GADInterstitial automatically returns test ads when running on a
    // simulator.
    request.testDevices = @[
                            @"579e4349dc5e247230bda1b65f70f16c"  // Eric's iPod Touch
                            ];
    [self.interstitial loadRequest:request];
}


-(void)nadViewDidFinishLoad:(NADView *)adView {
    NSLog(@"delegate nadViewDidFinishLoad:"); }
- (void)nadViewDidClickAd:(NADView *)adView { NSLog(@"delegate nadViewDidClickAd:");
}


-(void)nadViewDidReceiveAd:(NADView *)adView {
    NSLog(@"delegate nadViewDidReceiveAd:"); }



-(void)nadViewDidFailToReceiveAd:(NADView *)adView
{
    NSLog(@"delegate nadViewDidFailToLoad:");
    // エラーごとに分岐する
    NSError* error = adView.error; NSString* domain = error.domain; int errorCode = error.code;
    // isOutputLog = NO でも、domain を利用してアプリ側で任意出力が可能 NSLog(@"log %d", adView.isOutputLog);
    NSLog(@"%@",[NSString stringWithFormat: @"code=%d, message=%@",
                 errorCode, domain]);
    switch (errorCode) {
        case NADVIEW_AD_SIZE_TOO_LARGE:
            // 広告サイズがディスプレイサイズよりも大きい
            break;
        case NADVIEW_INVALID_RESPONSE_TYPE:
            // 不明な広告ビュータイプ
            break;
        case NADVIEW_FAILED_AD_REQUEST:
            // 広告取得失敗
            break;
        case NADVIEW_FAILED_AD_DOWNLOAD:
            // 広告画像の取得失敗
            break;
        case NADVIEW_AD_SIZE_DIFFERENCES:
            // リクエストしたサイズと取得したサイズが異なる
            break; default:
        break; }
}



#pragma - mark ImobaileSdkAdsDelegate

// --------------------------------------------------
// 広告が表示可能になった際に呼ばれます
- (void)imobileSdkAdsSpot:(NSString *)spotid didReadyWithValue:(ImobileSdkAdsReadyResult)value {
    NSString *msg = [NSString stringWithFormat:@"%@ : 広告表示の準備完了 ", spotid];
    /*
    if ([IMOBILE_SDK_ADS_SPOT_ID_1 isEqualToString:spotid]) {
        self.label01.text = msg;
    } else if ([IMOBILE_SDK_ADS_SPOT_ID_2 isEqualToString:spotid]) {
        self.label02.text = msg;
    }
    */
    
    
    
    NSLog(@"%@ : %@", msg,value == IMOBILESDKADS_READY_AD ? @"通常広告" : @"自社広告");
}

// --------------------------------------------------
// 広告が取得できない状態の場合に呼ばれます
// ※ ネットワークにつながらない場合など
- (void)imobileSdkAdsSpot:(NSString *)spotid didFailWithValue:(ImobileSdkAdsFailResult)value {
    
    NSString *error;
    switch (value) {
        case IMOBILESDKADS_ERROR_PARAM:
            error = @"エラー：パラメーターエラー";
            break;
            
        case IMOBILESDKADS_ERROR_AUTHORITY:
            error = @"エラー：権限エラー";
            break;
            
        case IMOBILESDKADS_ERROR_RESPONSE:
            error = @"エラー：不明";
            break;
            
        case IMOBILESDKADS_ERROR_NETWORK_NOT_READY:
            error = @"エラー：ネットワーク未接続";
            break;
            
        case IMOBILESDKADS_ERROR_NETWORK:
            error = @"エラー：ネットワークエラー";
            break;
            
        case IMOBILESDKADS_ERROR_UNKNOWN:
            error = @"エラー：不明";
            break;
            
        case IMOBILESDKADS_ERROR_AD_NOT_READY:
            error = @"エラー：広告表示準備未完了";
            break;
            
        case IMOBILESDKADS_ERROR_NOT_FOUND:
            error = @"エラー：広告切れ";
            break;
            
        default:
            error = @"エラー：その他";
            break;
    }
    
    NSMutableString *msg = [NSMutableString stringWithFormat:@"%@ : %@", spotid, error];
    
    //ImobileSdkAdsStatus status = [ImobileSdkAds getStatusBySpotID:spotid];
   /*if (IMOBILESDKADS_STATUS_READY == status) {
        [msg appendString:@"：次の広告が準備済み"];
    }
    
    if ([IMOBILE_SDK_ADS_SPOT_ID_1 isEqualToString:spotid]) {
        //self.label01.text = msg;
    } else if ([IMOBILE_SDK_ADS_SPOT_ID_2 isEqualToString:spotid]) {
        //self.label02.text = msg;
    }
    */
    
    NSLog(@"%@ :", msg);
}

// --------------------------------------------------
// "showBySpotID"を呼んだ際、広告が表示できない状態の時に呼ばれます
- (void)imobileSdkAdsSpotIsNotReady:(NSString *)spotid {
    NSString *msg = [NSString stringWithFormat:@"%@ : 広告を準備中", spotid];
   /*
    if ([IMOBILE_SDK_ADS_SPOT_ID_1 isEqualToString:spotid]) {
        self.label01.text = msg;
    } else if ([IMOBILE_SDK_ADS_SPOT_ID_2 isEqualToString:spotid]) {
        self.label02.text = msg;
    }
    */
    
    NSLog(@"%@", msg);
}

// --------------------------------------------------
// 表示中の広告がタップされた場合に呼ばれます
- (void)imobileSdkAdsSpotDidClick:(NSString *)spotid {
    NSMutableString *msg = [NSMutableString stringWithFormat:@"%@ : 広告がクリックされました", spotid];
    
    //ImobileSdkAdsStatus status = [ImobileSdkAds getStatusBySpotID:spotid];
    /*if (IMOBILESDKADS_STATUS_READY == status) {
        [msg appendString:@"：次の広告が準備済み"];
    }
    
    if ([IMOBILE_SDK_ADS_SPOT_ID_1 isEqualToString:spotid]) {
        self.label01.text = msg;
    } else if ([IMOBILE_SDK_ADS_SPOT_ID_2 isEqualToString:spotid]) {
        self.label02.text = msg;
    }
    */
    NSLog(@"%@", msg);
}

// --------------------------------------------------
// 表示中の広告が閉じられた場合に呼ばれます
- (void)imobileSdkAdsSpotDidClose:(NSString *)spotid {
    NSString *msg = [NSString stringWithFormat:@"%@ : 広告が閉じられました", spotid];
    /*
    if ([IMOBILE_SDK_ADS_SPOT_ID_1 isEqualToString:spotid]) {
        self.label01.text = msg;
    } else if ([IMOBILE_SDK_ADS_SPOT_ID_2 isEqualToString:spotid]) {
        self.label02.text = msg;
        
        // View3に遷移します
        View3ViewController *view3 = [[View3ViewController alloc] init];
        [self presentModalViewController:view3 animated:YES];
    }
    */
    NSLog(@"%@", msg);
}

// --------------------------------------------------
// 広告の表示が完了した際に呼ばれます
- (void)imobileSdkAdsSpotDidShow:(NSString *)spotid {
    NSString *msg = [NSString stringWithFormat:@"%@ : 広告が表示されました", spotid];
    NSLog(@"%@", msg);
}






/*

-(void)showReviewDilog
{
  
    NSString *title = @"いつもご利用頂き ありがとうございます!";
    NSString *message = @"レビュー評価を頂けると嬉しいです。引き続き超忍者カメラ をよろしくお願いします。";
    
    UIAlertView *appReviewAlert = [[UIAlertView alloc] initWithTitle:title
                                       message:message
                                       delegate:self
                                       cancelButtonTitle:@"キャンセル"
                                      otherButtonTitles:@"今後表示しない",@"レビューする",nil] ;

    
    
    
    appReviewAlert.tag = 666;
    [appReviewAlert show];
    

}


- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    
    
    
    if (alertView.tag == 666)
    {
        
        if (buttonIndex == 0) {
            
            
            
            
        }
        else if (buttonIndex == 1) {
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setBool:TRUE forKey:@"Pref_DontShowAppReview"];
            [defaults synchronize];
            
            
            
        }
        else if (buttonIndex == 2) {
            
            //be reviewed
            
            
        }
        
        
    }
    
    
    
    
}

*/


-(void)showReviewDilog
{
    
    NSString *title = @"いつもご利用頂き ありがとうございます!";
    NSString *message = @"レビュー評価を頂けると嬉しいです。引き続き超忍者カメラ をよろしくお願いします。";
    
    UIAlertView *appReviewAlert = [[UIAlertView alloc] initWithTitle:title
                                                             message:message
                                                            delegate:self
                                                   cancelButtonTitle:@"キャンセル"
                                                   otherButtonTitles:@"レビューする",@"今後表示しない",nil] ;
    
    
    
    
    appReviewAlert.tag = 666;
    [appReviewAlert show];
    
    
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    
    
    
    if (alertView.tag == 666)
    {
        
        if (buttonIndex == 0) {
            
            
            
            
        }
        else if (buttonIndex == 1) {
            // be Reviewd
            
            
            
            
        }
        else if (buttonIndex == 2) {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setBool:TRUE forKey:@"Pref_DontShowAppReview"];
            [defaults synchronize];
            
            
        }
        
        
    }
    
    
    
    
}







- (IBAction)albumButtonAction:(id)sender {
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    Boolean ispasscodeOn =    [defaults boolForKey:@"isPasscodeOn"];
    NSLog(@"switchcase%d",ispasscodeOn);
    if(ispasscodeOn==TRUE)
        
    {
        passwordCheckSegue = @"album";
        [self performSegueWithIdentifier:@"PasscodeFromTop" sender:self];
        
    }
    else
    {
        [self performSegueWithIdentifier:@"albumSegue" sender:self];
    }
    
}


-(void)SetPasscode:(NSString *)result
{

    NSString *savePasscode = [[NSUserDefaults standardUserDefaults] stringForKey:@"Passcode_key"];
    
    NSLog(@"new passcode:%@ old password: %@",result, savePasscode);
    
    
    if ([savePasscode isEqualToString:result]) {
        
       
        if([passwordCheckSegue isEqualToString:@"settings"])
        {
            
            
            [self performSegueWithIdentifier:@"SettingsSegue" sender:self];
        }
        else if([passwordCheckSegue isEqualToString:@"album"])
        {
            
            
            [self performSegueWithIdentifier:@"albumSegue" sender:self];
        }
    }




}
@end
