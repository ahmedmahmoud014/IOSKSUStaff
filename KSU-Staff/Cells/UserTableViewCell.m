//
//  DelegationTableViewCell.m
//  KSU_Students
//
//  Created by EJ-Mac book on 8/2/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "UserTableViewCell.h"
#import "StaticFuntions.h"

@implementation UserTableViewCell

@synthesize userNameValLbl;

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}
-(void)initWithUserObj:(UserObj*)obj withRowId:(int)rowId{
    
    userNameValLbl.textColor=[StaticFuntions getTableValueColor];
    
    uObj=obj;
    userNameValLbl.text=uObj.userName;
    userNameValLbl.adjustsFontSizeToFitWidth=YES;
    
}
@end
