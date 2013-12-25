//
//  ZBSignInVC.m
//  Zoba
//
//  Created by Chantil on 2013/12/22.
//  Copyright (c) 2013年 tw.edu.nccu. All rights reserved.
//

#import "ZBSignInVC.h"
#import <Parse/Parse.h>

@interface ZBSignInVC ()

@end

@implementation ZBSignInVC

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // Set Delegate
    _accountTF.delegate = self;
    _passwordTF.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginClicked:(id)sender
{
    [PFUser logInWithUsernameInBackground:_accountTF.text
                                 password:_passwordTF.text
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            // Do stuff after successful login.
                                            id nextView = [self.storyboard instantiateViewControllerWithIdentifier:@"MainView"];
                                            [self presentViewController:nextView animated:YES completion:nil];
                                        } else {
                                            // The login failed. Check error to see why.
                                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops"
                                                                                            message:@"Please Check Your Account or Password"
                                                                                           delegate:self
                                                                                  cancelButtonTitle:@"ok"
                                                                                  otherButtonTitles:nil];
                                            [alert show];
                                        }
                                    }];
}

- (IBAction)signUpClicked:(id)sender
{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
