//
//  ResultViewController.h
//  RightNow
//
//  Created by Sukwon Choi on 12/22/14.
//  Copyright (c) 2014 Wafflestudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>{

}

@property (nonatomic, strong) IBOutlet UITableView * resultTableView;

@property (nonatomic, strong) IBOutlet UIButton * button1;
@property (nonatomic, strong) IBOutlet UIButton * button2;
@property (nonatomic, strong) IBOutlet UIButton * button3;

@end
