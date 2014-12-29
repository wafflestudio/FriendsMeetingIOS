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
@synthesize detailResults;
@synthesize titleLabel, backButton;
@synthesize avgTimeLabel;
@synthesize recommendStation, reason, recommendStationLine;

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
    NSInteger total_time = 0;
    int cnt = 0;
    for(NSArray * array in [detailResults objectForKey:@"from"]){
        total_time += [[array objectAtIndex:2] integerValue];
        cnt++;
    }
    [avgTimeLabel setText:[NSString stringWithFormat:@"평균소요시간 :   %d분", (int)(total_time/((double)cnt))]];
    
    recommendStation.text = [[[detailResults objectForKey:@"to"] objectAtIndex:0] stringByAppendingString:@"역"];
    [recommendStation setFont:[UIFont fontWithName:@"BMJUAOTF" size:40]];
    
    [recommendStationLine setImage:[UIImage imageNamed:[NSString stringWithFormat:@"sub_%@.gif", [[detailResults objectForKey:@"to"] objectAtIndex:1]]]];
    if(recommendStationLine.image == nil) [recommendStationLine setImage:[UIImage imageNamed:@"sub_trans.gif"]];
        
    reason.text = [[detailResults objectForKey:@"to"] objectAtIndex:2];
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
    return [[detailResults objectForKey:@"from"] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 85;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailTableViewCell * cell = [[[NSBundle mainBundle] loadNibNamed:@"DetailTableViewCell" owner:nil options:nil] objectAtIndex:0];
    
    NSString * subway_name = [[[detailResults objectForKey:@"from"] objectAtIndex:indexPath.row] objectAtIndex:0];
    NSString * subway_line = [[[detailResults objectForKey:@"from"] objectAtIndex:indexPath.row] objectAtIndex:1];
    NSNumber * time = [[[detailResults objectForKey:@"from"] objectAtIndex:indexPath.row] objectAtIndex:2];
    
    cell.departureStation.text = subway_name;
    cell.time.text = [time stringValue];
    cell.departureLine.image = [UIImage imageNamed:[NSString stringWithFormat:@"sub_%@.gif",subway_line]];
    if(cell.departureLine.image == nil) {
        cell.departureLine.image = [UIImage imageNamed:@"sub_trans.gif"];
    }
    return cell;
}

@end
