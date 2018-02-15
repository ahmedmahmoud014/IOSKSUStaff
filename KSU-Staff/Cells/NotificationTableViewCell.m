//
//  NotificationTableViewCell.m
//  KSU-Staff
//
//  Created by EJ-Mac book on 6/25/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "NotificationTableViewCell.h"

@implementation NotificationTableViewCell
@synthesize notifyLbl,dateLbl;

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)initWithNotifyObj:(NotifyDetailsObj*)obj withRowId:(int)rowId{
    nObj=obj;
    notifyLbl.text=obj.notifyText;
    dateLbl.text=obj.time;
    
    notifyLbl.numberOfLines = 5;
    
}


@end
