//
//  CustodyTableViewCell.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 1/5/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustodyObj.h"

@interface CustodyTableViewCell : UITableViewCell{
    UILabel *remarksLbl;
    UILabel *dateLbl;
    UILabel *descriptionLbl;
    UIView * colorView;
    UILabel *amountLblText;
}

@property (nonatomic,retain) IBOutlet UILabel *remarksLbl;
@property (nonatomic,retain) IBOutlet UILabel *dateLbl;
@property (nonatomic,retain) IBOutlet UILabel *descriptionLbl;

@property (nonatomic,retain) IBOutlet UIView * colorView;
@property (nonatomic,retain) IBOutlet UILabel *amountLblText;

-(void)initWithCustodyObj:(CustodyObj*)obj withRowIndex:(int)rowId;
@end
