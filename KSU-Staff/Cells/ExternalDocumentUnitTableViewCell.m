//
//  TasksTableViewCell.m
//  KSU-Staff
//
//  Created by EJ-Mac book on 11/16/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import "ExternalDocumentUnitTableViewCell.h"
#import "StaticFuntions.h"
#import "LocalizedMessages.h"

@implementation ExternalDocumentUnitTableViewCell

@synthesize titleLbl;
@synthesize IDLbl;

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) initWithExternalDocumentUnitObj:(ExternalDocumentUnitObj*)obj withRowId:(int)index{
    eObj=obj;
    titleLbl.textColor=[StaticFuntions getTableLableColor];
    IDLbl.textColor=[StaticFuntions getTableValueColor];
    
    /*if (index % 2 == 0) {
        self.backgroundColor=[StaticFuntions getTableCellBGColor_OddRow_Title];
    }
    else
    {
        self.backgroundColor=[StaticFuntions getTableCellBGColor_EvenRow_Title];
    }*/
    
    self.backgroundColor=[UIColor whiteColor];
    
    /*if (index % 2 == 0)
    {
        self.backgroundColor = [UIColor greenColor];
    }
    else
    {
        self.backgroundColor = [UIColor redColor];
    }*/
    
    titleLbl.text=eObj.ExternalUnitName;
    IDLbl.text=eObj.ExternalUnitCode;
    
    titleLbl.adjustsFontSizeToFitWidth = YES;
    IDLbl.adjustsFontSizeToFitWidth = YES;

}

@end
