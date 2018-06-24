//
//  OderItemTableViewCell.m
//  KSU-Staff
//
//  Created by iOSAccount on 11/13/17.
//  Copyright © 2017 E-Jawdah. All rights reserved.
//

#import "OderItemTableViewCell.h"

@implementation OderItemTableViewCell
@synthesize orderImage,orderName;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)initWithOrderObj:(OrderItemObj *)obj withRowId:(int)rowId{
    orderName.text=obj.orderName;
    orderImage.image = [UIImage imageNamed:obj.orderImageName];
}



@end
