//
//  ViewController.m
//  RightNow
//
//  Created by Sukwon Choi on 9/20/14.
//  Copyright (c) 2014 Wafflestudio. All rights reserved.
//

#import "MainViewController.h"
#import "UIImage+IMAGECategories.h"

@interface MainViewController (){
    int button_size;
    double width_std;
    double height_std;
    double width;
    double height;
    double scale;
}

@end

@implementation MainViewController
@synthesize scrollView;
@synthesize button1, button2, button3, result;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Initiate
    button_size = 15;
    width_std = 4007.73;
    height_std = 3732.199;
    scale = 4;
    width = self.view.frame.size.width * scale;
    height = self.view.frame.size.width * scale * 3732.199 / 4007.73;
    
    subwayDic = [[NSMutableDictionary alloc] init];
    selectedSubway = [[NSMutableDictionary alloc] init];
    
    UIImage * subwayImage = [UIImage imageNamed:@"Subway"];
    UIImageView * subwayImageView = [[UIImageView alloc] initWithImage:subwayImage];
    subwayImageView.frame = CGRectMake(0, 0, width, height);
    subwayImageView.userInteractionEnabled = YES;
    
    CGSize imageSize = CGSizeMake(width, height);
    [scrollView setContentSize:imageSize];
    [scrollView addSubview:subwayImageView];
    
    scrollView.delegate = self;
    [scrollView setContentOffset:CGPointMake(width/2 - scrollView.frame.size.width/2, height/2 - scrollView.frame.size.height/2)];
    
    // Add Buttons
    NSString* path = [[NSBundle mainBundle] pathForResource:@"subway_corrd"
                                                     ofType:@"csv"];
    NSString * data = [NSString stringWithContentsOfFile:path
                                                 encoding:NSUTF8StringEncoding
                                                    error:NULL];
    NSArray * lines = [data componentsSeparatedByString:@"\n"];
    
    for(NSString *line in lines){
        NSArray * field = [line componentsSeparatedByString:@","];
        NSString * name = [field objectAtIndex:0];
        int x = [[field objectAtIndex:1] intValue];
        int y = [[field objectAtIndex:2] intValue];
        
        // Rescale x and y
        x = (x / width_std) * width;
        y = (y / height_std) * height;
        
        int ID = [[field objectAtIndex:3] intValue];
 
        [subwayDic setObject:name forKey:[NSNumber numberWithInt:ID]];
 
        // Add Button
        [self addButtonWithID:subwayImageView x:x y:y ID:ID];
    }
    
    // Init Bottom View
    UIColor * normal = [UIColor whiteColor];
    UIColor * selected = [UIColor lightGrayColor];
    
    [button1 setBackgroundImage:[UIImage image1x1WithColor:normal] forState:UIControlStateNormal];
    [button2 setBackgroundImage:[UIImage image1x1WithColor:normal] forState:UIControlStateNormal];
    [button3 setBackgroundImage:[UIImage image1x1WithColor:normal] forState:UIControlStateNormal];
    [result setBackgroundImage:[UIImage image1x1WithColor:normal] forState:UIControlStateNormal];
    
    [button1 setBackgroundImage:[UIImage image1x1WithColor:selected] forState:UIControlStateSelected];
    [button2 setBackgroundImage:[UIImage image1x1WithColor:selected] forState:UIControlStateSelected];
    [button3 setBackgroundImage:[UIImage image1x1WithColor:selected] forState:UIControlStateSelected];
    
    [button1 addTarget:self action:@selector(popularityButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [button2 addTarget:self action:@selector(popularityButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [button3 addTarget:self action:@selector(popularityButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [result addTarget:self action:@selector(resultButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    button1.tag = 1;
    button2.tag = 2;
    button3.tag = 3;
    
    button1.selected = YES;

}


// Custom Methods
- (UIButton *)addButtonWithID:(UIImageView *)_imageView x:(int)x y:(int)y ID:(int)ID{
    UIButton * button = [self addButton:_imageView x:x y:y];
    button.tag = ID;
    return button;
}
- (UIButton *)addButton:(UIImageView *)_imageView x:(int)x y:(int)y{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(x-button_size/2, y-button_size/2, button_size, button_size);
    button.backgroundColor = [UIColor clearColor];
    button.userInteractionEnabled = YES;
    [button addTarget:self action:@selector(subwayButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [_imageView addSubview:button];
    return button;
}

- (void)subwayButtonClicked:(UIButton *)sender{
    NSLog(@"button Clicked %@", [subwayDic objectForKey:[NSNumber numberWithInteger:sender.tag]]);
}
- (void)popularityButtonClicked:(UIButton *)sender{
    NSLog(@"pop Button Clicked %d", (int)sender.tag);
    if(sender.selected) return;
    
    button1.selected = NO;
    button2.selected = NO;
    button3.selected = NO;
    
    sender.selected = YES;
}
- (void)resultButtonClicked:(UIButton *) sender{
    [self performSegueWithIdentifier:@"Result" sender:self];
}
- (void)updateSelectedSubways:(int)_subway_id number:(int)_count{
    NSNumber * subway_id = [NSNumber numberWithInt:_subway_id];
    NSNumber * count = [NSNumber numberWithInt:_count];
    
    if([selectedSubway objectForKey:subway_id]){
        [selectedSubway removeObjectForKey:subway_id];
    }
    [selectedSubway setObject:[NSArray arrayWithObjects:subway_id, count, nil] forKey:subway_id];
}

// ScrollView Delegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)_scrollView{
    return [[_scrollView subviews] objectAtIndex:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
