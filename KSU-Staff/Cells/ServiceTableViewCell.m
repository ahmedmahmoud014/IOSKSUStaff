//
//  DelegationTableViewCell.m
//  KSU_Students
//
//  Created by EJ-Mac book on 8/2/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "ServiceTableViewCell.h"
#import "StaticFuntions.h"
#import "AppDelegate.h"

@implementation ServiceTableViewCell

@synthesize ServiceNameLbl;

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}
-(void)initWithServicesObj:(ServicesObj *)obj withRowId:(int)rowId{
    
    ServiceNameLbl.textColor=[StaticFuntions getTableValueColor];
    sObj=obj;
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(appDelegate.currentLang==Arabic)
        ServiceNameLbl.text=sObj.serviceNameAr;
    else
        ServiceNameLbl.text=sObj.serviceNameEn;
    
    ServiceNameLbl.adjustsFontSizeToFitWidth=YES;
    
}
@end
