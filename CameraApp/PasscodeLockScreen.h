//
//  PasscodeLockScreen.h
//  CameraApp
//
//  Created by Admin on 4/7/15.
//  Copyright (c) 2015 annutech. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PassCodeDelegate

-(void)SetPasscode:(NSString *)result;

//-(void)AuthPasscode:(NSString *)result;


@end

@interface PasscodeLockScreen : UIViewController
{

    NSString *password;
    
    int passcode1;
    int passcode2;
    int passcode3;
    int passcode4;
    
    int passodeCount;
    __weak id <PassCodeDelegate> delegate;
    
    int passwordCheckCount;
    
    BOOL isCheckPassword;
    NSString *fistPassword;



}

@property BOOL isCheckPassword;

@property (nonatomic, weak) id <PassCodeDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIButton *buttonOne;
@property (weak, nonatomic) IBOutlet UIButton *buttonTwo;
@property (weak, nonatomic) IBOutlet UIButton *buttonThree;
@property (weak, nonatomic) IBOutlet UIButton *buttonFour;
@property (weak, nonatomic) IBOutlet UIButton *buttonFive;
@property (weak, nonatomic) IBOutlet UIButton *buttonSix;
@property (weak, nonatomic) IBOutlet UIButton *buttonSeven;
@property (weak, nonatomic) IBOutlet UIButton *buttonEight;
@property (weak, nonatomic) IBOutlet UIButton *buttonNine;
@property (weak, nonatomic) IBOutlet UIButton *buttonZero;
@property (weak, nonatomic) IBOutlet UIButton *buttonClear;
@property (weak, nonatomic) IBOutlet UIImageView *passwordOne;
@property (weak, nonatomic) IBOutlet UIImageView *passwordTwo;
@property (weak, nonatomic) IBOutlet UIImageView *passwordThree;
@property (weak, nonatomic) IBOutlet UIImageView *passwordFoure;

- (IBAction)buttonOneAction:(id)sender;
- (IBAction)buttonTwoAction:(id)sender;
- (IBAction)buttonThreeAction:(id)sender;
- (IBAction)buttonFourAction:(id)sender;
- (IBAction)buttonFiveAction:(id)sender;
- (IBAction)buttonSixAction:(id)sender;
- (IBAction)buttonSevenAction:(id)sender;
- (IBAction)buttonEightAction:(id)sender;
- (IBAction)buttonNineAction:(id)sender;
- (IBAction)buttonZeroAction:(id)sender;
- (IBAction)buttonClearAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *onceAgainText;
- (IBAction)backButtonAction:(id)sender;

@end
