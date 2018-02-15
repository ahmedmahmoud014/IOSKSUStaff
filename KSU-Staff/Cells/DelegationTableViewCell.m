//
//  DelegationTableViewCell.m
//  KSU_Students
//
//  Created by EJ-Mac book on 8/2/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "DelegationTableViewCell.h"
#import "LocalizedMessages.h"
#import "AppDelegate.h"

@implementation DelegationTableViewCell

@synthesize statusImg;

@synthesize userNameTitleLbl;
@synthesize startTimeTitleLbl;
@synthesize endTimeTitleLbl;
@synthesize serviceNameTitleLbl;
@synthesize RequestIDTitleLbl;

@synthesize userNameValLbl;
@synthesize startTimeValLbl;
@synthesize endTimeValLbl;
@synthesize serviceNameValLbl;
@synthesize RequestIDValLbl;



- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)initWithDelegationObj:(DelegationObj*)obj withRowId:(int)rowId{
    dObj=obj;
    userNameTitleLbl.text=UserUsernameText;
    startTimeTitleLbl.text=delegationStartTimeText;
    endTimeTitleLbl.text=delegationEndTimeText;
    serviceNameTitleLbl.text=delegationServiceNameText;
    RequestIDTitleLbl.text=delegationRequestIDText;

    userNameValLbl.text=dObj.user.userName;
    startTimeValLbl.text=dObj.startTime;
    endTimeValLbl.text=dObj.endTime;

    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if(appDelegate.currentLang==Arabic)
        serviceNameValLbl.text=dObj.serviceNameAr;
    else
        serviceNameValLbl.text=dObj.serviceNameEn;
    
    
    if (![dObj.requestNo isKindOfClass:[NSNull class]])
    {
    RequestIDValLbl.text=dObj.requestNo;
    }
    
    if (dObj.status) {
        statusImg.image=[UIImage imageNamed:@"delegation_green.png"];
    }
    else
    {
        statusImg.image=[UIImage imageNamed:@"delegation_red.png"];
    }
    
    //userNameTitleLbl.adjustsFontSizeToFitWidth=YES;
    //startTimeTitleLbl.adjustsFontSizeToFitWidth=YES;
//    endTimeTitleLbl.adjustsFontSizeToFitWidth=YES;
  //  serviceNameTitleLbl.adjustsFontSizeToFitWidth=YES;
   // RequestIDTitleLbl.adjustsFontSizeToFitWidth=YES;
    
    userNameValLbl.adjustsFontSizeToFitWidth=YES;
    startTimeValLbl.adjustsFontSizeToFitWidth=YES;
    endTimeValLbl.adjustsFontSizeToFitWidth=YES;
    serviceNameValLbl.adjustsFontSizeToFitWidth=YES;
    RequestIDValLbl.adjustsFontSizeToFitWidth=YES;
    
    
}
@end
