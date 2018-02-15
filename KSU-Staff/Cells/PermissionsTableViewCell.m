//
//  PermissionsObjTableViewCell.m
//  KSU_Students
//
//  Created by EJ-Mac book on 8/10/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "PermissionsTableViewCell.h"
#import "LocalizedMessages.h"

@implementation PermissionsTableViewCell
@synthesize pageNameLbl,actionsLbl;

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - methods

-(void) initWithPageObj:(PageObj *)page withRowId:(int)rowID{
    pObj=page;
    pageNameLbl.text=pObj.pageName;
    actionsLbl.text=pObj.actions;
    
    actionsLbl.adjustsFontSizeToFitWidth=YES;
    
    
}

@end
