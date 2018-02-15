//
//  ClaimListTableViewCell.m
//  KSU-Staff
//
//  Created by EJ-Mac book on 2/2/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "ClaimListTableViewCell.h"
#import "AppDelegate.h"
@implementation ClaimListTableViewCell
@synthesize claimDescpLbl,createDateLbl,ticketNoLbl;


- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)initWithObj:(ClaimObj*)obj  withRowIndex:(int)rowID{
    cObj=obj;
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(appDelegate.currentLang== English){
    
    claimDescpLbl.text=cObj.claimDescp;
    createDateLbl.text=cObj.createDate;
    ticketNoLbl.text=cObj.ticketNo;
    }else {
        claimDescpLbl.text=cObj.ticketNo;
        createDateLbl.text=cObj.createDate;
        ticketNoLbl.text=cObj.claimDescp;
    }
    
}
@end
