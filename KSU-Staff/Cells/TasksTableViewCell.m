//
//  TasksTableViewCell.m
//  KSU-Staff
//
//  Created by EJ-Mac book on 11/16/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import "TasksTableViewCell.h"
#import "StaticFuntions.h"
#import "LocalizedMessages.h"

@implementation TasksTableViewCell

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

-(void) initWithTaskObj:(TaskObj *)obj withRowId:(int)index{
    tObj=obj;
    titleLbl.textColor=[StaticFuntions getTableLableColor];
    valueLbl.textColor=[StaticFuntions getTableValueColor];
    
    switch (index) {
        case Department_TSItem:
            titleLbl.backgroundColor=[StaticFuntions getTableCellBGColor_OddRow_Title];
            valueLbl.backgroundColor=[StaticFuntions getTableCellBGColor_OddRow_Value];
            titleLbl.text=TaskDeptText;
            valueLbl.text=tObj.department;
            break;
        case Date_TSItem:
            titleLbl.backgroundColor=[StaticFuntions getTableCellBGColor_EvenRow_Title];
            valueLbl.backgroundColor=[StaticFuntions getTableCellBGColor_EvenRow_Value];
            titleLbl.text=TaskDateText;
            valueLbl.text=tObj.date;
            break;
        case Status_TSItem:
            titleLbl.backgroundColor=[StaticFuntions getTableCellBGColor_OddRow_Title];
            valueLbl.backgroundColor=[StaticFuntions getTableCellBGColor_OddRow_Value];
            titleLbl.text=TaskStatusText;
            valueLbl.text=tObj.status;
            break;
        case Remarks_TSItem:
            titleLbl.backgroundColor=[StaticFuntions getTableCellBGColor_EvenRow_Title];
            valueLbl.backgroundColor=[StaticFuntions getTableCellBGColor_EvenRow_Value];
            titleLbl.text=TaskRemarksText;
            valueLbl.text=tObj.remarks;
            break;
        default:
            break;
    }
}

@end
