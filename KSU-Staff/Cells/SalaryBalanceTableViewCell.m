//
//  SalaryBalanceTableViewCell.m
//  KSU-Staff
//
//  Created by EJ-Mac book on 10/19/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import "SalaryBalanceTableViewCell.h"
#import "LocalizedMessages.h"
#import "StaticFuntions.h"

@implementation SalaryBalanceTableViewCell

@synthesize codeLbl;
@synthesize descriptionLbl;
@synthesize valueLbl;
@synthesize imageView;

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)initWithSalaryDetailsObj:(SalaryDetailsObj*)salary withRowIndex:(int)rowID{
    sDet_Obj=salary;
    if(rowID==0){
        UIColor *bGcolor=[StaticFuntions getTableHeaderBGColor];//[UIColor colorWithRed:288.0/255.0 green:288.0/255.0 blue:288.0/255.0 alpha:1];
        codeLbl.text=CodeText;
        codeLbl.backgroundColor=bGcolor;
        
        
        descriptionLbl.text=DescriptionText;
        descriptionLbl.backgroundColor=bGcolor;
        
        
        valueLbl.text=ValueText;
        valueLbl.backgroundColor=bGcolor;
        
        codeLbl.textColor=[StaticFuntions getTableValueColor];
        valueLbl.textColor=[StaticFuntions getTableValueColor];
        descriptionLbl.textColor=[StaticFuntions getTableValueColor];
        self.contentView.backgroundColor=bGcolor;
        imageView.hidden=NO;
    }else{
        UIColor *bGcolor=[StaticFuntions getTableGridBGColor_even];//[UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:1];
        if(rowID%2==0){
            bGcolor=[StaticFuntions getTableGridBGColor_odd];//[UIColor colorWithRed:231.0/255.0 green:237.0/255.0 blue:240.0/255.0 alpha:1];
        }
        
        
        codeLbl.text=sDet_Obj.code;
        codeLbl.backgroundColor=bGcolor;
        
        descriptionLbl.text=sDet_Obj.description;
        descriptionLbl.backgroundColor=bGcolor;
        
        valueLbl.text=sDet_Obj.value;
        valueLbl.backgroundColor=bGcolor;
        
        imageView.hidden=YES;
        
        codeLbl.textColor=[StaticFuntions getTableLableColor];
        descriptionLbl.textColor=[StaticFuntions getTableLableColor];
        
        if(sDet_Obj.isAllowance)
            valueLbl.textColor=[StaticFuntions getPostiveValueColor];
        else
            valueLbl.textColor=[StaticFuntions getNegativeValueColor];
    }
}
@end
