//
//  TableViewCell.m
//  RightNow
//
//  Created by Aeran on 2014. 12. 23..
//  Copyright (c) 2014년 Wafflestudio. All rights reserved.
//

#import "DetailTableViewCell.h"

@implementation DetailTableViewCell
@synthesize departureLine, arrivalLine, departureStation, arrivalStation, time;

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
