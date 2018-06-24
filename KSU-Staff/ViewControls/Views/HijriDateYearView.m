//
//  HijriDateYearView.m
//  KSU-Staff
//
//  Created by EJ-Mac book on 10/22/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import "HijriDateYearView.h"
#import "LocalizedMessages.h"
#import "StaticFuntions.h"
#import "AppDelegate.h"

@implementation HijriDateYearView
@synthesize yearPicker,toolBar,cancelBtn,doneBtn;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(void)initIslamicDatewithDelegate:(id)del{
    toolBar.barTintColor=[StaticFuntions getTableSectionBGColor];
    
    NSCalendar *calendar;
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(appDelegate.currentLang==English)
        calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    else
        calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierIslamicUmmAlQura];
    
    NSDate *today = [NSDate date];
    //here
    
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&today interval:NULL forDate:today];
    //yearPicker = [[NTYearPicker alloc] init];
    [yearPicker setCalendar:calendar];
    [yearPicker setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ar"]];
    [yearPicker setMaximumDate:today];
    
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:1431];
    NSDate *fromDate=[calendar dateFromComponents:comps];
    [yearPicker setMinimumDate:fromDate];
    delegate=del;
    
    cancelBtn.title=CancelButtonText;
    doneBtn.title=OKayButtonText;

     
}

#pragma mark - events
-(IBAction)onDonePressed:(id)sender{
    if([ delegate respondsToSelector:@selector(onSelectDate:)]) {
        [delegate onSelectDate:yearPicker.date];
    }
}

-(IBAction)onCancelPressed:(id)sender{
    if([ delegate respondsToSelector:@selector(onSelectDate:)]) {
        [delegate onSelectDate:nil];
    }

}


@end
