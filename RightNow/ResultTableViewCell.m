//
//  ResultTableViewCell.m
//  RightNow
//
//  Created by Sukwon Choi on 12/22/14.
//  Copyright (c) 2014 Wafflestudio. All rights reserved.
//

#import "ResultTableViewCell.h"

@implementation ResultTableViewCell
@synthesize subwayName, desc, access, line;

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
