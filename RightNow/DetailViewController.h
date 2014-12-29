//
//  DetailViewController.h
//  RightNow
//
//  Created by Aeran on 2014. 12. 23..
//  Copyright (c) 2014년 Wafflestudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView * detailTableView;

@property (nonatomic, strong) IBOutlet UILabel * titleLabel;
@property (nonatomic, strong) IBOutlet UIButton * backButton;

@property (nonatomic, strong) IBOutlet UILabel * recommendStation;
@property (nonatomic, strong) IBOutlet UILabel * reason;
@property (nonatomic, strong) IBOutlet UILabel * avgTimeLabel;
@property (nonatomic, strong) IBOutlet UILabel * avgTimeValue;
@property (nonatomic, strong) IBOutlet UILabel * minute;

@end
