//
//  CalendarTableViewCell.m
//  KSU-Staff
//
//  Created by EJ-Mac book on 11/13/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import "CalendarTableViewCell.h"
#import <QuartzCore/QuartzCore.h>
#import "LocalizedMessages.h"
#import "StaticFuntions.h"

@implementation CalendarTableViewCell
@synthesize eventLbl;
@synthesize fromLbl;
@synthesize fromTextLbl;
@synthesize toLbl;
@synthesize toTextLbl;

@synthesize fristCircle;
@synthesize secondCircle;
@synthesize circlesSepalator;

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - methods

-(void)initWithCalendarObj:(CalendarObj*)obj withRowIndex:(int)row{
    self.secondCircle.layer.cornerRadius = 5;
    self.fristCircle.layer.cornerRadius = 5;
    eventLbl.text= obj.event;
    fromLbl.text=obj.hijriDate;
    toLbl.text=obj.georgDate;
    
    fromTextLbl.text=DateFromText;
    toTextLbl.text=DateToText;
    
    NSMutableArray * arr=[StaticFuntions getColors];
    int numberOfRows=((int)[arr count])/2.0;
    int mod=row%numberOfRows;
    self.fristCircle.backgroundColor=(UIColor*)[arr objectAtIndex:mod*2];
  
    self.secondCircle.backgroundColor=(UIColor*)[arr objectAtIndex:(mod*2+1)];
}

@end
