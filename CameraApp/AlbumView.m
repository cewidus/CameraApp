//
//  AlbumView.m
//  CameraApp
//
//  Created by annutech on 2/11/15.
//  Copyright (c) 2015 annutech. All rights reserved.
//
@import GoogleMobileAds;

#import "AlbumView.h"
#import <AVFoundation/AVFoundation.h>

#import "GAI.h"
#import <Parse/Parse.h>
#import "GAIDictionaryBuilder.h"
#import "GAI.h"
#import "GAIFields.h"
#import "GAITracker.h"

@interface AlbumView ()
{
    NSString *selectedContent;
    int position;
    NSString *imageFilePath;
    NSString *imageFolderPath;
    NSMutableArray *tempContents;
    NSMutableArray*deleteArrayupdate;
    NSString *assetName;
    NSString*deleteImageName;
    NSString* Imgfile;
    NSString* deleteImgfile;
    NSInteger deletedIndexpath;
    NSFileManager *fileManage;
    NSString *thumnailFolderPath;
    
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionview;
- (IBAction)AlbumHelpAction:(id)sender;
- (IBAction)AlbumSettingsAction:(id)sender;

@end

@implementation AlbumView
@synthesize assets;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"Album View"];
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
    [tracker set:kGAIScreenName value:nil];

    
    
    
    NSLocale *currentLocale = [NSLocale currentLocale];  // get the current locale.
    NSString *countryCode = [currentLocale objectForKey:NSLocaleCountryCode];
    
    //NSLog(@"Country name: %@", countryCode);
    
    /*
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
    
    
    fileManage = [NSFileManager defaultManager];
    NSError *error;
    imageFilePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/App_Camera_Media/"];
    
    tempContents = [fileManage contentsOfDirectoryAtPath:imageFilePath error:&error];

    //NSLog(@"tempContents%@",tempContents);
    
    assets = [@[] mutableCopy];
    __block NSMutableArray *tmpAssets = [@[] mutableCopy];
    // 1
    ALAssetsLibrary *assetsLibrary = [AlbumView defaultAssetsLibrary];
    // 2
    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
            if(result)
            {
                // 3
                [tmpAssets addObject:result];
            }
        }];
        
        // 4
        //NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO];
        //self.assets = [tmpAssets sortedArrayUsingDescriptors:@[sort]];
        self.assets = tmpAssets;
        
        // 5
        [self.collectionview reloadData];
    } failureBlock:^(NSError *error) {
        NSLog(@"Error loading images %@", error);
    }];
    

    
   
     //self.trashButton.hidden=TRUE;
    
    
    

}






-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
    //self.trashButton.hidden=FALSE;

    if (gestureRecognizer.state != UIGestureRecognizerStateEnded) {
        return;
    }
    CGPoint p = [gestureRecognizer locationInView:self.collectionview];
    
    NSIndexPath *indexPath = [self.collectionview indexPathForItemAtPoint:p];
    if (indexPath == nil){
        NSLog(@"couldn't find index path");
    } else {
        // get the cell at indexPath (the one you long pressed)
        UICollectionViewCell* cell =
        [self.collectionview cellForItemAtIndexPath:indexPath];
        // do stuff with the cell
        
        deletedIndexpath = indexPath.row;
        
        //NSLog(@" find index path%d",deletedIndexpath);
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Really Delete?"
                                                        message:@"Do you really want to Delete"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"Delete", nil];
        
        [alert show];
    }
    
    
}
- (void)viewWillAppear:(BOOL)animated
{
    
    fileManage = [NSFileManager defaultManager];
    NSError *error;
    imageFilePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/App_Camera_Media/"];
    
    
    [tempContents removeAllObjects];
    tempContents = [fileManage contentsOfDirectoryAtPath:imageFilePath error:&error];
    
    
   
   [self createAndLoadInterstitial];
    
    //[self.collectionview reloadData];
    
    [super viewWillAppear:animated];
    
    
}

-(void)viewDidAppear:(BOOL)animated
{
  
    
    [self.collectionview reloadData];
    [super viewDidAppear:animated];
    
    
}



+ (ALAssetsLibrary *)defaultAssetsLibrary
{
    static dispatch_once_t pred = 0;
    static ALAssetsLibrary *library = nil;
    dispatch_once(&pred, ^{
        library = [[ALAssetsLibrary alloc] init];
    });
    return library;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}






- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //NSLog(@"assets.count%i",tempContents.count);
    return tempContents.count;
    
    
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *identifier1 = @"Cell1";
    UICollectionViewCell *cell1 = [self.collectionview dequeueReusableCellWithReuseIdentifier:identifier1 forIndexPath:indexPath];
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    Boolean isascendng =    [defaults boolForKey:@"isAscending"];
    //NSLog(@"isdefaultCamera%d",isascendng);
    if(isascendng==FALSE)
        
    {
        assetName = tempContents[indexPath.row];
    }
    
    else
    {
        
        NSSortDescriptor *descriptor=[[NSSortDescriptor alloc] initWithKey:@"self" ascending:NO];
        NSArray *descriptors=[NSArray arrayWithObject: descriptor];
        NSArray *reverseOrder=[tempContents sortedArrayUsingDescriptors:descriptors];

         assetName = reverseOrder[indexPath.row];
        
    }
    
    

     Imgfile = [imageFilePath stringByAppendingPathComponent:assetName];


    
    NSString *FilePath = Imgfile;
    NSString *Extension = [FilePath lastPathComponent];
    NSString*fext=[Extension pathExtension];
    //NSLog(@"file patha%@",FilePath);
    //NSLog(@"Extension patha%@",fext);
    
    UIImageView *ImageView = (UIImageView *)[cell1 viewWithTag:100];
    
    
    ImageView.image = [UIImage imageWithContentsOfFile:Imgfile];
           if ([[Extension pathExtension] isEqualToString:@"png"]) {
               UIImageView *ImageView = (UIImageView *)[cell1 viewWithTag:100];
               ImageView.image = [UIImage imageWithContentsOfFile:Imgfile];
               

        }
       else if ([[Extension pathExtension] isEqualToString:@"mp4"])
       {
           
        ImageView.image = [UIImage imageNamed:@"image_holder.png"];
         
           UIImage *thumbnail = nil;
           NSURL *url = [NSURL fileURLWithPath:Imgfile];
           AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:url options:nil];
           AVAssetImageGenerator *generator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
           generator.appliesPreferredTrackTransform = YES;
           NSError *error = nil;
           CMTime time = CMTimeMake(3, 1); // 3/1 = 3 second(s)
           CGImageRef imgRef = [generator copyCGImageAtTime:time actualTime:nil error:&error];
           if (error != nil)
               NSLog(@"error in thumbnail%@: %@", self, error);
           thumbnail = [[UIImage alloc] initWithCGImage:imgRef];
           CGImageRelease(imgRef);
           AVAssetImageGeneratorCompletionHandler handler = ^(CMTime requestedTime, CGImageRef thumbnailImage, CMTime actualTime, AVAssetImageGeneratorResult result, NSError *error){
               if (result != AVAssetImageGeneratorSucceeded) {
                   
                   ImageView.image = [UIImage imageNamed:@"image_holder.png"];
                   
                   
                   NSLog(@"imageRef%@",thumbnailImage);
                   
               }
               
               else
               {
                   
                   
                   UIImage *thumbnail = [UIImage imageWithCGImage:thumbnailImage];
                   ImageView.image = thumbnail;
                   NSLog(@"image succedded");
                   
                   
                   //ImageView.hidden = FALSE;
                   
                   [ImageView setNeedsDisplay];
                   
                   
                   
                   
               }
               
               
           };
           
           CGSize maxSize = CGSizeMake(320, 180);
           generator.maximumSize = maxSize;
           [generator generateCGImagesAsynchronouslyForTimes:[NSArray arrayWithObject:[NSValue valueWithCMTime:time]] completionHandler:handler];
           
           
           
       }
    
    
    
    
    
    return cell1;
    
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell* cell1 = [self.collectionview  cellForItemAtIndexPath:indexPath];
    cell1.backgroundColor = [UIColor cyanColor];
    
    //selectedContent = [assets objectAtIndex:indexPath.row];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    Boolean isascendng =    [defaults boolForKey:@"isAscending"];
    //NSLog(@"isdefaultCamera%d",isascendng);
    if(isascendng==FALSE)
        
    {
        assetName = tempContents[indexPath.row];
    }
    
    else
    {
        
        NSSortDescriptor *descriptor=[[NSSortDescriptor alloc] initWithKey:@"self" ascending:NO];
        NSArray *descriptors=[NSArray arrayWithObject: descriptor];
        NSArray *reverseOrder=[tempContents sortedArrayUsingDescriptors:descriptors];
        
        assetName = reverseOrder[indexPath.row];
        
    }
    
  //  assetName = tempContents[indexPath.row];
     Imgfile = [imageFilePath stringByAppendingPathComponent:assetName];
     position=indexPath.row;
    
    NSString *FilePath = Imgfile;
    NSString *Extension = [FilePath lastPathComponent];
    //NSLog(@"the selected content in collectionview%@",Imgfile);
   
    if ([[Extension pathExtension] isEqualToString:@"png"])
        
    {
    [self performSegueWithIdentifier:@"SelectedAlbumSegue" sender:self];
    }
    else
    {
    [self performSegueWithIdentifier:@"VideoPlay_segue" sender:self]; 
    }
}




-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    
   
    
    NSString *FilePath = Imgfile;
    NSString *Extension = [FilePath lastPathComponent];
  
    if ([[Extension pathExtension] isEqualToString:@"png"])
    {
        
        
        AlbumFullView *transferViewController = segue.destinationViewController;
        if([segue.identifier isEqualToString:@"SelectedAlbumSegue"])
        {
            transferViewController.receivedFile = Imgfile;
            transferViewController.receivedArray=tempContents;
            transferViewController.receivedposition=position;
        }
    }
    else
    {
        VideoPlayer *transferViewController = segue.destinationViewController;
        if([segue.identifier isEqualToString:@"VideoPlay_segue"])
        {
            transferViewController.videoFileName = Imgfile;
        }
  
    }
    
    
}




- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
   // [picker dismissModalViewControllerAnimated:YES];
   // self.ima.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
}


- (IBAction)AlbumHelpAction:(id)sender {
    [self performSegueWithIdentifier:@"AlbumHelpSegue" sender:self];

    
}

- (IBAction)AlbumSettingsAction:(id)sender {
    
    [self performSegueWithIdentifier:@"AlbumSettinsSegue" sender:self];

    
}
- (IBAction)unwindToAlbumView:(UIStoryboardSegue *)segue
{
    // [self performSegueWithIdentifier:@"unwindTopView" sender:self];
    
}


- (IBAction)unwindToAlbumViewwithAd:(UIStoryboardSegue *)segue
{
    
    
    [NSTimer scheduledTimerWithTimeInterval:3.0
                                     target:self
                                   selector:@selector(showAds:)
                                   userInfo:nil
                                    repeats:NO];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    //NSLog(@" alertView index path%d",deletedIndexpath);
    
    
    if (buttonIndex == 1) {
        
        NSError *error;
        deleteImageName = tempContents[deletedIndexpath];
        deleteImgfile = [imageFilePath stringByAppendingPathComponent:assetName];
        BOOL success = [fileManage removeItemAtPath:deleteImgfile error:&error];
        if (success) {
            UIAlertView *removeSuccessFulAlert=[[UIAlertView alloc]initWithTitle:@"Congratulation:" message:@"Successfully Deleted" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
            [removeSuccessFulAlert show];
            [self.collectionview reloadData];
        }
        else
        {
            NSLog(@"Could not delete file -:%@ ",[error localizedDescription]);
        }
        
        
        
       // NSLog(@"tempContentsdeleteArrayupdate%@",tempContents);
        
        
    }
}

- (IBAction)trashButtonAction:(id)sender {
    UIButton *button = (UIButton *) sender;
  
}



- (void)showAds:(NSTimer *)timer {
   // NSLog(@"ping");
    
    NSUserDefaults *backDefault = [NSUserDefaults standardUserDefaults];
    int videcancelValue =    [backDefault integerForKey:@"StartVideoCont"];
    
    [backDefault setInteger:videcancelValue forKey:@"StartVideoCont"];
    [backDefault synchronize];
    //NSLog(@"backvalue%d",videcancelValue);
    
    if((videcancelValue % 2) == 0)  {
        
        //NSLog(@"show add");
        if (self.interstitial.isReady) {
            
            [self.interstitial presentFromRootViewController:self];
            
        }
        
        
    }
    
}

- (void)createAndLoadInterstitial {
    self.interstitial = [[GADInterstitial alloc] init];
    self.interstitial.adUnitID = @"ca-app-pub-8337981281366372/6220332042";

    self.interstitial.delegate = self;
    GADRequest *request = [GADRequest request];
  
    [self.interstitial loadRequest:request];
}


- (void)interstitial:(GADInterstitial *)interstitial
didFailToReceiveAdWithError:(GADRequestError *)error {
    
    NSLog(@"interstitialDidFailToReceiveAdWithError: %@", [error localizedDescription]);
}

- (void)interstitialDidDismissScreen:(GADInterstitial *)interstitial {
    
    NSLog(@"interstitialDidDismissScreen");
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}




@end
