//
//  ZBCreateVC.m
//  Zoba
//
//  Created by Chantil on 2013/12/22.
//  Copyright (c) 2013年 tw.edu.nccu. All rights reserved.
//

#import "ZBCreateVC.h"

@interface ZBCreateVC ()

@end

@implementation ZBCreateVC

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
    self.titleField.delegate = self;
    self.timeField.delegate = self;
    self.amountField.delegate = self;
    self.locateField.delegate = self;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addPeople:(id)sender {
}

- (IBAction)confirm:(id)sender {
    
    ZBCreateDetailVC *view = [self.storyboard instantiateViewControllerWithIdentifier: @"activityDetail"];
    
    view.Title = self.titleField.text;
    view.Time = self.timeField.text;
    view.Amount = self.amountField.text;
    view.Locate = self.locateField.text;
    
    [self.navigationController pushViewController: view animated:YES];

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
