//
//  DetailViewController.m
//  RightNow
//
//  Created by Aeran on 2014. 12. 23..
//  Copyright (c) 2014년 Wafflestudio. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailTableViewCell.h"
#import "UIImage+IMAGECategories.h"
@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize detailTableView;
@synthesize titleLabel, backButton;
@synthesize avgTimeLabel, avgTimeValue, minute, recommendStation, reason;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // init Top View
    [backButton setTitle:@"<" forState:UIControlStateNormal];
    [[backButton titleLabel] setFont:[UIFont fontWithName:@"BMJUAOTF" size:21]];
    [titleLabel setText:@"추천장소"];
    [titleLabel setFont:[UIFont fontWithName:@"BMJUAOTF" size:21]];
    
    // init DetailTableView
    detailTableView.delegate = self;
    detailTableView.dataSource = self;
    [detailTableView setBackgroundColor:[UIColor clearColor]];
    
    [avgTimeLabel setFont:[UIFont fontWithName:@"BMJUAOTF" size:22]];
    [avgTimeValue setFont:[UIFont fontWithName:@"BMJUAOTF" size:22]];
    [minute setFont:[UIFont fontWithName:@"BMJUAOTF" size:22]];
    [recommendStation setFont:[UIFont fontWithName:@"BMJUAOTF" size:40]];
    [reason setFont:[UIFont fontWithName:@"BMJUAOTF" size:13]];
    
    [backButton addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)backButtonClicked:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 85;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailTableViewCell * cell = [[[NSBundle mainBundle] loadNibNamed:@"DetailTableViewCell" owner:nil options:nil] objectAtIndex:0];
    
    if(indexPath.row == 0){
        cell.departureStation.text = @"잠실역";
        cell.time.text = @"51";
    }else if(indexPath.row == 1){
        cell.departureStation.text = @"신림역";
        cell.time.text = @"22";
    }else if(indexPath.row == 2){
        cell.departureStation.text = @"대림역";
        cell.time.text = @"29";
    }else if(indexPath.row == 3){
        cell.departureStation.text = @"당산역";
        cell.time.text = @"43";
    }else{}
    return cell;
}

@end
