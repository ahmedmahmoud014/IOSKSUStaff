//
//  HijriDateView.m
//  KSU-Staff
//
//  Created by EJ-Mac book on 10/22/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import "HijriDateView.h"
#import "LocalizedMessages.h"
#import "StaticFuntions.h"
#import "AppDelegate.h"

@implementation HijriDateView
@synthesize picker,toolBar,cancelBtn,doneBtn;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)toolbarAlignment{

    UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    flexible.width = 600.0f;
    
AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(appDelegate.currentLang==English){
        toolBar.items = [NSArray arrayWithObjects:doneBtn , flexible,cancelBtn , nil];

    }else {
        toolBar.items = [NSArray arrayWithObjects: cancelBtn, flexible, doneBtn, nil];
    }
    }

-(void)initIslamicDateWithMonths:(BOOL)withMonths withDay:(BOOL)withDay withDelegate:(id)del  withMaxDate:(BOOL)withMaxDate withMinDate:(BOOL)withMinDate isForceHijri:(BOOL)isForceHijri{
    toolBar.barTintColor=[StaticFuntions getTableSectionBGColor];
    
    delegate=del;
    NSCalendar *calendar;
    
    //self.picker = [[NTMonthYearPicker alloc] init];
    
    
    
    if (isForceHijri) {
        calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierIslamicUmmAlQura];
    }
    else
    {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        if(appDelegate.currentLang==English)
            calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        else
            calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierIslamicUmmAlQura];
    }
    
    
    
    
    NSDate *today = [NSDate date];
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&today interval:NULL forDate:today];
    
    if (isForceHijri) {
        [self.picker setIsForceHijri:@"YES"];
    }
    else
    {
        [self.picker setIsForceHijri:@"FALSE"];
    }
    [self.picker setCalendar:calendar ];
    [self.picker setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ar"]];
   
    
    if (withMaxDate) {
        [self.picker setMaximumDate:today];
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        [comps setYear:1431];
        NSDate *fromDate=[calendar dateFromComponents:comps];
        [self.picker setMinimumDate:fromDate];
        
    }
    else if (withMinDate)
        [self.picker setMinimumDate:today];
    else{
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        [comps setYear:1400];
        NSDate *fromDate=[calendar dateFromComponents:comps];
        [self.picker setMinimumDate:fromDate];
    }
    cancelBtn.title=CancelButtonText;
    doneBtn.title=OKayButtonText;
    if(withMonths && !withDay)
        [self.picker setDatePickerMode:NTMonthYearPickerModeMonthAndYear];
        //picker.datePickerMode=NTMonthYearPickerModeMonthAndYear;
    else if(withMonths && withDay)
        //picker.datePickerMode=NTMonthYearPickerModeDayMonthAndYear;
        [self.picker setDatePickerMode:NTMonthYearPickerModeDayMonthAndYear];
    else
        [self.picker setDatePickerMode:NTMonthYearPickerModeYear];
        //picker.datePickerMode=NTMonthYearPickerModeYear;*/
    
    
    
}

#pragma mark - events
-(IBAction)onDonePressed:(id)sender{
    if([ delegate respondsToSelector:@selector(onSelectDate:)]) {
    
//
//        NSDate *currentDate = self.picker.date;
//        NSCalendar* calendar = [NSCalendar currentCalendar];
//        NSDateComponents* components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:currentDate]; // Get necessary date components
//
//        components.month = [components month]+1;
//        [components day]; //gives you day
//        [components year];
//        [components hour];
//        [components minute];
//        [components second];
//
//        NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
//        NSDate *date = [cal dateFromComponents:components];
//
//        NSLog(@"month is %ld",(long)components.month );
//
//
        
        [delegate onSelectDate: self.picker.date];
    }
}

-(IBAction)onCancelPressed:(id)sender{
    if([ delegate respondsToSelector:@selector(onSelectDate:)]) {
        [delegate onSelectDate:nil];
    }

}


@end
