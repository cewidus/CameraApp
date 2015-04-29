//
//  HelpWebView.m
//  CameraApp
//
//  Created by annutech on 2/11/15.
//  Copyright (c) 2015 annutech. All rights reserved.
//

#import "HelpWebView.h"

@interface HelpWebView ()
@property (weak, nonatomic) IBOutlet UIWebView *helpwebview;

@end

@implementation HelpWebView

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString * urlString = @"http://support.apple.com/en-us/HT203040";
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.helpwebview loadRequest:urlRequest];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
