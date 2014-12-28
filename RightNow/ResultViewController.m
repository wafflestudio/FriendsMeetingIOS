//
//  ResultViewController.m
//  RightNow
//
//  Created by Sukwon Choi on 12/22/14.
//  Copyright (c) 2014 Wafflestudio. All rights reserved.
//

#import "ResultViewController.h"
#import "ResultTableViewCell.h"
#import "UIImage+IMAGECategories.h"
@interface ResultViewController ()

@end

@implementation ResultViewController
@synthesize button1, button2, button3;
@synthesize resultTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // init ResultTableView
    resultTableView.delegate = self;
    resultTableView.dataSource = self;
    
    // init Bottom View
    UIColor * normal = [UIColor whiteColor];
    
    [button1 setBackgroundImage:[UIImage image1x1WithColor:normal] forState:UIControlStateNormal];
    [button2 setBackgroundImage:[UIImage image1x1WithColor:normal] forState:UIControlStateNormal];
    [button3 setBackgroundImage:[UIImage image1x1WithColor:normal] forState:UIControlStateNormal];
    
    [button1 addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [button2 addTarget:self action:@selector(shareLineButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [button3 addTarget:self action:@selector(shareKakaoButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    button1.tag = 1;
    button2.tag = 2;
    button3.tag = 3;
}

- (void)backButtonClicked:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)shareLineButtonClicked:(UIButton *)sender{
    
}
-(void)shareKakaoButtonClicked:(UIButton *)sender{
    
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
    ResultTableViewCell * cell = [[[NSBundle mainBundle] loadNibNamed:@"ResultTableViewCell" owner:nil options:nil] objectAtIndex:0];
    
    if(indexPath.row == 0){
        cell.subwayName.text = @"강남역";
        cell.desc.text = @"모든 사람들의 이동시간의 합이 최소가 되는 장소";
    }else if(indexPath.row == 1){
        cell.subwayName.text = @"합정역";
        cell.desc.text = @"가장 오래 걸리는 사람의 이동시간이 최소가 되는 장소";
    }else if(indexPath.row == 2){
        cell.subwayName.text = @"당산역";
        cell.desc.text = @"막차 시간이 가장 늦은 장소";
    }else if(indexPath.row == 3){
        cell.subwayName.text = @"구로디지털단지역";
        cell.desc.text = @"영화관이 가까운 장소";
    }else{
        cell.subwayName.text = @"신촌역";
        cell.desc.text = @"데이트하기 좋은 장소";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"Detail" sender:self];
    
}

@end
