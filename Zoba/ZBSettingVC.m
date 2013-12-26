//
//  ZBSettingVC.m
//  Zoba
//
//  Created by Chantil on 2013/12/22.
//  Copyright (c) 2013年 tw.edu.nccu. All rights reserved.
//

#import "ZBSettingVC.h"
#import <Parse/Parse.h>

@interface ZBSettingVC ()
{
    PFUser *currentUser;
}
@end

@implementation ZBSettingVC

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
    _nicknameTF.delegate = self;
    _orinPWTF.delegate = self;
    _otherPWTF.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    currentUser = [PFUser currentUser];
    if (currentUser) {
        // do stuff with the user
        _accountTF.text = currentUser.username;
        _nicknameTF.text = currentUser[@"nickname"];
    } else {
        // show the signup or login screen
        NSLog(@"There's a bug!");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)picClicked:(id)sender
{
    
}

- (IBAction)resetPWClicked:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Reset password"
                                                    message:@"you'll get an email to reset your password"
                                                   delegate:self
                                          cancelButtonTitle:@"cancel"
                                          otherButtonTitles:@"reset", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"reset"])
        [PFUser requestPasswordResetForEmailInBackground:currentUser.email block:^(BOOL succeeded, NSError *error) {
            if (!succeeded) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops"
                                                                message:[error userInfo][@"error"]
                                                               delegate:self
                                                      cancelButtonTitle:@"ok"
                                                      otherButtonTitles:nil];
                [alert show];
            } else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Reset password"
                                                                message:@"\nplease check your email"
                                                               delegate:self
                                                      cancelButtonTitle:@"ok"
                                                      otherButtonTitles:nil];
                [alert show];
            }
        }];
}

- (IBAction)saveClicked:(id)sender
{
    currentUser[@"nickname"] = _nicknameTF.text;
    [currentUser save];
    [currentUser refresh];
    NSLog(@"%@", currentUser);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([_nicknameTF.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops"
                                                        message:@"\nnickname can't be empty"
                                                       delegate:self
                                              cancelButtonTitle:@"ok"
                                              otherButtonTitles:nil];
        [alert show];
    } else
        [textField resignFirstResponder];
    return YES;
}

@end
