//
//  ZBCreateDetailVC.m
//  Zoba
//
//  Created by Kevin on 12/25/13.
//  Copyright (c) 2013 tw.edu.nccu. All rights reserved.
//

#import "ZBCreateDetailVC.h"

@interface ZBCreateDetailVC ()

@end

@implementation ZBCreateDetailVC

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
    self.activityContent.delegate = self;
    
    self.titleLabel.text = self.Title;
    self.timeLabel.text = self.Time;
    self.amountLabel.text = self.Amount;
    self.locateLabel.text = self.Locate;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.activityContent resignFirstResponder];
    return YES;
}


- (void)textViewDidEndEditing:(UITextView *)textView {
    self.navigationItem.rightBarButtonItem = nil;
}

- (void)leaveEditMode {
    [self.activityContent resignFirstResponder];
}

@end
