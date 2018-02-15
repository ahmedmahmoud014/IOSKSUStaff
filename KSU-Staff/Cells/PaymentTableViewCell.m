//
//  PaymentTableViewCell.m
//  KSU-Staff
//
//  Created by EJ-Mac book on 10/22/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import "PaymentTableViewCell.h"
#import "StaticFuntions.h"
#import "LocalizedMessages.h"

@implementation PaymentTableViewCell

@synthesize titleLbl;
@synthesize valueLbl;

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) initWithPaymentDetObj:(PaymentDetailsObj*)obj withRowId:(int)index{
    pDetObj=obj;
    titleLbl.textColor=[StaticFuntions getTableLableColor];
    valueLbl.textColor=[StaticFuntions getTableValueColor];

    switch (index) {
        case Number_PSItem:
            //titleLbl.backgroundColor=[StaticFuntions getTableCellBGColor_OddRow_Title];
            //valueLbl.backgroundColor=[StaticFuntions getTableCellBGColor_OddRow_Value];
            titleLbl.text=PaymentItemNumberText;
            valueLbl.text=pDetObj.number;
            break;
        case Description_PSItem:
           // titleLbl.backgroundColor=[StaticFuntions getTableCellBGColor_EvenRow_Title];
            //valueLbl.backgroundColor=[StaticFuntions getTableCellBGColor_EvenRow_Value];
            titleLbl.text=PaymentItemDescripText;
            valueLbl.text=pDetObj.description;
            break;
       /* case Amount_PSItem:
           // titleLbl.backgroundColor=[StaticFuntions getTableCellBGColor_OddRow_Title];
           // valueLbl.backgroundColor=[StaticFuntions getTableCellBGColor_OddRow_Value];
            titleLbl.text=PaymentItemAmountText;
            valueLbl.text=pDetObj.amount;
            break;
       */case Date_PSItem:
            //titleLbl.backgroundColor=[StaticFuntions getTableCellBGColor_EvenRow_Title];
            //valueLbl.backgroundColor=[StaticFuntions getTableCellBGColor_EvenRow_Value];
            titleLbl.text=PaymentItemDateText;
            valueLbl.text=pDetObj.date;
            break;
        case Indicator_PSItem:
           // titleLbl.backgroundColor=[StaticFuntions getTableCellBGColor_OddRow_Title];
           // valueLbl.backgroundColor=[StaticFuntions getTableCellBGColor_OddRow_Value];
            titleLbl.text=PaymentItemIndicatorText;
            valueLbl.text=pDetObj.idicator;
            break;
        default:
            break;
    }
}

@end
