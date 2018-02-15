//
//  RequestsTableViewCell.m
//  KSU_Students
//
//  Created by EJ-Mac book on 8/2/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "RequestRowDetailsTableViewCell.h"
#import "LocalizedMessages.h"
#import "AppDelegate.h"

@implementation RequestRowDetailsTableViewCell

@synthesize title1Lbl;
@synthesize value1Lbl;
@synthesize title2Lbl;
@synthesize value2Lbl;
@synthesize detailsBtn;
@synthesize separatorView;

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)initWithRequestRowItemsObj:(RPageSectionRowObj*)obj1 obj2:(RPageSectionRowObj*)obj2 withRowId:(int)rowId withHeight:(int)height{
    
    title1Lbl.numberOfLines = 1000;
    value1Lbl.numberOfLines = 1000;
    
    title2Lbl.numberOfLines = 1000;
    value2Lbl.numberOfLines = 1000;
    
    
    title1Lbl.text=obj1.label;
    value1Lbl.text=obj1.singleValue;
    
    title2Lbl.text=obj2.label;
    value2Lbl.text=obj2.singleValue;
    
    CGRect frame;
    
    [self setFrames:title1Lbl valueLbl:value1Lbl obj:obj1 setYPos:FALSE];
    [self setFrames:title2Lbl valueLbl:value2Lbl obj:obj2 setYPos:YES];
    
    frame = separatorView.frame;
    frame.origin.y = height - 1;
    separatorView.frame = frame;
    
    
    frame = detailsBtn.frame;
    frame.origin.y = (height - detailsBtn.frame.size.height) / 2;
    detailsBtn.frame = frame;
    
    
    
}

-(void)setFrames:(UILabel *)titleLbl valueLbl:(UILabel *)valueLbl obj:(RPageSectionRowObj*)obj setYPos:(BOOL)setYPos{

    CGRect frame;
    if ([obj.dataType isEqualToString:@"labelText"] || [obj.dataType isEqualToString:@"labelTextarea"] || [obj.dataType isEqualToString:@"noData"]) {
        titleLbl.hidden = YES;
        frame = valueLbl.frame;
        frame.size.width += titleLbl.frame.size.width + 8;
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        if(appDelegate.currentLang==English)
            frame.origin.x = 3;
        
        valueLbl.frame = frame;
        valueLbl.textAlignment = NSTextAlignmentCenter;
    }
    CGRect newFrame = titleLbl.frame;
    CGSize newSize = [titleLbl sizeThatFits:CGSizeMake(titleLbl.frame.size.width, MAXFLOAT)];
    newFrame.size = CGSizeMake(fmaxf(newSize.width, titleLbl.frame.size.width), newSize.height);
    NSInteger difference1 = (newFrame.size.height) - titleLbl.frame.size.height;
    
    newFrame = valueLbl.frame;
    newSize = [valueLbl sizeThatFits:CGSizeMake(valueLbl.frame.size.width, MAXFLOAT)];
    newFrame.size = CGSizeMake(fmaxf(newSize.width, valueLbl.frame.size.width), newSize.height);
    NSInteger difference2 = (newFrame.size.height) - valueLbl.frame.size.height;
    
    NSInteger height;
    
    if (difference1 > difference2)
        height = valueLbl.frame.size.height + 10 + difference1;
    else
        height = valueLbl.frame.size.height + 10 + difference2;
    
    CGFloat yPos = 3;
    if (setYPos)
        yPos = value1Lbl.frame.origin.y + value1Lbl.frame.size.height + 3;
    
    frame = valueLbl.frame;
    frame.size.height = height;
    frame.origin.y = yPos;
    valueLbl.frame = frame;
    
    frame = titleLbl.frame;
    frame.size.height = height;
    frame.origin.y = yPos;
    titleLbl.frame = frame;
    
    
    
}

@end
