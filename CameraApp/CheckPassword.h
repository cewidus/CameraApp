//
//  CheckPassword.h
//  CameraApp
//
//  Created by annutech on 2/20/15.
//  Copyright (c) 2015 annutech. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PasswordDelegate

-(void)passwordAuth:(NSString *)result;


@end


@interface CheckPassword : UIViewController<UITextFieldDelegate> {


    __weak id <PasswordDelegate> delegate;

}
@property (weak, nonatomic) IBOutlet UITextField *checkPassword;
- (IBAction)cancelAction:(id)sender;

@property (nonatomic, weak) id <PasswordDelegate> delegate;


@end
