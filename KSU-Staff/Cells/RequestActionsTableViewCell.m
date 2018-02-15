//
//  RequestsTableViewCell.m
//  KSU_Students
//
//  Created by EJ-Mac book on 8/2/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "RequestActionsTableViewCell.h"
#import "LocalizedMessages.h"

@implementation RequestActionsTableViewCell

@synthesize detailsBtn;
@synthesize userNameTitleLbl;
@synthesize actionTitleLbl;
@synthesize dateTitleLbl;
@synthesize userNameValLbl;
@synthesize actionValLbl;
@synthesize dateValLbl;


- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)initWithRequestActionsObj:(RequestActionsObj*)obj withRowId:(int)rowId{
    rObj=obj;
    
    userNameTitleLbl.text=UserNameText;
    actionTitleLbl.text=RequestActionText;
    dateTitleLbl.text=RequestActionDateText;

    userNameValLbl.text=rObj.userName;
    actionValLbl.text=rObj.action;
    dateValLbl.text=rObj.date;
    
    [detailsBtn setImage:[UIImage imageNamed:@"ActionDetails.png"] forState:UIControlStateNormal];
    
}
@end
