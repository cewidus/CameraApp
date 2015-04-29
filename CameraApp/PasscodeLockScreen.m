//
//  PasscodeLockScreen.m
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
#import "PasscodeLockScreen.h"

@interface PasscodeLockScreen ()

@end

@implementation PasscodeLockScreen
@synthesize isCheckPassword;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"Passcode Screen"];
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
    [tracker set:kGAIScreenName value:nil];
    
    password = nil;
    passcode1 = 0;
    passcode2 = 0;
    passcode3 = 0;
    passcode4 = 0;
    
    passodeCount = 0;
    passwordCheckCount = 0;
    
    self.onceAgainText.hidden = TRUE;
    // Do any additional setup after loading the view.
    
    NSLog(@"istest : %d", self.isCheckPassword ?  YES : NO);
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (IBAction)buttonOneAction:(id)sender {
    
    [self upadtePasscode:1 ];
}

- (IBAction)buttonTwoAction:(id)sender {
    
    [self upadtePasscode:2 ];
}

- (IBAction)buttonThreeAction:(id)sender {
    
    [self upadtePasscode:3];
}

- (IBAction)buttonFourAction:(id)sender {
    
    [self upadtePasscode:4 ];
}

- (IBAction)buttonFiveAction:(id)sender {
    
    [self upadtePasscode:5 ];
}

- (IBAction)buttonSixAction:(id)sender {
    
    [self upadtePasscode:6];
}

- (IBAction)buttonSevenAction:(id)sender {
    
    [self upadtePasscode:7];
}

- (IBAction)buttonEightAction:(id)sender {
    
    [self upadtePasscode:8];
}

- (IBAction)buttonNineAction:(id)sender {
    
    [self upadtePasscode:9];
}

- (IBAction)buttonZeroAction:(id)sender {
    
   [self upadtePasscode:0];
}

- (IBAction)buttonClearAction:(id)sender {
    
    //password = nil;
    
   // passodeCount--;
    
    if(passodeCount  > 0)    {
    
    [self removePasscode:passodeCount];
        
    }
    
}


-(void)upadtePasscode:(int)passcode
{


    switch(passodeCount)    {
    
        case 0:
            passcode1 = passcode;
            self.passwordOne.image = [UIImage imageNamed:@"indicator_b.png"];
            
            
            
            break;
            
        case 1:
            
            passcode2 = passcode;
            
            self.passwordTwo.image = [UIImage imageNamed:@"indicator_b.png"];

            break;
            
        case 2:
            passcode3 = passcode;
            
            self.passwordThree.image = [UIImage imageNamed:@"indicator_b.png"];

            break;
            
        case 3:
            
            passcode4 = passcode;
            
            self.passwordFoure.image = [UIImage imageNamed:@"indicator_b.png"];

            break;
            
            
    
    }
    
    passodeCount++;
    
    
    
    if(passodeCount == 4)
    {
        
        password = [NSString stringWithFormat:@"%d%d%d%d", passcode1, passcode2,passcode3,passcode4];
        
        NSLog(@"User entered password: %@", password);
        if(self.isCheckPassword == FALSE) {
            
            passwordCheckCount++;
        
            
            if (passwordCheckCount == 1) {
            
                fistPassword = password;
                self.onceAgainText.hidden = FALSE;
                
                passodeCount = 0;
                
                self.passwordOne.image = [UIImage imageNamed:@"indicator_a.png"];
                self.passwordTwo.image = [UIImage imageNamed:@"indicator_a.png"];
                self.passwordThree.image = [UIImage imageNamed:@"indicator_a.png"];
                self.passwordFoure.image = [UIImage imageNamed:@"indicator_a.png"];
                
                
                
        
            }
            else if (passwordCheckCount == 2) {
                
                if([fistPassword isEqualToString:password]) {
                    
                    passwordCheckCount = 0;
                    self.onceAgainText.hidden = TRUE;
                    
                    
                
                    [self dismissViewControllerAnimated:YES completion:^{
                        
                        [self.delegate SetPasscode:password];
                        
                    }];
                    
                    
                    
                    //[self.navigationController popViewControllerAnimated:YES];
                    
                
                }
                else {
                    
                    passwordCheckCount = 0;
                    passodeCount = 0;
                    self.passwordOne.image = [UIImage imageNamed:@"indicator_a.png"];
                    self.passwordTwo.image = [UIImage imageNamed:@"indicator_a.png"];
                    self.passwordThree.image = [UIImage imageNamed:@"indicator_a.png"];
                    self.passwordFoure.image = [UIImage imageNamed:@"indicator_a.png"];
                    self.onceAgainText.hidden = TRUE;
                
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                                    message:@"再度お試しください"
                                                                   delegate:self
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil, nil];
                    [alert show];

                
                }
            }
            
        
        
    }
        
        
    
    else {
    
    
        NSString *savePasscode = [[NSUserDefaults standardUserDefaults] stringForKey:@"Passcode_key"];
        
        NSLog(@"new passcode:%@ old password: %@",password, savePasscode);
        
        
        if ([savePasscode isEqualToString:password]) {
            
            
            [self dismissViewControllerAnimated:YES completion:^{
                
                [self.delegate SetPasscode:password];
                
            }];
            
            
            
            //[self.navigationController popViewControllerAnimated:YES];

        
        
        }
        else {
            
            passodeCount = 0;
            self.passwordOne.image = [UIImage imageNamed:@"indicator_a.png"];
            self.passwordTwo.image = [UIImage imageNamed:@"indicator_a.png"];
            self.passwordThree.image = [UIImage imageNamed:@"indicator_a.png"];
            self.passwordFoure.image = [UIImage imageNamed:@"indicator_a.png"];
        
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                            message:@"再度お試しください"
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil, nil];
            [alert show];
        
        
        }
    
    
        
        
        
    
    }
        
        }

}


-(void)removePasscode:(int)passcode
{
    
    
    
    switch(passodeCount)    {
            
        case 1:
            //passcode1 = passcode;
            self.passwordOne.image = [UIImage imageNamed:@"indicator_a.png"];
            
            
            break;
            
        case 2:
            
            //passcode2 = passcode;
            
            self.passwordTwo.image = [UIImage imageNamed:@"indicator_a.png"];
            
            break;
            
        case 3:
            //passcode3 = passcode;
            
            self.passwordThree.image = [UIImage imageNamed:@"indicator_a.png"];
            
            break;
            
        case 4:
            
            //passcode4 = passcode;
            
            self.passwordFoure.image = [UIImage imageNamed:@"indicator_a.png"];
            
            break;
            
            
            
    }
    
    passodeCount--;
    
}

- (IBAction)backButtonAction:(id)sender {
    
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        //[self.delegate SetPasscode:password];
        
    }];
    
}
@end
