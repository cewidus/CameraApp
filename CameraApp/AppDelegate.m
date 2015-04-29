//
//  AppDelegate.m
//  CameraApp
//
//  Created by annutech on 2/10/15.
//  Copyright (c) 2015 annutech. All rights reserved.
//
@import GoogleMobileAds;

#import "AppDelegate.h"
#import "GAI.h"
#import <Parse/Parse.h>

//#import "ImobileSdkAdsProperty.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    
    
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    [GAI sharedInstance].dispatchInterval = 10;
    [[[GAI sharedInstance] logger] setLogLevel:kGAILogLevelVerbose];
    
    //id<GAITracker> tracker = [[GAI sharedInstance] trackerWithTrackingId:@"UA-60240123-1"];
    id<GAITracker> tracker = [[GAI sharedInstance] trackerWithTrackingId:@"UA-48787767-4"];
    
    
     tracker.allowIDFACollection = YES;
    [GAI sharedInstance].defaultTracker=tracker;
   
    
    NSUserDefaults *checkDefault = [NSUserDefaults standardUserDefaults];
    int value =    [checkDefault integerForKey:@"StartAppCont"];
    value++;
    
    [checkDefault setInteger:value forKey:@"StartAppCont"];
    [checkDefault synchronize];
    NSLog(@"value%d",value);
    
    
    
    
   /*
   
    [Parse setApplicationId:@"kpEh5GKcAbog8Q5beF8yDGIqnruL2BWwoi9mCGm5"
                  clientKey:@"eHuNZVeNkO4IJpbanwLahwmfzXIaZVAhP6pXVj4z"];
    
    */
    
    [Parse setApplicationId:@"jqPWgMQxA2sJ0TPylVYkPYcCkRmu4oOeHRmb9s5y"
                  clientKey:@"4b7Zcs9RfmyYnyl5fuFMSzRCpo96dUVKRCEl0OXK"];
    
    
    
    
    
    UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert |
                                                    UIUserNotificationTypeBadge |
                                                    UIUserNotificationTypeSound);
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes
                                                                             categories:nil];
    [application registerUserNotificationSettings:settings];
    [application registerForRemoteNotifications];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"TestNotification" object:self];
    

    
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    currentInstallation.channels = @[@"global"];
    [currentInstallation saveInBackground];
    
    
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    if (error.code == 3010) {
        NSLog(@"Push notifications are not supported in the iOS Simulator.");
    } else {
        // show some alert or otherwise handle the failure to register.
        NSLog(@"application:didFailToRegisterForRemoteNotificationsWithError: %@", error);
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    
    [PFPush handlePush:userInfo];
    
    /*
    NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
                          messageContent, @”alert”,
                          @”Increment”, @”badge”,
                          nil];
    PFPush *push = [[PFPush alloc] init];
    [push setChannel:chatRoomName];
    [push setData:data];
    [push sendPushInBackground];
    */
    
    
    NSDictionary *data = @{
                           @"alert" : @"",
                           @"badge" : @"Increment",
                           @"sounds" : @"cheering.caf"
                           };
    PFPush *push = [[PFPush alloc] init];
    [push setChannels:@[ @"Mets" ]];
    [push setData:data];
    [push sendPushInBackground];
    
    
}



- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    
    
    
    NSUserDefaults *checkDefault = [NSUserDefaults standardUserDefaults];
    int value =    [checkDefault integerForKey:@"BackAppCont"];
    value++;
    
    [checkDefault setInteger:value forKey:@"BackAppCont"];
    [checkDefault synchronize];
    NSLog(@"value%d",value);
    
    
    
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    NSUserDefaults *checkDefault = [NSUserDefaults standardUserDefaults];
    int value =    [checkDefault integerForKey:@"StartAppCont"];
    value++;
    
    [checkDefault setInteger:value forKey:@"StartAppCont"];
    [checkDefault synchronize];
    NSLog(@"value%d",value);
    
    
    
    /*
    [checkDefault setBool:TRUE forKey:@"isAppStart"];
    [checkDefault synchronize];
    NSLog(@"value%d",value);
    */
    [[NSNotificationCenter defaultCenter] postNotificationName:@"appplicationIsActive" object:self];

    
    
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    if (currentInstallation.badge != 0) {
        currentInstallation.badge = 0;
        [currentInstallation saveEventually];
    }
    
    
    
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



@end
