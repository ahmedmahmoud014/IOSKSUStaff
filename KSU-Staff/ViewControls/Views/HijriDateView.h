//
//  HijriDateView.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 10/22/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NTMonthYearPicker.h"

@protocol HijriDateDelegate <NSObject>

-(void)onSelectDate:(NSDate*)selectedDate;

@end
@interface HijriDateView : UIView{
    NTMonthYearPicker *picker;
    UIToolbar *toolBar;
    UIBarButtonItem *cancelBtn;
    UIBarButtonItem *doneBtn;
    UIToolbar *toolBarArabic;
    UIBarButtonItem *cancelBtnArabic;
    UIBarButtonItem *doneBtnArabic;
    
    id delegate;
}

@property (nonatomic,retain)IBOutlet NTMonthYearPicker *picker;
@property (nonatomic,retain)IBOutlet UIToolbar *toolBar;
@property (nonatomic,retain)IBOutlet UIBarButtonItem *cancelBtn;
@property (nonatomic,retain)IBOutlet UIBarButtonItem *doneBtn;


-(void)initIslamicDateWithMonths:(BOOL)withMonths withDay:(BOOL)withDay withDelegate:(id)del  withMaxDate:(BOOL)withMaxDate withMinDate:(BOOL)withMinDate isForceHijri:(BOOL)isForceHijri;

-(void) toolbarAlignment;
-(IBAction)onDonePressed:(id)sender;
-(IBAction)onCancelPressed:(id)sender;

@end
