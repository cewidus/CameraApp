//
//  ShadowHelp.m
//  CameraApp
//
//  Created by Admin on 4/7/15.
//  Copyright (c) 2015 annutech. All rights reserved.
//

#import "ShadowHelp.h"
#import "GAI.h"
#import <Parse/Parse.h>
#import "GAIDictionaryBuilder.h"
#import "GAI.h"
#import "GAIFields.h"
#import "GAITracker.h"
@interface ShadowHelp ()

@end

@implementation ShadowHelp

- (void)viewDidLoad {
    [super viewDidLoad];
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"Shadow HelpView"];
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
    [tracker set:kGAIScreenName value:nil];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
