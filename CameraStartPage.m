//
//  CameraStartPage.m
//  CameraApp
//
//  Created by annutech on 3/3/15.
//  Copyright (c) 2015 annutech. All rights reserved.
//

#import "CameraStartPage.h"
#define MAX_LENGTH 150
@interface CameraStartPage ()
@property (weak, nonatomic) IBOutlet UITextField *cameraStartpage;

@end

@implementation CameraStartPage
@synthesize cameraStartpage;
- (void)viewDidLoad {
    [super viewDidLoad];
    cameraStartpage.delegate = self;
    
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
        return NO; 
    }
    else
    {return YES;}
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"Text field did begin editing");
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    NSString *checkpasscode = cameraStartpage.text;
    NSLog(@"Text field ended editing%@",checkpasscode);
    
}


-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    NSString *checkpasscode = cameraStartpage.text;
    NSLog(@"textFieldShouldReturn%@",checkpasscode);
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject: checkpasscode forKey:@"startPage"];
    [defaults synchronize];
    
    return YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    
   
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *cameraStartPageUrl =    [defaults objectForKey:@"startPage"];
    
    if(cameraStartPageUrl==nil)
    {
        
        
        [self.cameraStartpage setText:@"http://m.yahoo.co.jp"];
        //[(UITextField *)[self.view viewWithTag:2] setText:@"http://m.yahoo.co.jp"];
        
    }
    else
    {
        
       // [(UITextField *)[self.view viewWithTag:2] setText:getUrl];
        [self.cameraStartpage setText:cameraStartPageUrl];
    }
    

     [self.cameraStartpage becomeFirstResponder];
    
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}



@end
