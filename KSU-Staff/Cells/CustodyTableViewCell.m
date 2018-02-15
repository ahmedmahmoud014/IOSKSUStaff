//
//  CustodyTableViewCell.m
//  KSU-Staff
//
//  Created by EJ-Mac book on 1/5/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "CustodyTableViewCell.h"
#import "StaticFuntions.h"
#import "LocalizedMessages.h"

@implementation CustodyTableViewCell
@synthesize descriptionLbl,remarksLbl,dateLbl;
@synthesize colorView;
@synthesize amountLblText;

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)initWithCustodyObj:(CustodyObj*)obj withRowIndex:(int)rowId{
    /*UIColor *bGcolor=[StaticFuntions getTableGridBGColor_odd];//[UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:1];
    if(rowId%2==0){
        bGcolor=[StaticFuntions getTableGridBGColor_even];//[UIColor colorWithRed:231.0/255.0 green:237.0/255.0 blue:240.0/255.0 alpha:1];
    }*/
    
    NSMutableArray * arr=[StaticFuntions getColors];
    int numberOfRows=(int)[arr count]-1;
    int mod=rowId %numberOfRows;
    colorView.backgroundColor= (UIColor*)[arr objectAtIndex:mod];
    
    
    descriptionLbl.text=obj.cust_desc;
    dateLbl.text=obj.cust_quantity;
    remarksLbl.text=obj.cust_remarks;
    
    descriptionLbl.textColor=[StaticFuntions getTableLableColor];
   // dateLbl.textColor=[StaticFuntions getTableLableColor];
   // remarksLbl.textColor=[StaticFuntions getTableLableColor];
    
    amountLblText.text= custodyQuantityText;
   // self.contentView.backgroundColor=bGcolor;
}

@end
