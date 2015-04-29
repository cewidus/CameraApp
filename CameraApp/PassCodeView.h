//
//  PassCodeView.h
//  CameraApp
//
//  Created by annutech on 2/20/15.
//  Copyright (c) 2015 annutech. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PasswordSetDelegate

-(void)passwordSet:(NSString *)result;


@end

@interface PassCodeView : UIViewController<UITextFieldDelegate>

{

    BOOL passcodeOnOFF;
    NSString*firstChecked;
    __weak id <PasswordSetDelegate> delegate;
    
    
   
}
@property (weak, nonatomic) IBOutlet UITextField *passCodetextfield;
@property (nonatomic) BOOL passcodeOnOFF;



@property (nonatomic, weak) id <PasswordSetDelegate> delegate;


@end
