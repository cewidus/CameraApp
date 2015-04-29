//
//  HelpView.m
//  CameraApp
//
//  Created by annutech on 2/11/15.
//  Copyright (c) 2015 annutech. All rights reserved.
//
@import GoogleMobileAds;

#import "HelpView.h"
#import "GAI.h"
#import <Parse/Parse.h>
#import "GAIDictionaryBuilder.h"
#import "GAI.h"
#import "GAIFields.h"
#import "GAITracker.h"


@interface HelpView ()
{
NSArray *numberOfCell;
}
- (IBAction)helpSettinsAct:(id)sender;
- (IBAction)helpAlbumAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *helpSettingsAction;
@property (weak, nonatomic) IBOutlet UITableView *HelpTableview;
- (IBAction)helpAlbumButtonAction:(id)sender;


@end

@implementation HelpView
@synthesize bannerView;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"Help View"];
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
    [tracker set:kGAIScreenName value:nil];

    
    
    numberOfCell = [NSArray arrayWithObjects:@"No Sound Camera",@"Shadow Camera",@"Darkness Camera",nil];

    
    NSLocale *currentLocale = [NSLocale currentLocale];  // get the current locale.
    NSString *countryCode = [currentLocale objectForKey:NSLocaleCountryCode];
    
   /*
    NSLog(@"Country name: %@", countryCode);
    
    
    if([countryCode isEqualToString:@"JP"])
        
    {
        
        self.globalAdview.adUnitID=@"ca-app-pub-8337981281366372/7697065240";
        
        
    }
    
    else{
        
        self.globalAdview.adUnitID=@"ca-app-pub-8337981281366372/9173798446";
        
        
    }
    
    self.globalAdview.delegate = self;
    self.globalAdview.rootViewController = self;
    GADRequest *request = [GADRequest request];
    [self.globalAdview loadRequest:request];
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

    

    self.HelpTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 3;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
         cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    }
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UILabel* helpLable = (UILabel *)[cell viewWithTag:200];
    UIImageView* imageView = (UIImageView *)[cell viewWithTag:100];
    
    if(indexPath.row == 0) {
        imageView.image = [UIImage imageNamed:@"link_button_muon.png"];

        helpLable.text = @"無カメラ";
    
    }
    if(indexPath.row == 1) {
        imageView.image = [UIImage imageNamed:@"link_button_in.png"];

        helpLable.text = @"陰カメラ";

    }
     if(indexPath.row == 2) {
        imageView.image = [UIImage imageNamed:@"link_button_yami.png"];
         helpLable.text = @"闇カメラ";

    }
   
   
    
    
   
        return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    if(indexPath.row == 0)
    {
        [self performSegueWithIdentifier:@"NosoundHelpSegue" sender:self];
        
    }
    if(indexPath.row == 1)
    {
        [self performSegueWithIdentifier:@"ShadowHelpsegue" sender:self];
        
    }
    if(indexPath.row == 2)
    {
        [self performSegueWithIdentifier:@"DarkhelpSegue" sender:self];
        
    }
    
    
    if(indexPath.row == 3)
    {
        //[self performSegueWithIdentifier:@"WebViewSegue" sender:self];
    }
    if(indexPath.row == 4)
    {
        //[self performSegueWithIdentifier:@"WebViewSegue" sender:self];
    }
    
    
}

- (IBAction)unwindTotableView:(UIStoryboardSegue *)segue
{
    // [self performSegueWithIdentifier:@"unwindTopView" sender:self];
    
}


- (IBAction)helpSettinsAct:(id)sender {
    
  
    
    
    [self performSegueWithIdentifier:@"helpSettingsSegue" sender:self];

}

- (IBAction)helpAlbumAction:(id)sender {
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    Boolean ispasscodeOn =    [defaults boolForKey:@"isPasscodeOn"];
    NSLog(@"switchcase%d",ispasscodeOn);
    if(ispasscodeOn == TRUE)
        
    {
        passwordCheckSegue = @"album";

        [self performSegueWithIdentifier:@"checkPassFromHelp" sender:self];
    }
    else {
        
        [self performSegueWithIdentifier:@"helpAlbumSegue" sender:self];

        
    }


}


-(void)passwordAuth:(NSString *)result
{
    
    if([result isEqualToString:@"OK"])
    {
        if([passwordCheckSegue isEqualToString:@"settings"])
        {
            
            
            [self performSegueWithIdentifier:@"helpSettingsSegue" sender:self];
        }
        else if([passwordCheckSegue isEqualToString:@"album"])
        {
            
            
            [self performSegueWithIdentifier:@"helpAlbumSegue" sender:self];
        }
    }
    
    
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    
    if([[segue identifier ] isEqualToString:@"checkPassFromHelp"])
    {
        
        
        PasscodeLockScreen  *checkPassword = [segue destinationViewController];
        
        checkPassword.delegate = self;
        checkPassword.isCheckPassword = TRUE;
        
    }
    
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}



- (IBAction)helpAlbumButtonAction:(id)sender {
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    Boolean ispasscodeOn =    [defaults boolForKey:@"isPasscodeOn"];
    NSLog(@"switchcase%d",ispasscodeOn);
    if(ispasscodeOn == TRUE)
        
    {
        passwordCheckSegue = @"album";
        
        [self performSegueWithIdentifier:@"checkPassFromHelp" sender:self];
    }
    else {
        
        [self performSegueWithIdentifier:@"helpAlbumSegue" sender:self];
        
        
    }

    
    
}



-(void)SetPasscode:(NSString *)result
{
    
    
    
    NSString *savePasscode = [[NSUserDefaults standardUserDefaults] stringForKey:@"Passcode_key"];
    
    NSLog(@"new passcode:%@ old password: %@",result, savePasscode);
    
    
    if ([savePasscode isEqualToString:result]) {
        
        if([passwordCheckSegue isEqualToString:@"settings"])
        {
            
            
            [self performSegueWithIdentifier:@"helpSettingsSegue" sender:self];
        }
        else if([passwordCheckSegue isEqualToString:@"album"])
        {
            
            
            [self performSegueWithIdentifier:@"helpAlbumSegue" sender:self];
        }
        
        
    }
    
    
    
    
}


@end
