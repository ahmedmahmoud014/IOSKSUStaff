//
//  NTMonthYearPicker.h
//  NTMonthYearPicker
//
//  Created by Arun Nair on 10/29/13.
//  Copyright (c) 2013 Arun Nair. All rights reserved.
//
//  http://github.com/nairteashop/NTMonthYearPicker
//

#import <UIKit/UIKit.h>


typedef enum {
    NTMonthYearPickerModeMonthAndYear,        // Display month and year
    NTMonthYearPickerModeDayMonthAndYear,     // Display Day, month and year
    NTMonthYearPickerModeYear                 // Display just the year
} NTMonthYearPickerMode;

//
// NTMonthYearPickerViewDelegate
//

@protocol NTMonthYearPickerViewDelegate
- (void)didSelectDate;
@end

//
// NTMonthYearPickerView
//
@interface NTMonthYearPickerView : UIPickerView <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic) NTMonthYearPickerMode datePickerMode;
@property (nonatomic, retain) NSLocale *locale;
@property (nonatomic, copy) NSCalendar *calendar;
@property (nonatomic, retain) NSDate *date;
@property (nonatomic, retain) NSDate *minimumDate;
@property (nonatomic, retain) NSDate *maximumDate;
@property (nonatomic,assign) id<NTMonthYearPickerViewDelegate> pickerDelegate;
@property (nonatomic, retain) NSString *isForceHijri;

- (void)setDate:(NSDate *)date animated:(BOOL)animated;

@end

@interface NTMonthYearPicker : UIControl <NSCoding>

// The mode of the date picker - see the NTMonthYearPickerMode enum
// Default is NTMonthYearPickerModeMonthAndYear
@property (nonatomic) NTMonthYearPickerMode datePickerMode;

// The locale used by the date picker
// Default is [NSLocale currentLocale]. Setting nil returns to default
@property (nonatomic, retain) NSLocale *locale;

// The calendar to use for the date picker
// Default is [NSCalendar currentCalendar]. Setting nil returns to default
@property (nonatomic, copy) NSCalendar *calendar;

// The date displayed by the date picker
// Default is current date when picker is created
@property (nonatomic, retain) NSDate *date;

// The minimum date that the date picker should show
// Default is nil (Jan 1, 0001 in the UI)
@property (nonatomic, retain) NSDate *minimumDate;

// The maximum date that the date picker should show
// Default is nil (Dec 31, 10000 in the UI)
@property (nonatomic, retain) NSDate *maximumDate;

@property (nonatomic, retain) NSString *isForceHijri;
@property (nonatomic, retain) NTMonthYearPickerView *pickerView;

// Sets the date to display in the date picker
// If animated is YES, animate the wheels to display the new date
- (void)setDate:(NSDate *)date animated:(BOOL)animated;

@end
