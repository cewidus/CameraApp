//
//  AlbumFullView.m
//  CameraApp
//
//  Created by annutech on 2/12/15.
//  Copyright (c) 2015 annutech. All rights reserved.
//
@import GoogleMobileAds;

#import "AlbumFullView.h"
#import "ALAssetsLibrary+CustomPhotoAlbum.h"
#import "GAI.h"
#import <Parse/Parse.h>
#import "GAIDictionaryBuilder.h"
#import "GAI.h"
#import "GAIFields.h"
#import "GAITracker.h"

@interface AlbumFullView ()

{
    NSString*receivedFile;
    NSString*  selectedContent;
    int position;
    NSString *imageFilePath;
     NSString* Imgfile;
    NSFileManager *fileManage;
    NSMutableArray *tempContents;
    NSString *assetName;
    UIImage* didselectImage;
    NSString *FilePath;
     NSMutableArray*deleteArrayupdate;
    NSString*didselectVideo;

}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *previousItem;
@property (weak, nonatomic) IBOutlet UIButton *nextItem;
- (IBAction)previousImageAction:(id)sender;
- (IBAction)NextItemAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *savebutton;
- (IBAction)saveButtonAction:(id)sender;



@end

@implementation AlbumFullView
@synthesize receivedFile,receivedArray,receivedposition,library,bannerView;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"AlbumDetail View"];
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
    [tracker set:kGAIScreenName value:nil];

    
    
    NSLocale *currentLocale = [NSLocale currentLocale];  // get the current locale.
    NSString *countryCode = [currentLocale objectForKey:NSLocaleCountryCode];
    
    
    
    UISwipeGestureRecognizer *leftgestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandlerLeft:)];
    [leftgestureRecognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [self.view addGestureRecognizer:leftgestureRecognizer];
    UISwipeGestureRecognizer *rightGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandlerRight:)];
    [rightGestureRecognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.view addGestureRecognizer:rightGestureRecognizer];
    
    
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
    
        
    
     imageFilePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/App_Camera_Media/"];

    fileToSaveDelete=receivedFile;
  

    position=receivedposition;

           didselectImage=[UIImage imageWithContentsOfFile:receivedFile];
            self.albumImage.image=didselectImage;
    
    
    
    
    fileManage = [NSFileManager defaultManager];
    NSError *error;
    imageFilePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/App_Camera_Media/"];
    
    tempContents = [fileManage contentsOfDirectoryAtPath:imageFilePath error:&error];
    
    

    self.library = [[ALAssetsLibrary alloc] init];
    
    
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    
    [self.albumImage setUserInteractionEnabled:YES];
    [self.albumImage addGestureRecognizer:singleFingerTap];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



- (IBAction)previousImageAction:(id)sender {
    
    
    @try {
        position = (position - 1)% receivedArray.count;
        NSString*myObject=[receivedArray objectAtIndex:position];
        
        
        // NSLog(@"assetsName%@",assetName);
        Imgfile = [imageFilePath stringByAppendingPathComponent:myObject];
        UIImage* theImage=[UIImage imageWithContentsOfFile:Imgfile];
        fileToSaveDelete=Imgfile;
        self.albumImage.image=theImage;
    }
    
    @catch(NSException *e) {
    }
  
   
    position--;

}

- (IBAction)NextItemAction:(id)sender {
    
    
    position = (position + 1)% receivedArray.count;
    NSString*myObject=[receivedArray objectAtIndex:position];
    
    // NSLog(@"assetsName%@",assetName);
    Imgfile = [imageFilePath stringByAppendingPathComponent:myObject];
    UIImage* theImage=[UIImage imageWithContentsOfFile:Imgfile];
   
    fileToSaveDelete=Imgfile;
    self.albumImage.image=theImage;
    
    
    position++;


}
-(void)viewWillAppear:(BOOL)animated
{
     [super viewWillAppear:animated];
fileManage = [NSFileManager defaultManager];
NSError *error;
imageFilePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/App_Camera_Media/"];


[tempContents removeAllObjects];
tempContents = [fileManage contentsOfDirectoryAtPath:imageFilePath error:&error];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    fileManage = [NSFileManager defaultManager];
    NSError *error;
    imageFilePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/App_Camera_Media/"];
    
    
    [tempContents removeAllObjects];
    tempContents = [fileManage contentsOfDirectoryAtPath:imageFilePath error:&error];
    
    
    [self.collectionView reloadData];
    
    
}


-(void)swipeHandlerLeft:(UISwipeGestureRecognizer *)recognizer {
    
    
    @try {
        position = (position - 1)% receivedArray.count;
        NSString*myObject=[receivedArray objectAtIndex:position];
        
        
        // NSLog(@"assetsName%@",assetName);
        Imgfile = [imageFilePath stringByAppendingPathComponent:myObject];
        UIImage* theImage=[UIImage imageWithContentsOfFile:Imgfile];
        fileToSaveDelete=Imgfile;
        self.albumImage.image=theImage;
    }
    
    @catch(NSException *e) {
    }
    
    
    position--;

    
    
}

-(void)swipeHandlerRight:(UISwipeGestureRecognizer *)recognizer {
    
    
    
    position = (position + 1)% receivedArray.count;
    NSString*myObject=[receivedArray objectAtIndex:position];
    
    Imgfile = [imageFilePath stringByAppendingPathComponent:myObject];
    UIImage* theImage=[UIImage imageWithContentsOfFile:Imgfile];
    
    fileToSaveDelete=Imgfile;
    self.albumImage.image=theImage;
    
    
    position++;
    
    
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return tempContents.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifier1 = @"smallCell";
    UICollectionViewCell *cell1 = [self.collectionView dequeueReusableCellWithReuseIdentifier:identifier1 forIndexPath:indexPath];
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    Boolean isascendng =    [defaults boolForKey:@"isAscending"];
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
    
    
   FilePath = Imgfile;
    NSString *Extension = [FilePath lastPathComponent];
    NSString*fext=[Extension pathExtension];
    
    UIImageView *ImageView = (UIImageView *)[cell1 viewWithTag:200];
    ImageView.image = [UIImage imageWithContentsOfFile:Imgfile];
    if ([[Extension pathExtension] isEqualToString:@"png"]) {
        UIImageView *ImageView = (UIImageView *)[cell1 viewWithTag:200];
        ImageView.image = [UIImage imageWithContentsOfFile:Imgfile];
        
        
    }
    else if ([[Extension pathExtension] isEqualToString:@"mp4"])
    {
        UIImageView *ImageView = (UIImageView *)[cell1 viewWithTag:200];
        
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
            if (result != AVAssetImageGeneratorSucceeded)
            {
                
                ImageView.image = [UIImage imageNamed:@"image_holder.png"];
                
                
                NSLog(@"imageRef%@",thumbnailImage);
                
            }
            
            else
            {
                
                UIImage *thumbnail = [UIImage imageWithCGImage:thumbnailImage];
                ImageView.image = thumbnail;
                NSLog(@"image succedded");
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
    UICollectionViewCell* cell1 = [self.collectionView  cellForItemAtIndexPath:indexPath];
    cell1.backgroundColor = [UIColor cyanColor];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    Boolean isascendng =    [defaults boolForKey:@"isAscending"];

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
    FilePath=Imgfile;
    NSString *Extension = [FilePath lastPathComponent];
    NSLog(@"the selected content in collectionview%@",Imgfile);
    fileToSaveDelete=FilePath;
    if ([[Extension pathExtension] isEqualToString:@"png"])
        
    {
        
        didselectImage=[UIImage imageWithContentsOfFile:FilePath];
        self.albumImage.image=didselectImage;
    }
    else
    {
        
        
        didselectVideo=FilePath;
        
        
        UIImage *thumbnail = nil;
        NSURL *url = [NSURL fileURLWithPath:FilePath];
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
                
                self.albumImage.image=[UIImage imageNamed:@"Placeholder.png"];
                
                
                NSLog(@"imageRef%@",thumbnailImage);
                
            }
            
            else
            {
                
                UIImage *thumbnail = [UIImage imageWithCGImage:thumbnailImage];
               // ImageView.image = thumbnail;
                
                self.albumImage.image=thumbnail;
                NSLog(@"image succedded");
                
            }
            
            
        };
        CGSize maxSize = CGSizeMake(320, 180);
        generator.maximumSize = maxSize;
        [generator generateCGImagesAsynchronouslyForTimes:[NSArray arrayWithObject:[NSValue valueWithCMTime:time]] completionHandler:handler];
        

    }
    
}







- (IBAction)saveButtonAction:(id)sender {
    
    
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"閉じる", @"閉じる")
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction *action)
                                   {
                                       NSLog(@"Cancel action");
                                   }];
    
    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"保存", @"保存")
                                                             //style:UIAlertActionStyleDestructive
                                     style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction *action)
                                     {
                                         NSLog(@"save All");
                                         
                                         [self saveImage];
                                         
                                     }];
    
    
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"削除", @"削除")
                                    //style:UIAlertActionStyleDestructive
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction *action)
                                    {
                                        NSLog(@"Delete action");
                                        [self deletImage];
                                        
                                       
                                        
                                        
                                        
                                    }];
    
    
    
    [alertController addAction:saveAction];
    [alertController addAction:deleteAction];
    [alertController addAction:cancelAction];

    
    UIPopoverPresentationController *popover = alertController.popoverPresentationController;
    if (popover)
    {
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            popover.sourceView = self.view;
        }
        else {
            
            popover.sourceView = sender;
            
        }
        
        //popover.sourceView = sender;
        //popover.sourceRect = sender.bounds;
        popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
    }
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    
    
    
}






- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    
    NSLog(@"tapped");
    
    NSString *Extension = [didselectVideo lastPathComponent];
    
    if ([[Extension pathExtension] isEqualToString:@"mp4"])
        
    {
        [self performSegueWithIdentifier:@"VideoFromAlbumFull" sender:self];
        
    }
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    
    VideoPlayer *transferViewController = segue.destinationViewController;
    if([segue.identifier isEqualToString:@"VideoFromAlbumFull"])
    {
        transferViewController.videoFileName = didselectVideo;
    }

    DeleteSaveView *deleteSaveViewController = segue.destinationViewController;
    if([segue.identifier isEqualToString:@"deleteScreen"])
    {
        deleteSaveViewController.videoFileName = fileToSaveDelete;
    }
    
}
- (IBAction)unwinddeleteSaveView:(UIStoryboardSegue *)segue
{
    
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


-(void)deletImage
{


    
    
    UIAlertView *removeSuccessFulAlert=[[UIAlertView alloc]initWithTitle:@"" message:@"ファイルを削除してよろしいですか？" delegate:self cancelButtonTitle:@"はい" otherButtonTitles:@"いいえ",nil];
    
    removeSuccessFulAlert.tag = 100;
    [removeSuccessFulAlert show];




}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    if (alertView.tag == 100) { // h
        
        if (buttonIndex == 0) {
            
            
            
            NSError *error;
            
            BOOL success = [fileManage removeItemAtPath:fileToSaveDelete error:&error];
            if (success) {
                UIAlertView *removeSuccessFulAlert=[[UIAlertView alloc]initWithTitle:@"" message:@"ファイルを削除しました。" delegate:self cancelButtonTitle:@"確認" otherButtonTitles:nil];
                [removeSuccessFulAlert show];
            }
            else
            {
                NSLog(@"Could not delete file -:%@ ",[error localizedDescription]);
            }
            
            deleteArrayupdate = [fileManage contentsOfDirectoryAtPath:imageFilePath error:&error];
            NSLog(@"deleteArrayupdate%@",deleteArrayupdate);
            [tempContents removeAllObjects];
            
            tempContents=deleteArrayupdate;
            
            NSLog(@"tempContentsdeleteArrayupdate%@",tempContents);
            
            
            NSLog(@" delete pressed");
            
            
        }
        
    }
    
    
    if((alertView.tag == 600)) {
        
        if (buttonIndex == 0) {
            
            
            NSString *Extension = [fileToSaveDelete lastPathComponent];
            NSString*didselectVideo=fileToSaveDelete;
            NSString*didSelectImage=fileToSaveDelete;
            
            
            UIAlertView *removeSuccessFulAlert=[[UIAlertView alloc]initWithTitle:@"" message:@"保存しました。" delegate:self cancelButtonTitle:@"閉じる" otherButtonTitles:nil];
            [removeSuccessFulAlert show];
            
            if ([[Extension pathExtension] isEqualToString:@"mp4"])
            {
                NSLog(@"Video seleceted");
                
                
                NSURL* url =[NSURL URLWithString:didselectVideo];
                
                ALAssetsLibrary* libraryvideo = [[ALAssetsLibrary alloc]init];
                if ([libraryvideo videoAtPathIsCompatibleWithSavedPhotosAlbum:url])
                {
                    NSURL *clipURl = url;
                    [libraryvideo writeVideoAtPathToSavedPhotosAlbum:clipURl completionBlock:^(NSURL *assetURL, NSError *error)
                     {
                         
                         if(assetURL) {
                             [libraryvideo assetForURL:assetURL resultBlock:^(ALAsset *asset) {
                                 [self addAsset:asset toGroup:@"MyVideoAlbum" inLib:libraryvideo];
                             } failureBlock:^(NSError *error) {
                                 NSLog(@"eror: %@", error);
                             }];
                         }
                         else {
                             NSLog(@"error: %@", error);
                         }
                         
                         
                     }];
                    
                }
                
                
                
            }
            else
            {
                NSLog(@"image seleceted");
                
                ALAssetsLibrary *lib = [[ALAssetsLibrary alloc] init];
                
                
                didselectImage=[UIImage imageWithContentsOfFile:didSelectImage];
                [lib writeImageToSavedPhotosAlbum:[didselectImage CGImage] orientation:ALAssetOrientationUp completionBlock:^(NSURL *assetURL, NSError *error) {
                    if(assetURL) {
                        [lib assetForURL:assetURL resultBlock:^(ALAsset *asset) {
                            [self addAsset:asset toGroup:@"MyCameraAlbum" inLib:lib];
                        } failureBlock:^(NSError *error) {
                            NSLog(@"eror: %@", error);
                        }];
                    }
                    else {
                        NSLog(@"error: %@", error);
                    }
                }];
                
            }
            
        }
        
    }
    
    
}



-(void)saveImage {
    
    UIAlertView *removeSuccessFulAlert=[[UIAlertView alloc]initWithTitle:@"" message:@"ファイルを保存してよろしいですか ?" delegate:self cancelButtonTitle:@"はい" otherButtonTitles:@"いいえ",nil];
    
    
    removeSuccessFulAlert.tag = 600;
    [removeSuccessFulAlert show];
    
    
}


- (void) addAsset:(ALAsset*)a toGroup:(NSString*)name inLib:(ALAssetsLibrary*)lib {
    [lib enumerateGroupsWithTypes:ALAssetsGroupAlbum usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if([[group valueForProperty:ALAssetsGroupPropertyName] isEqualToString:name]) {
            [group addAsset:a];
            *stop = YES;
            NSLog(@"added asset to EXISTING group");
        }
        if(!group) {
            [lib addAssetsGroupAlbumWithName:name resultBlock:^(ALAssetsGroup *group) {
                [group addAsset:a];
                NSLog(@"added asset to NEW group");
            } failureBlock:^(NSError *error) {
                NSLog(@"e: %@", error);
            }];
        }
    } failureBlock:^(NSError *error) {
        NSLog(@"e: %@", error);
    }];
}




@end
