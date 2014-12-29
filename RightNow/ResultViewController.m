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
#import "Server.h"
@interface ResultViewController (){
    
    NSMutableArray * results;
}

@end

@implementation ResultViewController
@synthesize titleLabel, backButton;
@synthesize button1, button2, button3;
@synthesize resultTableView;
@synthesize selectedSubways, status;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // init results
    results = [[NSMutableArray alloc] init];
    
    // init ResultTableView
    resultTableView.delegate = self;
    resultTableView.dataSource = self;
    
    // init Top View
    [backButton setTitle:@"<" forState:UIControlStateNormal];
    [[backButton titleLabel] setFont:[UIFont fontWithName:@"BMJUAOTF" size:21]];
    [titleLabel setText:@"검색결과"];
    [titleLabel setFont:[UIFont fontWithName:@"BMJUAOTF" size:21]];

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
    
    [resultTableView setHidden:YES];

    NSString * string = @"";
    for(id key in selectedSubways){
        NSArray * value = [selectedSubways objectForKey:key];
        
        for(int i=0; i<[[value objectAtIndex:2] integerValue]; i++){
            NSString * name = [value objectAtIndex:1];
            name = [self convertSubwayName:name];
            string = [string stringByAppendingString:[NSString stringWithFormat:@"%@_", name]];
        }
    }
    if([selectedSubways count] == 0) string = @" ";
    [Server sendRequest:[string substringToIndex:[string length]-1] status:[status intValue]];
    
    // myNotificationCenter 객체 생성 후 defaultCenter에 등록
    NSNotificationCenter *sendNotification = [NSNotificationCenter defaultCenter];
    
    // myNotificationCenter 객체를 이용해서 옵저버 등록
    [sendNotification addObserver:self selector:@selector(getResultFromServer:) name:@"resultFromServer" object: nil];
    
}

- (void)getResultFromServer:(NSNotification *)notification{
    NSDictionary * dictionary = [notification userInfo];
    for(NSArray * array in [dictionary objectForKey:@"results"]){
        NSLog(@"%@", [array objectAtIndex:0]);
        [results addObject:array];
    }
    [resultTableView setHidden:NO];
    
    [resultTableView reloadData];
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
    return [results count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 85;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ResultTableViewCell * cell = [[[NSBundle mainBundle] loadNibNamed:@"ResultTableViewCell" owner:nil options:nil] objectAtIndex:0];
    
    
    NSString * subway_name = [[results objectAtIndex:indexPath.row] objectAtIndex:0];
    if(indexPath.row == 0){
        cell.subwayName.text = [NSString stringWithFormat:@"%@역", subway_name];
        cell.desc.text = @"모든 사람들의 이동시간의 합이 최소가 되는 장소";
    }else if(indexPath.row == 1){
        cell.subwayName.text = [NSString stringWithFormat:@"%@역", subway_name];
        cell.desc.text = @"가장 오래 걸리는 사람의 이동시간이 최소가 되는 장소";
    }else if(indexPath.row == 2){
        cell.subwayName.text = [NSString stringWithFormat:@"%@역", subway_name];
        cell.desc.text = @"막차 시간이 가장 늦은 장소";
    }else if(indexPath.row == 3){
        cell.subwayName.text = [NSString stringWithFormat:@"%@역", subway_name];
        cell.desc.text = @"영화관이 가까운 장소";
    }else{
        cell.subwayName.text = [NSString stringWithFormat:@"%@역", subway_name];
        cell.desc.text = @"데이트하기 좋은 장소";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"Detail" sender:self];
    
}


// Custom Method
- (NSString *)convertSubwayName:(NSString *)name{
    if([name isEqualToString:@"총신대입구역(이수역)"]){
        name = @"총신대입구(이수)역";
    }else if([name isEqualToString:@"시청용인대역"]){
        name = @"시청.용인대역";
    }else if([name isEqualToString:@"전대에버랜드역"]){
        name = @"전대.에버랜드역";
    }else if([name isEqualToString:@"수유(강북구청)역"]){
        name = @"수유역";
    }else if([name isEqualToString:@"양평역"]){
        name = @"양평(중앙선)역";
    }else if([name isEqualToString:@"녹사평(용산구청)역"]){
        name = @"녹사평역";
    }else if([name isEqualToString:@"가천대역"]){
        name = @"가천대역역";
    }else if([name isEqualToString:@"운동장송담대역"]){
        name = @"운동장.송담대역";
    }else if([name isEqualToString:@"봉화산(서울의료원)역"]){
        name = @"봉화산역";
    }else if([name isEqualToString:@"신창(순천향대)역"]){
        name = @"신창역";
    }else if([name isEqualToString:@"쌍용(나사렛대)역"]){
        name = @"쌍용역";
    }else if([name isEqualToString:@"서울역"]){
        name = @"서울역역";
    }
    
    name = [name substringToIndex:[name length]-1];
    
    return name;
}

@end
