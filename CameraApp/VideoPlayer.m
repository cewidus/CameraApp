//
//  VideoPlayer.m
//  Download
//
//  Created by Admin on 2/19/15.
//  Copyright (c) 2015 CWD. All rights reserved.
//
@import GoogleMobileAds;
#import "VideoPlayer.h"

@interface VideoPlayer ()
@property (weak, nonatomic) IBOutlet UIView *videoPlayerView;
@property (weak, nonatomic) IBOutlet UIButton *videoPlayPause;
- (IBAction)videoPlayPauseAction:(id)sender;

@end

@implementation VideoPlayer
@synthesize player;
@synthesize playerLayer;
@synthesize videoFileName,playbackState;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    fileManage = [NSFileManager defaultManager];
    NSError *error;
    imageFilePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/App_Camera_Media/"];
    
    tempContents = [fileManage contentsOfDirectoryAtPath:imageFilePath error:&error];
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didRotate:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
    
    NSUserDefaults *checkVideo = [NSUserDefaults standardUserDefaults];
    int valueinVideo =    [checkVideo integerForKey:@"StartVideoCont"];
    valueinVideo++;
    
    //[checkVideo setInteger:valueinVideo forKey:@"StartVideoCont"];
    [checkVideo synchronize];
    NSLog(@"value%d",valueinVideo);
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [self.view addGestureRecognizer:singleFingerTap];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemDidReachEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:[player currentItem]];

    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    

}


-(void)appActive:(NSNotification *)notification
{
    [player play];
}





- (void)playerItemDidReachEnd:(NSNotification *)notification {
    
    AVPlayerItem *p = [notification object];
    [p seekToTime:kCMTimeZero];
    [self pause];
    [self ShowControls];
    [self.videoPlayPause setImage:[UIImage imageNamed:@"playing_now.png"] forState:UIControlStateNormal];

    
}

-(void)viewDidAppear:(BOOL)animated
{
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appActive:)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
    
    
    
    
    NSURL *videoURL = [NSURL fileURLWithPath:videoFileName];
    
    NSLog(@"Video file path :%@", videoFileName);
    
    FilePath = videoFileName;
    
    
    
    
    CGFloat heigt = self.videoPlayerView.frame.size.height;
    CGFloat width = self.videoPlayerView.frame.size.width;
    
    
    player = [[AVPlayer alloc] initWithURL:videoURL];
    playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    playerLayer.frame = CGRectMake(0, 0, width,heigt);
    
    [self.videoPlayerView.layer addSublayer:playerLayer];
    
    
    
    //[player pause];
    [self pause ];
    
    
    [self.videoPlayerView bringSubviewToFront:self.videoPlayPause];
    [self.videoPlayPause setNeedsDisplay];
    
    
    
    
}


- (void)didRotate:(NSNotification *)notification
{
    
    UIDeviceOrientation  orientation = [[UIDevice currentDevice] orientation];
    if ((orientation == UIDeviceOrientationLandscapeLeft)||(orientation == UIDeviceOrientationLandscapeRight))
    {
        CGFloat heigt= self.videoPlayerView.frame.size.height;
        CGFloat width=self.videoPlayerView.frame.size.width;
        
        
        playerLayer.frame = CGRectMake(0, 0, width,heigt);
        [self.videoPlayerView.layer addSublayer:playerLayer];
        
        
    }
    if((orientation == UIDeviceOrientationPortrait)||(orientation == UIDeviceOrientationPortraitUpsideDown))
    {
        
        CGFloat heigt= self.videoPlayerView.frame.size.height;
        CGFloat width=self.videoPlayerView.frame.size.width;
        
        NSLog(@"height:%f :%f", width,heigt);
        playerLayer.frame = CGRectMake(0, 0, width,heigt);
        [self.videoPlayerView.layer addSublayer:playerLayer];
        
        
    }
    
    
    
    
    [self.videoPlayerView bringSubviewToFront:self.videoPlayPause];
    [self.videoPlayPause setNeedsDisplay];
    
    
}

- (void)handleSingleTap:(id)sender
{
    [self ShowControls];
    [self startHideControlsTimer];
    
    
}





- (void)ShowControls
{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.05];
    self.videoPlayPause.alpha = 1.0f;
    [self.videoPlayerView bringSubviewToFront:self.videoPlayPause];
    [self.videoPlayPause setNeedsDisplay];
    
    [UIView commitAnimations];
    
}

- (void)HideControls
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    
    self.videoPlayPause.alpha = 0.0f;
    
    
    [UIView commitAnimations];
}

- (void)turnOffHideControlsTimer
{
    
    if ([hideControlsTimer isValid])
        [hideControlsTimer invalidate];
    hideControlsTimer = nil;
    
}
- (void)startHideControlsTimer
{
    if (hideControlsTimer != nil && [hideControlsTimer isValid])	{
        [hideControlsTimer
         setFireDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    }
    else {
        hideControlsTimer =
        [NSTimer scheduledTimerWithTimeInterval:1 target:
         self selector:@selector(hideControlsTimerDidFire:)
                                       userInfo:nil repeats:NO];
    }
}
- (void)hideControlsTimerDidFire:(NSTimer *)aTimer
{
    [self HideControls];
}



- (IBAction)saveVideo:(id)sender {
    
    
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





-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    
    
    
    DeleteSaveView *deleteSaveViewController = segue.destinationViewController;
    if([segue.identifier isEqualToString:@"saveVideoSegue"])
    {
        deleteSaveViewController.videoFileName = videoFileName;
    }
    
}

- (IBAction)unwindvideoView:(UIStoryboardSegue *)segue
{
    // [self performSegueWithIdentifier:@"unwindTopView" sender:self];
    
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




- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    if (alertView.tag == 100) { // h
        
        if (buttonIndex == 0) {
            
            
            
            NSError *error;
            
            BOOL success = [fileManage removeItemAtPath:FilePath error:&error];
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
            
            
            NSString *Extension = [FilePath lastPathComponent];
            NSString*didselectVideo=FilePath;
            NSString*didSelectImage=FilePath;
            
            
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


- (void)play {
    [player play];
    self.playbackState = MPMusicPlaybackStatePlaying;
    
    
}
- (void)pause {
    [player pause];
    self.playbackState = MPMusicPlaybackStatePaused;
    
}


    
    


- (IBAction)videoPlayPauseAction:(id)sender {
    
    if (self.playbackState == MPMusicPlaybackStatePaused) {
        [self play];
        self.playbackState = MPMusicPlaybackStatePlaying;
        
        [self.videoPlayPause setImage:nil forState:UIControlStateNormal];
        
        [self.videoPlayPause setImage:[UIImage imageNamed:@"icon_pause.png"] forState:UIControlStateNormal];
        
        [self startHideControlsTimer];
        
    }
    else{
        [self pause];
        self.playbackState=MPMusicPlaybackStatePaused;
        
        [self.videoPlayPause setImage:nil forState:UIControlStateNormal];
        
        [self.videoPlayPause setImage:[UIImage imageNamed:@"playing_now.png"] forState:UIControlStateNormal];
        //[self ShowControls];
    }
    

}
@end
