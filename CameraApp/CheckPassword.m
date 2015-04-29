//
//  CheckPassword.m
//  CameraApp
//
//  Created by annutech on 2/20/15.
//  Copyright (c) 2015 annutech. All rights reserved.
//

#import "CheckPassword.h"
#define MAX_LENGTH 4
@interface CheckPassword ()

@end

@implementation CheckPassword
@synthesize checkPassword;
- (void)viewDidLoad {
    [super viewDidLoad];
    checkPassword.delegate = self;
    // Do any additional setup after loading the view.
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

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.text.length >= MAX_LENGTH && range.length == 0)
    {
        return NO; // return NO to not change text
    }
    else
    {return YES;}
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"Text field did begin editing");
}

// This method is called once we complete editing
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    NSString *checkpasscode = checkPassword.text;
    NSLog(@"Text field ended editing%@",checkpasscode);
    
    
}

// This method enables or disables the processing of return key
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    NSString *checkpasscode = checkPassword.text;
    NSLog(@"textFieldShouldReturn%@",checkpasscode);
    NSString *returnPasscode = [[NSUserDefaults standardUserDefaults] stringForKey:@"Passcode_key"];
    
NSLog(@"textFieldShouldReturn%@",returnPasscode);
    if ([checkpasscode isEqualToString:returnPasscode]) {
        
        
        //[self performSegueWithIdentifier:@"correctPasswordSegue" sender:self];
           
        
        
        [self dismissViewControllerAnimated:YES completion:^{
            
            [self.delegate passwordAuth:@"OK"];
            
        }];
        

    }
    
    else
    {
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@""
                            message:@"もう一度入力してください"
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        
        [message show];
    }
    
    return YES;
}



- (IBAction)cancelAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        [self.delegate passwordAuth:@"NO"];
        
    }];

}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
@end
