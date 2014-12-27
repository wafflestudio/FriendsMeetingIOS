//
//  TableViewCell.h
//  RightNow
//
//  Created by Aeran on 2014. 12. 23..
//  Copyright (c) 2014년 Wafflestudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailTableViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel * departureStation;
@property (nonatomic, strong) IBOutlet UILabel * arrivalStation;
@property (nonatomic, strong) IBOutlet UILabel * time;

@property (nonatomic, strong) IBOutlet UIImageView * departureLine;
@property (nonatomic, strong) IBOutlet UIImageView * arrivalLine;

@end

