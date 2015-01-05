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

#import "DetailViewController.h"
@interface ResultViewController (){
    
    NSDictionary * results;
    NSArray * descArray;
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
    results = [[NSDictionary alloc] init];
    descArray = [[NSArray alloc] initWithObjects:
                 @"모든 사람들의 이동시간의 합이 최소가 되는 장소",
                 @"가장 오래 걸리는 사람의 이동시간이 최소가 되는 장소",
                 @"영화관이 가장 가까운 장소",
                 @"맛집이 많은 장소",
                 @"카페가 많은 장소",
                 nil];
    
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
    
    [button1 addTarget:self action:@selector(shareLineButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [button2 addTarget:self action:@selector(shareKakaoButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [button3 addTarget:self action:@selector(saveScreenShotButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
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
    results = [notification userInfo];
    
    [resultTableView setHidden:NO];
    
    [resultTableView reloadData];
}


- (void)backButtonClicked:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)shareLineButtonClicked:(UIButton *)sender{
    NSLog(@"share Line Button Clicked");
}
-(void)shareKakaoButtonClicked:(UIButton *)sender{
    NSLog(@"share Kakao Button Clicked");
}
-(void)saveScreenShotButtonClicked:(UIButton *)sender{
    NSLog(@"save Screenshot Button Clicked");
    
    sender.highlighted = NO;
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"추천 장소를 앨범에 저장합니다" delegate:self cancelButtonTitle:@"취소" otherButtonTitles:@"확인", nil];
    [alert show];
}

- (UIImage *)takeScreenshot{
    UIImage * image;
    UIGraphicsBeginImageContext(CGSizeMake(320, 568));
    {
        CGRect savedFrame = self.view.frame;
        
        self.view.frame = CGRectMake(0, 0, 320, 568);
        
        [self.view.layer renderInContext: UIGraphicsGetCurrentContext()];
        image = UIGraphicsGetImageFromCurrentImageContext();
        
        self.view.frame = savedFrame;
    }
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma  mark - UIAlertViewDelegate
// UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==0){
        // Cancel save
        return;
    }else if(buttonIndex==1){
        // Confirm save
        UIImage* image = [self takeScreenshot];

        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    }else{
        
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[results objectForKey:@"results"] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 85;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ResultTableViewCell * cell = [[[NSBundle mainBundle] loadNibNamed:@"ResultTableViewCell" owner:nil options:nil] objectAtIndex:0];
    
    
    NSString * subway_name = [[[results objectForKey:@"results"] objectAtIndex:indexPath.row] objectAtIndex:0];
    NSString * subway_line = [[[results objectForKey:@"results"] objectAtIndex:indexPath.row] objectAtIndex:1];
    
    cell.subwayName.text = [NSString stringWithFormat:@"%@역", subway_name];
    if([cell.subwayName.text isEqualToString:@"서울역역"]){
        cell.subwayName.text = @"서울역";
    }
    cell.desc.text = [descArray objectAtIndex:indexPath.row];
    cell.line.image = [UIImage imageNamed:[NSString stringWithFormat:@"sub_%@.gif",subway_line]];
    if(cell.line.image == nil) {
        cell.line.image = [UIImage imageNamed:@"sub_trans.gif"];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"Detail" sender:indexPath];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(NSIndexPath *)indexPath
{
    if ([[segue identifier] isEqualToString:@"Detail"])
    {
        DetailViewController * dv = segue.destinationViewController;
        NSMutableDictionary * detailResults = [[NSMutableDictionary alloc] init];
        // to (destination)
        NSString * subway_name = [[[results objectForKey:@"results"] objectAtIndex:indexPath.row] objectAtIndex:0];
        NSString * subway_line = [[[results objectForKey:@"results"] objectAtIndex:indexPath.row] objectAtIndex:1];
        NSString * desc = [descArray objectAtIndex:indexPath.row];
        [detailResults setObject:[NSArray arrayWithObjects:subway_name, subway_line, desc, nil] forKey:@"to"];
        
        // from
        NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
        
        int cnt = 0;
        for(id key in selectedSubways){
            NSArray * value = [selectedSubways objectForKey:key];
            
            for(int i=0; i<[[value objectAtIndex:2] integerValue]; i++){
                NSString * subway_name = [self convertSubwayName:[value objectAtIndex:1]];
                if([subway_name isEqualToString:@"서울역역"]){
                    subway_name = @"서울역";
                }
                NSString * subway_line = [[results objectForKey:@"from"] objectAtIndex:cnt];
                NSNumber * time = [[[results objectForKey:@"results"] objectAtIndex:indexPath.row] objectAtIndex:cnt+2];
                [dic setObject:[NSArray arrayWithObjects:subway_name, subway_line, time, nil] forKey:subway_name];
                cnt++;
            }
        }
        [detailResults setObject:[dic allValues] forKey:@"from"];
        
        dv.detailResults = detailResults;
    }
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
