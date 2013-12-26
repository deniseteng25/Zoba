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
    _emailTF.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    currentUser = [PFUser currentUser];
    if (currentUser) {
        // do stuff with the user
        _accountTF.text = currentUser.username;
        _nicknameTF.text = currentUser[@"nickname"];
        _emailTF.text = currentUser[@"email"];
        _imageView.image = [UIImage imageWithData:[currentUser[@"pic"] getData]];
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
    UIActionSheet *targetSheet = [[UIActionSheet alloc] initWithTitle:@"Select a photo"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Library", @"Camera", nil];
    [targetSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if(buttonIndex == 0)
        [self selectFromLibrary];
    else if(buttonIndex == 1){
        [self onCamera];
    }
    else
        return;
}

-(void)onCamera{
    
    //建立一個ImagePickerController
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    //設定影像來源
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    
    //顯示Picker
    [self presentViewController:imagePicker animated:YES completion:NULL];
}

- (void)selectFromLibrary{
    //宣告一個UIImagePickerController並設定代理
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.allowsEditing = YES;
    picker.delegate = self;
    //設定圖片來源為圖庫
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    //以動畫方式顯示圖庫
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    
    [self.imageView setImage:image];
    
    // save pic
    NSData *imageData = UIImageJPEGRepresentation(image, 0.25);
    PFFile *imageFile = [PFFile fileWithName:@"pic" data:imageData];
    
    currentUser[@"pic"] = imageFile;
    [currentUser save];
    
    [picker dismissModalViewControllerAnimated:YES];
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
                                                                message:@"please check your email"
                                                               delegate:self
                                                      cancelButtonTitle:@"ok"
                                                      otherButtonTitles:nil];
                [alert show];
            }
        }];
    else if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"log out"]) {
        [PFUser logOut];
        
        id nextView = [self.storyboard instantiateViewControllerWithIdentifier:@"InitView"];
        [self presentViewController:nextView
                           animated:YES
                         completion:^{
                             [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"userId"];
                         }];
    }
}

- (IBAction)saveClicked:(id)sender
{
    currentUser[@"nickname"] = _nicknameTF.text;
    [currentUser save];
    [currentUser refresh];
    NSLog(@"%@", currentUser);
}

- (IBAction)logoutClicked:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log out"
                                                    message:@"are you sure?"
                                                   delegate:self
                                          cancelButtonTitle:@"cancel"
                                          otherButtonTitles:@"log out", nil];
    [alert show];
}

-(BOOL)isValidEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailPredicate evaluateWithObject:email];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([_nicknameTF.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops"
                                                        message:@"nickname can't be empty"
                                                       delegate:self
                                              cancelButtonTitle:@"ok"
                                              otherButtonTitles:nil];
        [alert show];
    } else if (![self isValidEmail:_emailTF.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops"
                                                        message:@"email is invalid"
                                                       delegate:self
                                              cancelButtonTitle:@"ok"
                                              otherButtonTitles:nil];
        [alert show];
    } else
        [textField resignFirstResponder];
    return YES;
}

@end
