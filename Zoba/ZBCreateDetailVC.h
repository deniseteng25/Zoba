//
//  ZBCreateDetailVC.h
//  Zoba
//
//  Created by Kevin on 12/25/13.
//  Copyright (c) 2013 tw.edu.nccu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZBCreateDetailVC : UIViewController<UITextViewDelegate>

@property NSString *Title;
@property NSString *Time;
@property NSString *Amount;
@property NSString *Locate;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *amountLabel;
@property (strong, nonatomic) IBOutlet UILabel *locateLabel;

@property (strong, nonatomic) IBOutlet UIScrollView *invitedSV;

@property (strong, nonatomic) IBOutlet UITextView *activityContent;

@end
