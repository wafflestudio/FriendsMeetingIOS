//
//  ViewController.m
//  RightNow
//
//  Created by Sukwon Choi on 9/20/14.
//  Copyright (c) 2014 Wafflestudio. All rights reserved.
//

#import "MainViewController.h"
#import "ResultViewController.h"
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
    button_size = 20;
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
    [button1 setImage:[UIImage imageNamed:@"page1_bottom_btn1"] forState:UIControlStateNormal];
    [button2 setImage:[UIImage imageNamed:@"page1_bottom_btn2"] forState:UIControlStateNormal];
    [button3 setImage:[UIImage imageNamed:@"page1_bottom_btn3"] forState:UIControlStateNormal];
    [result setImage:[UIImage imageNamed:@"page1_bottom_btn4"] forState:UIControlStateNormal];
    
    [button1 setImage:[UIImage imageNamed:@"page1_bottom_btn1_click"]
                       forState:UIControlStateSelected];
    [button2 setImage:[UIImage imageNamed:@"page1_bottom_btn2_click"]
                       forState:UIControlStateSelected];
    [button3 setImage:[UIImage imageNamed:@"page1_bottom_btn3_click"]
                       forState:UIControlStateSelected];
    [result setImage:[UIImage imageNamed:@"page1_bottom_btn4_click"]
                      forState:UIControlStateHighlighted];
    
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


// Subway Button Clicked
- (void)subwayButtonClicked:(UIButton *)sender{
    NSLog(@"button Clicked %@", [subwayDic objectForKey:[NSNumber numberWithInteger:sender.tag]]);
    
    // Remove original subwayClickedImageView
    for (UIImageView * view in [scrollView subviews]){
        if(view.tag == 119){
            [view removeFromSuperview];
        }
    }
    
    // Set subwayClickedImageView
    CGPoint center = CGPointMake(sender.frame.origin.x + sender.frame.size.width/2, sender.frame.origin.y + sender.frame.size.height/2);
    CGSize imageSize = CGSizeMake(131, 53);
    
    // Resize with scrollView.zoomScale
    CGRect rect = CGRectMake(center.x*scrollView.zoomScale- imageSize.width/2 + 1, center.y*scrollView.zoomScale - imageSize.height , imageSize.width, imageSize.height);
    
    // Init Images
    UIImageView * bgImageView = [[UIImageView alloc] initWithFrame:rect];
    bgImageView.image = [UIImage imageNamed:@"page1_button_bg"];
    bgImageView.userInteractionEnabled = YES;
    
    // Init minus, plus button
    UIButton * minusButton = [UIButton buttonWithType:UIButtonTypeCustom];
    minusButton.frame = CGRectMake(0, 0, 43, 53);
    UIButton * plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
    plusButton.frame = CGRectMake(90, 0, 40, 53);
    
    [minusButton setImage:[UIImage imageNamed:@"page1_button_left"] forState:UIControlStateNormal];
    [minusButton setImage:[UIImage imageNamed:@"page1_button_left_click"] forState:UIControlStateHighlighted];
    [plusButton setImage:[UIImage imageNamed:@"page1_button_right"] forState:UIControlStateNormal];
    [plusButton setImage:[UIImage imageNamed:@"page1_button_right_click"] forState:UIControlStateHighlighted];
    
    minusButton.tag = sender.tag;
    plusButton.tag = sender.tag;
    
    minusButton.userInteractionEnabled = YES;
    plusButton.userInteractionEnabled = YES;
    
    [minusButton addTarget:self action:@selector(minusButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [plusButton addTarget:self action:@selector(plusButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel * number = [[UILabel alloc] initWithFrame:CGRectMake(rect.size.width/2-rect.size.width/(3.25*2), rect.size.height/2-rect.size.height/2, 40, 40)];
    [number setFont:[UIFont fontWithName:@"BMJUAOTF" size:20]];
    
    
    NSNumber * subway_id = [NSNumber numberWithInteger:sender.tag];
    NSArray * array = [selectedSubway objectForKey:subway_id];
    NSNumber * count = [array objectAtIndex:2];
    [number setText:[NSString stringWithFormat:@"%d명",[count intValue]]];
    [number setTextColor:[UIColor whiteColor]];
    [number setTextAlignment:NSTextAlignmentCenter];
    number.tag = 111;
    
    [bgImageView addSubview:minusButton];
    [bgImageView addSubview:plusButton
     ];
    [bgImageView addSubview:number];
    
    bgImageView.tag = 119;
    
    [scrollView addSubview:bgImageView];
}

- (void)minusButtonClicked:(UIButton *)sender{
    
    NSLog(@"minus Button Clicked");
    NSNumber * subway_id = [NSNumber numberWithInteger:sender.tag];
    NSArray * array = [selectedSubway objectForKey:subway_id];
    if(array == nil) return;
    
    NSNumber * count = [array objectAtIndex:2];
    if([count intValue] <= 0) return;
    [self updateSelectedSubways:(int)sender.tag number:[count intValue]-1];
    
    // update view
    for (UIImageView * view in [scrollView subviews]){
        if(view.tag == 119){
            for(UILabel * label in [view subviews]){
                if(label.tag == 111){
                    [label setText:[NSString stringWithFormat:@"%d명", [count intValue]-1]];
                }
            }
        }
    }
    
}
- (void)plusButtonClicked:(UIButton *)sender{
    NSLog(@"plus Button Clicked");
    NSNumber * subway_id = [NSNumber numberWithInteger:sender.tag];
    NSArray * array = [selectedSubway objectForKey:subway_id];
    NSNumber * count = [array objectAtIndex:2];
    [self updateSelectedSubways:(int)sender.tag number:[count intValue]+1];
    
    // update view
    for (UIImageView * view in [scrollView subviews]){
        if(view.tag == 119){
            for(UILabel * label in [view subviews]){
                if(label.tag == 111){
                    [label setText:[NSString stringWithFormat:@"%d명", [count intValue]+1]];
                }
            }
        }
    }
}

- (void)updateSelectedSubways:(int)_subway_id number:(int)_count{
    NSNumber * subway_id = [NSNumber numberWithInt:_subway_id];
    NSNumber * count = [NSNumber numberWithInt:_count];
    
    if([selectedSubway objectForKey:subway_id]){
        [selectedSubway removeObjectForKey:subway_id];
    }
    [selectedSubway setObject:[NSArray arrayWithObjects:subway_id, [subwayDic objectForKey:subway_id], count, nil] forKey:subway_id];
}


// Popularity Button Clicked
- (void)popularityButtonClicked:(UIButton *)sender{
    NSLog(@"pop Button Clicked %d", (int)sender.tag);
    if(sender.selected) return;
    
    button1.selected = NO;
    button2.selected = NO;
    button3.selected = NO;
    
    sender.selected = YES;
}

// Result Button Clicked
- (void)resultButtonClicked:(UIButton *) sender{
    [self performSegueWithIdentifier:@"Result" sender:self];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"Result"])
    {
//        ResultViewController *vc = [segue destinationViewController];
        
        // Send data
    }
}

- (CGRect)resizeRect:(CGRect)rect scale:(CGFloat)_scale{
    return CGRectMake(rect.origin.x*_scale, rect.origin.y*_scale, rect.size.width*_scale, rect.size.height*_scale);
}

// ScrollView Delegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)_scrollView{
    // Remove original subwayClickedImageView
    for (UIImageView * view in [_scrollView subviews]){
        if(view.tag == 119){
            [view removeFromSuperview];
        }
    }
    UIView * subwayImageView = [[scrollView subviews] objectAtIndex:0];
    return subwayImageView;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)_scrollView{
    // Remove original subwayClickedImageView
    for (UIImageView * view in [_scrollView subviews]){
        if(view.tag == 119){
            [view removeFromSuperview];
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
