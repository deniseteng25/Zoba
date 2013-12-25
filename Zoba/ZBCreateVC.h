//
//  ZBCreateVC.h
//  Zoba
//
//  Created by Chantil on 2013/12/22.
//  Copyright (c) 2013年 tw.edu.nccu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBCreateDetailVC.h"

@interface ZBCreateVC : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *titleField;
@property (strong, nonatomic) IBOutlet UITextField *categaryField;
@property (strong, nonatomic) IBOutlet UITextField *amountField;
@property (strong, nonatomic) IBOutlet UITextField *timeField;
@property (strong, nonatomic) IBOutlet UITextField *locateField;
@property (strong, nonatomic) IBOutlet UITextField *inviteField;

- (IBAction)addPeople:(id)sender;
- (IBAction)confirm:(id)sender;

@end
