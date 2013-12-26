//
//  ZBSignInVC.h
//  Zoba
//
//  Created by Chantil on 2013/12/22.
//  Copyright (c) 2013年 tw.edu.nccu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZBSignInVC : UIViewController <UITextFieldDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UITextField *accountTF;
@property (strong, nonatomic) IBOutlet UITextField *passwordTF;

- (IBAction)loginClicked:(id)sender;
- (IBAction)signUpClicked:(id)sender;
- (IBAction)forgetPWClicked:(id)sender;

@end
