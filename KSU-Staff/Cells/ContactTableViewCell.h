//
//  ContactTableViewCell.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 11/18/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactObj.h"

@interface ContactTableViewCell : UITableViewCell{
    UILabel *phoneNoLbl;
    UILabel *contactNameLbl;
    UIButton *phoneBtn;
    ContactObj *cObj;
    UIView *coloredView;
}

@property (nonatomic,retain)IBOutlet UILabel *phoneNoLbl;
@property (nonatomic,retain)IBOutlet UILabel *contactNameLbl;
@property (nonatomic,retain)IBOutlet UIButton *phoneBtn;
@property (nonatomic,retain)IBOutlet UIView *coloredView;

-(void)initWithContactObj:(ContactObj*)obj withRowIndex:(int)rowID;

-(IBAction)onPhonePressed:(id)sender;
@end
