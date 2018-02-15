//
//  ContactTableViewCell.m
//  KSU-Staff
//
//  Created by EJ-Mac book on 11/18/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import "ContactTableViewCell.h"
#import "StaticFuntions.h"

@implementation ContactTableViewCell
@synthesize contactNameLbl,phoneBtn,phoneNoLbl,coloredView;

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)initWithContactObj:(ContactObj*)obj withRowIndex:(int)rowID{
    cObj=obj;
    contactNameLbl.text=cObj.contactName;
    phoneNoLbl.text=cObj.phoneNo;
    
    if(rowID%2==0)
        self.contentView.backgroundColor=[UIColor whiteColor];
    else
        self.contentView.backgroundColor=[UIColor colorWithRed:248.0/255.0 green:248.0/255.0 blue:248.0/255.0 alpha:1];
    
    NSMutableArray *colors=[StaticFuntions getColors];
    int mod= rowID%((int)[colors count]);
    coloredView.backgroundColor=(UIColor*)[colors objectAtIndex:mod];
}

-(IBAction)onPhonePressed:(id)sender{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",cObj.phoneNo]];
    [[UIApplication  sharedApplication] openURL:url];
}

@end
