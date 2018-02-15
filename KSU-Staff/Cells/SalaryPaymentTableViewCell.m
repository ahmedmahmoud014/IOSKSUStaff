//
//  SalaryPaymentTableViewCell.m
//  KSU-Staff
//
//  Created by EJ-Mac book on 10/19/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import "SalaryPaymentTableViewCell.h"
#import "LocalizedMessages.h"
#import "StaticFuntions.h"

@implementation SalaryPaymentTableViewCell

@synthesize titleLbl,valueLbl;

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)initWithSalaryObj:(SalaryObj*)salary withIndexPath:(NSIndexPath *)indexPath withSection:(SalarySections)section{
    sObj=salary;
    titleLbl.textColor=[StaticFuntions getTableLableColor];
    valueLbl.textColor= [StaticFuntions getTableValueColor];
    if(section==PaymentInfo_sec){
        switch ((int)indexPath.row) {
            case (int)Date_SPInfo:
                titleLbl.text=DateText;
                valueLbl.text=sObj.date;
                //titleLbl.backgroundColor=[StaticFuntions getTableCellBGColor_OddRow_Title];//[UIColor colorWithRed:218.0/255.0 green:221.0/255.0 blue:223.0/255.0 alpha:1];
                //valueLbl.backgroundColor=[StaticFuntions getTableCellBGColor_OddRow_Value];//[UIColor colorWithRed:233.0/255.0 green:233.0/255.0 blue:233.0/255.0 alpha:1];
                break;
            case (int)Type_SPInfo:
                titleLbl.text=TypeText;
                valueLbl.text=sObj.type;
                //  titleLbl.backgroundColor=[StaticFuntions getTableCellBGColor_EvenRow_Title];//[UIColor colorWithRed:243.0/255.0 green:243.0/255.0 blue:243.0/255.0 alpha:1];
                //  valueLbl.backgroundColor=[StaticFuntions getTableCellBGColor_EvenRow_Value];//[UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1];
                break;
            case (int)Bank_SPInfo:
                titleLbl.text=BankText;
                valueLbl.text=sObj.bankName;
                ///titleLbl.backgroundColor=[StaticFuntions getTableCellBGColor_OddRow_Title];//[UIColor colorWithRed:218.0/255.0 green:221.0/255.0 blue:223.0/255.0 alpha:1];
                //valueLbl.backgroundColor=[StaticFuntions getTableCellBGColor_OddRow_Value];//[UIColor colorWithRed:233.0/255.0 green:233.0/255.0 blue:233.0/255.0 alpha:1];
                break;
                
            default:
                break;
        }
    }else if(section==Allowances_sec){
        titleLbl.text=((SalaryDetailsObj*)[salary.allowanceArr objectAtIndex:(int)indexPath.row]).description;
        valueLbl.text=((SalaryDetailsObj*)[salary.allowanceArr objectAtIndex:(int)indexPath.row]).value;
    }else if(section==Deductions_sec){
        titleLbl.text=((SalaryDetailsObj*)[salary.deductionArr objectAtIndex:(int)indexPath.row]).description;
        valueLbl.text=((SalaryDetailsObj*)[salary.deductionArr objectAtIndex:(int)indexPath.row]).value;
    }
}

@end
