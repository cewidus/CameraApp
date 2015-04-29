//
//  DeleteSaveView.m
//  CameraApp
//
//  Created by annutech on 3/9/15.
//  Copyright (c) 2015 annutech. All rights reserved.
//
@import GoogleMobileAds;
#import "DeleteSaveView.h"

@interface DeleteSaveView ()

@end

@implementation DeleteSaveView
@synthesize videoFileName;

- (void)viewDidLoad {
    [super viewDidLoad];
    fileManage = [NSFileManager defaultManager];
    NSError *error;
    imageFilePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/App_Camera_Media/"];
    
    tempContents = [fileManage contentsOfDirectoryAtPath:imageFilePath error:&error];
    // Do any additional setup after loading the view.
    FilePath=videoFileName;
    NSLog(@"FilePath from album%@",FilePath);
    
    NSLocale *currentLocale = [NSLocale currentLocale];  // get the current locale.
    NSString *countryCode = [currentLocale objectForKey:NSLocaleCountryCode];
    
    NSLog(@"Country name: %@", countryCode);
    
    if([countryCode isEqualToString:@"JP"])
        
    {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            
            
            self.nadView = [[NADView alloc] initWithFrame:CGRectMake(0, 0, 640, 100)];
          //  self.nadView.backgroundColor=[UIColor redColor];
            // (3) ログ出力の指定
            [self.nadView setIsOutputLog:NO];
            // (4) set apiKey, spotId.
            [self.nadView setNendID:@"ff3b8fb73c93024965a056b69586f70e7549875e" spotID:@"331715"];
            [self.nadView setDelegate:self]; //(5) [self.nadView load]; //(6)
            
            
            //  self.nadView.rootViewController = self;
            [self.nadView load];
            [self.nadView load:[NSDictionary dictionaryWithObjectsAndKeys: @"30", @"retry", nil]];
            
            [self.globalAdview addSubview:self.nadView];
            
            
        }else {
            
            self.nadView = [[NADView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
          //  self.nadView.backgroundColor=[UIColor redColor];
            // (3) ログ出力の指定
            [self.nadView setIsOutputLog:NO];
            // (4) set apiKey, spotId.
            [self.nadView setNendID:@"6f85b652b918c80d172b2885e87a080bbde82485" spotID:@"303106"];

            //[self.nadView setNendID:@"b097482f34990311a95fa70fd2bbc6706b462815" spotID:@"329432"];
            [self.nadView setDelegate:self]; //(5) [self.nadView load]; //(6)
            
            
            //  self.nadView.rootViewController = self;
            [self.nadView load];
            [self.nadView load:[NSDictionary dictionaryWithObjectsAndKeys: @"30", @"retry", nil]];
            
            [self.globalAdview addSubview:self.nadView];
            
        }
        
        
        
    }
    
    else
    {
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            self.bannerView = [[GADBannerView alloc] initWithFrame:CGRectMake(0, 0, 640, 100)];
        }
        else {
            
            self.bannerView = [[GADBannerView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
            
        }
        
        
        self.bannerView.adUnitID=@"ca-app-pub-8337981281366372/9173798446";

        //self.bannerView.adUnitID=@"ca-app-pub-9874128266588393/9628943069";
        self.bannerView.rootViewController = self;
        
        GADRequest *request = [GADRequest request];
        // Requests test ads on devices you specify. Your test device ID is printed to the console when
        // an ad request is made. GADBannerView automatically returns test ads when running on a
        
        /// simulator.
        /*request.testDevices = @[
         @"2077ef9a63d2b398840261c8221a0c9a"  // Eric's iPod Touch
         ];
         */
        request.testDevices =  @[ @"579e4349dc5e247230bda1b65f70f16c" ];
        [self.bannerView loadRequest:request];
        [self.globalAdview addSubview:self.bannerView];
        
        
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)deleteAction:(id)sender {
    
   
    
    
    

UIAlertView *removeSuccessFulAlert=[[UIAlertView alloc]initWithTitle:@"" message:@"ファイルを削除してよろしいですか？" delegate:self cancelButtonTitle:@"はい" otherButtonTitles:@"いいえ",nil];
    
        removeSuccessFulAlert.tag = 100;
        [removeSuccessFulAlert show];
   
    
    
    
    
    
    /*
    
    NSError *error;
    
        BOOL success = [fileManage removeItemAtPath:FilePath error:&error];
        if (success) {
            UIAlertView *removeSuccessFulAlert=[[UIAlertView alloc]initWithTitle:@"" message:@" 削除" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes",nil];
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
    
    */
        
    
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



- (IBAction)saveAction:(id)sender {
    
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


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
