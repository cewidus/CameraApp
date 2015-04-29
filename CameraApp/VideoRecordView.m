//
//  VideoRecordView.m
//  CameraApp
//
//  Created by annutech on 2/23/15.
//  Copyright (c) 2015 annutech. All rights reserved.
//

#import "VideoRecordView.h"
#define AP_APPKEY @"FDOJ3AJ2JSWQ43UZ"
@interface VideoRecordView ()

@end

@implementation VideoRecordView
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [AMoAdSDK showAppliPromotionWall:self
                         orientation:UIInterfaceOrientationPortrait
                     wallDrawSetting:APSDK_Ad_Key_WallDrawSetting_hiddenStatusBar
                              appKey:AP_APPKEY
                    onWallCloseBlock:^{
                        
                        //[[Toast makeText:nil text:@"ウォールが閉じた" duration:TOAST_LENGTH_SHORT] show];
                    }];
    //   [ AMoAdSDK sendUUID ]
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
   // [super viewWillAppear:animated];
    
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
