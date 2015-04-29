//
//  ViewController.m
//  testing
//
//  Created by annutech on 4/4/15.
//  Copyright (c) 2015 annutech. All rights reserved.
//

#import "Viewtest.h"
#define AP_APPKEY @"FDOJ3AJ2JSWQ43UZ"
@interface Viewtest ()
- (IBAction)walladAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *wall;

@end

@implementation Viewtest

- (void)viewDidLoad {
    [super viewDidLoad];
    //Do any additional setup after loading the view, typically from a nib.
    
    [AMoAdSDK showAppliPromotionWall:self
                         orientation:UIInterfaceOrientationPortrait
                     wallDrawSetting:APSDK_Ad_Key_WallDrawSetting_hiddenStatusBar
                              appKey:AP_APPKEY
                    onWallCloseBlock:^{
                        
                        //[[Toast makeText:nil text:@"ウォールが閉じた" duration:TOAST_LENGTH_SHORT] show];
                    }];
    [ AMoAdSDK sendUUID ] ;
     
     
    
  // [self.wall sendActionsForControlEvents:UIControlEventTouchUpInside];
    
      // [self.wall sendActionsForControlEvents:UIControlEventTouchUpInside];
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)showAds:(NSTimer *)timer {
    NSLog(@"ping");
    
    dispatch_async(dispatch_get_main_queue(), ^{
       // [self.wall sendActionsForControlEvents:UIControlEventTouchUpInside];
        
        
   
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
        
        
         });
    
    
}


- (IBAction)walladAction:(id)sender {
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


}
@end
