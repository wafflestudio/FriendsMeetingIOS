//
//  ResultTableViewCell.h
//  RightNow
//
//  Created by Sukwon Choi on 12/22/14.
//  Copyright (c) 2014 Wafflestudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultTableViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel * subwayName;
@property (nonatomic, strong) IBOutlet UILabel * desc;

@property (nonatomic, strong) IBOutlet UIImageView * line;
@property (nonatomic, strong) IBOutlet UIImageView * access;


@end
