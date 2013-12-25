//
//  ZBSignUpVC.h
//  Zoba
//
//  Created by Chantil on 2013/12/22.
//  Copyright (c) 2013年 tw.edu.nccu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZBSignUpVC : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *accountTF;
@property (strong, nonatomic) IBOutlet UITextField *passwordTF;
@property (strong, nonatomic) IBOutlet UITextField *nicknameTF;

- (IBAction)enterClicked:(id)sender;

@end
