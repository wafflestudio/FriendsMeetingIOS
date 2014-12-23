//
//  ViewController.h
//  RightNow
//
//  Created by Sukwon Choi on 9/20/14.
//  Copyright (c) 2014 Wafflestudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController <UIScrollViewDelegate>{
    NSMutableDictionary * subwayDic;
    NSMutableDictionary * selectedSubway;
}

@property (nonatomic, strong) IBOutlet UIScrollView * scrollView;

@property (nonatomic, strong) IBOutlet UIButton * button1;
@property (nonatomic, strong) IBOutlet UIButton * button2;
@property (nonatomic, strong) IBOutlet UIButton * button3;
@property (nonatomic, strong) IBOutlet UIButton * result;

@end

