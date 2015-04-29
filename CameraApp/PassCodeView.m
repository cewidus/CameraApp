//
//  PassCodeView.m
//  CameraApp
//
//  Created by annutech on 2/20/15.
//  Copyright (c) 2015 annutech. All rights reserved.
//


#import "PassCodeView.h"
#define MAX_LENGTH 4

@interface PassCodeView ()

{
 int counter;
}
- (IBAction)cancelButtonAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *retypeText;

@end

@implementation PassCodeView
@synthesize passCodetextfield;

- (void)viewDidLoad {
    [super viewDidLoad];
    passCodetextfield.delegate = self;
    self.retypeText.hidden=TRUE;
    counter=0;
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


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
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"入力エラー"
                                                    message:@"4文字のパスコードを入力してください"
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil, nil];
    
    [alert show];
    
    if(textField.text.length==MAX_LENGTH)
    {
        
    }
    

    NSLog(@"Text field did begin editing");
}
/*
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    NSLog(@"textFieldShouldEndEditing");
    textField.backgroundColor = [UIColor redColor];
    return YES;
}
*/
// This method is called once we complete editing
-(void)textFieldDidEndEditing:(UITextField *)textField{
   
   // NSString*firstChecked;
    
    
    counter++;
    if(counter==1)
    {
        
        
        if(textField.text.length==MAX_LENGTH)
        {
            firstChecked = passCodetextfield.text;
        
            self.retypeText.hidden=FALSE;
            passCodetextfield.text=@"";
            
            [self.passCodetextfield becomeFirstResponder];
            
        }
        
        NSLog(@"passCodetextfield.text%@",firstChecked);
        
      }
    
    
    if(counter==2)
    {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if(textField.text.length==MAX_LENGTH)
    {
       // NSUserDefaults *flagFOrcheck = [NSUserDefaults standardUserDefaults];
       // [flagFOrcheck setInteger:1 forKey:@"flagFOrcheck"];
        //[flagFOrcheck synchronize];
        NSString*secondCheck=passCodetextfield.text;
        NSLog(@"first check%@",firstChecked);
        NSLog(@"secondCheck%@",secondCheck);

        if([firstChecked isEqualToString:secondCheck] == YES)
        {
        
     
            NSString *passcode = passCodetextfield.text;
            NSLog(@"Text field ended editing%@",passcode);
            [defaults setObject: passcode forKey:@"Passcode_key"];
            [defaults synchronize];
        }
        
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                            message:@"再度お試しください"
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil, nil];
            [alert show];
            
            counter=0;
             passCodetextfield.text=@"";
            self.retypeText.hidden=TRUE;
             [self.passCodetextfield becomeFirstResponder];
            
        }
    }
        
       
   else if(textField.text.length<MAX_LENGTH)
    {
      
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:FALSE forKey:@"isPasscodeOn"];
        [defaults synchronize];
    }
       
    
    }
}

// This method enables or disables the processing of return key
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    NSString *returnPasscode = [[NSUserDefaults standardUserDefaults] stringForKey:@"Passcode_key"];
    
      NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    Boolean islogin =    [defaults boolForKey:@"isPasscodeOn"];
    NSLog(@"login:%d", islogin);
    NSLog(@"TtextFieldShouldReturn%@",returnPasscode);
   // NSLog(@"switchcase%d",SwitchOn);

    //[self performSegueWithIdentifier:@"backTosegue" sender:self];

    if (counter==2) {
        [self dismissViewControllerAnimated:YES completion:^{
            
            [self.delegate passwordSet:@"OK"];
             counter=0;
            
        }];
        
    }
   
    
    
    
    return YES;
}



- (IBAction)cancelButtonAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        [self.delegate passwordSet:@"NO"];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:FALSE forKey:@"isPasscodeOn"];
        [defaults synchronize];
        
    }];

}
@end
