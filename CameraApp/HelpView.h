//
//  HelpView.h
//  CameraApp
//
//  Created by annutech on 2/11/15.
//  Copyright (c) 2015 annutech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckPassword.h"
#import "NADView.h"
#import "PasscodeLockScreen.h"
@class GADBannerView;

@interface HelpView : UIViewController<PasswordDelegate,NADViewDelegate,PassCodeDelegate,GADBannerViewDelegate>
{
    NSString * passwordCheckSegue;

     GADBannerView * bannerView;

}

@property (weak, nonatomic) IBOutlet GADBannerView *globalAdview;

@property (nonatomic, retain) NADView * nadView;

@property (nonatomic, retain) GADBannerView * bannerView;


@end
