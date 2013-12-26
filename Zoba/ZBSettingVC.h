//
//  ZBSettingVC.h
//  Zoba
//
//  Created by Chantil on 2013/12/22.
//  Copyright (c) 2013年 tw.edu.nccu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZBSettingVC : UIViewController <UITextFieldDelegate, UIAlertViewDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UITextField *accountTF;
@property (strong, nonatomic) IBOutlet UITextField *nicknameTF;
@property (strong, nonatomic) IBOutlet UITextField *emailTF;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)picClicked:(id)sender;
- (IBAction)resetPWClicked:(id)sender;
- (IBAction)saveClicked:(id)sender;
- (IBAction)logoutClicked:(id)sender;

@end
