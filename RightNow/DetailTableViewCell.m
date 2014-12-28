//
//  TableViewCell.m
//  RightNow
//
//  Created by Aeran on 2014. 12. 23..
//  Copyright (c) 2014년 Wafflestudio. All rights reserved.
//

#import "DetailTableViewCell.h"

@implementation DetailTableViewCell
@synthesize departureLine, departureStation, time, from, minute;

- (void)awakeFromNib {
    [departureStation setFont:[UIFont fontWithName:@"BMJUAOTF" size:20]];
    [time setFont:[UIFont fontWithName:@"BMJUAOTF" size:40]];
    [from setFont:[UIFont fontWithName:@"BMJUAOTF" size:13]];
    [minute setFont:[UIFont fontWithName:@"BMJUAOTF" size:21]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
