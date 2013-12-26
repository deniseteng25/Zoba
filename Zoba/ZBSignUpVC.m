//
//  ZBSignUpVC.m
//  Zoba
//
//  Created by Chantil on 2013/12/22.
//  Copyright (c) 2013年 tw.edu.nccu. All rights reserved.
//

#import "ZBSignUpVC.h"
#import <Parse/Parse.h>

@interface ZBSignUpVC ()

@end

@implementation ZBSignUpVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    _accountTF.delegate = self;
    _passwordTF.delegate = self;
    _nicknameTF.delegate = self;
    _emailTF.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)enterClicked:(id)sender
{
//    NSString *errMsg = nil;
//    if ([_accountTF.text isEqualToString:@""])
//        errMsg = @"Please Fill Your Account";
//    else if ([_passwordTF.text isEqualToString:@""])
//        errMsg = @"Please Fill Your Password";
//    else if([_nicknameTF.text isEqualToString:@""])
//        errMsg = @"Please Fill Your Nickname";
//    else if([_emailTF.text isEqualToString:@""])
//        errMsg = @"Please Fill Your Email";
    
    PFUser *user = [PFUser user];
    user.username = _accountTF.text;
    user.password = _passwordTF.text;
    user.email = _emailTF.text;
    
    // other fields can be set just like with PFObject
    user[@"nickname"] = _nicknameTF.text;
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error) {
            NSString *errorString = [error userInfo][@"error"];
            // Show the errorString somewhere and let the user try again.
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops"
                                                            message:errorString
                                                           delegate:self
                                                  cancelButtonTitle:@"ok"
                                                  otherButtonTitles:nil];
            [alert show];
        } else if ([_nicknameTF.text isEqualToString:@""]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops"
                                                            message:@"nickname can't be empty"
                                                           delegate:self
                                                  cancelButtonTitle:@"ok"
                                                  otherButtonTitles:nil];
            [alert show];
        } else {
            // Hooray! Let them use the app now.
            id nextView = [self.storyboard instantiateViewControllerWithIdentifier:@"MainView"];
            [self presentViewController:nextView animated:YES completion:nil];
        }
    }];
//
//    if (!errMsg) {
//        PFUser *user = [PFUser user];
//        user.username = _accountTF.text;
//        user.password = _passwordTF.text;
//        user.email = _emailTF.text;
//        
//        // other fields can be set just like with PFObject
//        user[@"nickname"] = _nicknameTF.text;
//        
//        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//            if (!error) {
//                // Hooray! Let them use the app now.
//                id nextView = [self.storyboard instantiateViewControllerWithIdentifier:@"MainView"];
//                [self presentViewController:nextView animated:YES completion:nil];
//            } else {
//                NSString *errorString = [error userInfo][@"error"];
//                // Show the errorString somewhere and let the user try again.
//                NSLog(@"%@", errorString);
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops"
//                                                                message:errorString
//                                                               delegate:self
//                                                      cancelButtonTitle:@"ok"
//                                                      otherButtonTitles:nil];
//                [alert show];
//            }
//        }];
//    } else {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops"
//                                                       message:errMsg
//                                                      delegate:self
//                                             cancelButtonTitle:@"ok"
//                                             otherButtonTitles:nil];
//        [alert show];
//    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end
