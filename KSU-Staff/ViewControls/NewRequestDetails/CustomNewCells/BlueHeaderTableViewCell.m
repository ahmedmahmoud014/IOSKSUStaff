//
//  BlueHeaderTableViewCell.m
//  KSU-Staff
//
//  Created by Eman Kassem on 12/3/16.
//  Copyright © 2016 E-Jawdah. All rights reserved.
//

#import "BlueHeaderTableViewCell.h"

@implementation BlueHeaderTableViewCell

@synthesize headerTitle, togglingImageView, togglingButton;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
