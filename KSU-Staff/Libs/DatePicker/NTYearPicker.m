//
//  NTYearPicker.m
//  NTYearPicker
//
//  Created by Arun Nair on 10/29/13.
//  Copyright (c) 2013 Arun Nair. All rights reserved.
//
//  http://github.com/nairteashop/NTYearPicker
//

#import "NTYearPicker.h"
#import "AppDelegate.h"

//
// NTYearPickerViewDelegate
//

@protocol NTYearPickerViewDelegate
- (void)didSelectDate;
@end

//
// NTYearPickerView
//

@interface NTYearPickerView : UIPickerView <UIPickerViewDataSource, UIPickerViewDelegate>


@property (nonatomic, retain) NSLocale *locale;
@property (nonatomic, copy) NSCalendar *calendar;
@property (nonatomic, retain) NSDate *date;
@property (nonatomic, retain) NSDate *minimumDate;
@property (nonatomic, retain) NSDate *maximumDate;
@property (nonatomic,assign) id<NTYearPickerViewDelegate> pickerDelegate;

- (void)setDate:(NSDate *)date animated:(BOOL)animated;

@end

@implementation NTYearPickerView

@synthesize locale = _locale;
@synthesize calendar = _calendar;
@synthesize date = _date;
@synthesize minimumDate;
@synthesize maximumDate;
@synthesize pickerDelegate;

// Picker data (list of days,months and years)
NSArray *_days;
NSArray *_months;
NSArray *_years;

// Cached min/max year/month values
// We do this to avoid expensive NSDateComponents-based date math in pickerView:viewForRow
NSInteger _minimumYear2 = -1;
NSInteger _maximumYear2 = -1;


// Default min/max year values used if minimumDate/maximumDate is not set
// These values match that of UIDatePicker
const NSInteger kMinYear2 = 1431;
const NSInteger kMaxYear2 = 1439;

#pragma mark - Initialization

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initCommon];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initCommon];
    }
    return self;
}

- (void)initCommon {
    self.dataSource = self;
    self.delegate = self;
    self.showsSelectionIndicator = YES;

    // Initialize picker data
    [self initPickerData];

    // Set default date to today
    _date = [NSDate date];
}

- (void)initPickerData {
    // Form list of months
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:self.locale];
    
    NSCalendar *calendar;
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(appDelegate.currentLang==English)
        calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    else
        calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierIslamicUmmAlQura];
    
    

    NSDate *today = [NSDate date];
    
    
    
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&today interval:NULL forDate:today];
    self.calendar= calendar;

    [dateFormatter setCalendar:self.calendar];
    
    if(appDelegate.currentLang==English){
        //english output
        dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    }else if(appDelegate.currentLang==Arabic){
        //english output
        dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ar"];
    }

    _months = [dateFormatter monthSymbols];
    
    if(appDelegate.currentLang==English){
    
        _days = [[NSArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30", nil];
    }
    else
    {
        _days = [[NSArray alloc] initWithObjects:@"١",@"٢",@"٣",@"٤",@"٥",@"٦",@"٧",@"٨",@"٩",@"١٠",@"١١",@"١٢",@"١٣",@"١٤",@"١٥",@"١٦",@"١٧",@"١٨",@"١٩",@"٢٠",@"٢١",@"٢٢",@"٢٣",@"٢٤",@"٢٥",@"٢٦",@"٢٧",@"٢٨",@"٢٩",@"٣٠", nil];
    }
    

    // Form list of years
    [dateFormatter setDateFormat:@"yyyy"];
    NSDateComponents *comps = [[NSDateComponents alloc] init];

    NSMutableArray *years = [[NSMutableArray alloc] init];
    
if(appDelegate.currentLang==Arabic){
    
    for( int year = kMinYear2 ; year <= kMaxYear2 ; ++year ) {
        [comps setYear:year];
        NSDate *yearDate = [self.calendar dateFromComponents:comps];
        NSString *yearStr = [dateFormatter stringFromDate:yearDate];

        [years addObject:yearStr];
    }
}else {
    [years addObject:@"2010"];
    [years addObject:@"2011"];
    [years addObject:@"2012"];
    [years addObject:@"2013"];
    [years addObject:@"2014"];
    [years addObject:@"2015"];
    [years addObject:@"2016"];
    [years addObject:@"2017"];
    [years addObject:@"2018"];

}
    _years = years;
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    
    // Set initial picker selection
    [self selectionFromDate:FALSE];
}

#pragma mark - Date picker mode



#pragma mark - Locale

- (NSLocale *)locale {
    if( _locale == nil ) {
        _locale = [self.calendar locale];
    }
    return _locale;
}

- (void)setLocale:(NSLocale *)locale{
    _locale = locale;
}

#pragma mark - Calendar

- (NSCalendar *)calendar {
    if( _calendar == nil ) {
        _calendar = [NSCalendar currentCalendar];
    }
    return _calendar;
}

- (void)setCalendar:(NSCalendar *)cal {
    _calendar = cal;
}

#pragma mark - Date

- (NSDate *)date {
    return _date;
}

- (void)setDate:(NSDate *)dt {
    [self setDate:dt animated:FALSE];
}

- (void)setDate:(NSDate *)date animated:(BOOL)animated {
    _date = date;
    [self selectionFromDate:animated];
}

#pragma mark - Min / Max date

- (void)setMinimumDate:(NSDate *)minDate {
    minimumDate = minDate;

    // Pre-calculate min year & month
    if( minimumDate != nil ) {
        NSDateComponents *comps = [self.calendar components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:minimumDate];
        _minimumYear2 = comps.year;
    } else {
        _minimumYear2 = -1;
    }

    
    [self reloadAllComponents];
}

- (void)setMaximumDate:(NSDate *)maxDate {
    maximumDate = maxDate;

    
    // Pre-calculate max year & month
    if( maximumDate != nil ) {
        NSDateComponents *comps = [self.calendar components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:maximumDate];
        _maximumYear2 = comps.year;
    
    } else {
        _maximumYear2 = -1;

    }

    [self reloadAllComponents];
}

#pragma mark - Date <-> selection

- (void)selectionFromDate:(BOOL)animated {
    // Extract the month and year from the current date value
    NSDateComponents* comps = [self.calendar components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:self.date];
    NSInteger year = [comps year];
    

    [self selectRow:(year - kMinYear2) inComponent:0 animated:animated];
}

- (NSDate *)dateFromSelection {
    NSInteger day, month, year;


        day = 1;
        month = 1;
        year  = [self selectedRowInComponent:0] + kMinYear2;

    // Assemble into a date object
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:day];
    [comps setMonth:month];
    [comps setYear:year];

    return [self.calendar dateFromComponents:comps];
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {

        return 1;

}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{

        return [_years count];
}

#pragma mark - UIPickerViewDelegate

- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row
          forComponent:(NSInteger)component
           reusingView:(UIView *)view {
    // Create (or reuse) the label instance
    UILabel *label = (UILabel *)view;
    if( label == nil ) {
        CGSize rowSize = [pickerView rowSizeForComponent:component];
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, rowSize.width, rowSize.height)];
        label.font = [UIFont systemFontOfSize:24];
        label.textAlignment = NSTextAlignmentCenter;
        label.adjustsFontSizeToFitWidth = YES;
    }


    BOOL outOfBounds = FALSE;

        int year = (int)row + kMinYear2;
    

        if( ((maximumDate != nil) && (year > _maximumYear2)) ||
           ((minimumDate != nil) && (year < _minimumYear2)) ) {
            outOfBounds = TRUE;
        }
        label.text = [_years objectAtIndex:row];
        

    
    // Set label text & color
    
    label.textColor = (outOfBounds ? [UIColor grayColor] : [UIColor blackColor]);

    return label;
}

- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component {
    // Update date value
    _date = [self dateFromSelection];

    // If the currently selected date < the min date, reset it to the min date
    if( (minimumDate != nil) && ([self compareMonthYear:self.date with:minimumDate] == NSOrderedAscending) ) {
        [self setDate:minimumDate animated:TRUE];
    }

    // If the currently selected date > the min date, reset it to the max date
    if( (maximumDate != nil) && ([self compareMonthYear:self.date with:maximumDate] == NSOrderedDescending) ) {
        [self setDate:maximumDate animated:TRUE];
    }

    // If the year was changed, reload the month picker
    // This is to refresh the enabled/disabled state of the months


        [self reloadComponent:0];

    // Notify delegate
    [pickerDelegate didSelectDate];
}

- (NSComparisonResult)compareMonthYear:(NSDate *)firstDate with:(NSDate *)secondDate {
    NSDateComponents *comps = [self.calendar components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:firstDate];
    firstDate = [self.calendar dateFromComponents:comps];

    comps = [self.calendar components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:secondDate];
    secondDate = [self.calendar dateFromComponents:comps];

    return [firstDate compare:secondDate];
}

@end

//
// NTYearPicker
//

@interface NTYearPicker (Delegate) <NTYearPickerViewDelegate>
@end

@implementation NTYearPicker

@synthesize locale;
@synthesize calendar;
@synthesize date;
@synthesize minimumDate;
@synthesize maximumDate;

NTYearPickerView *_pickerView2;

#pragma mark - Initialization

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _pickerView2 = [[NTYearPickerView alloc] initWithFrame:frame];
        [self initCommon];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _pickerView2 = [[NTYearPickerView alloc] initWithCoder:aDecoder];

        CGSize pickerSize = [_pickerView2 sizeThatFits:CGSizeZero];
        _pickerView2.frame = CGRectMake( 0, 0, pickerSize.width, pickerSize.height );

        [self initCommon];
    }
    return self;
}

- (void)initCommon {
    self.frame = _pickerView2.frame;
    _pickerView2.pickerDelegate = self;
    [self addSubview:_pickerView2];
}

- (CGSize)sizeThatFits:(CGSize)size {
    return [_pickerView2 sizeThatFits:size];
}

- (void)didSelectDate {
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

#pragma mark - NTYearPicker API

- (NSLocale *)locale {
    return _pickerView2.locale;
}

- (void)setLocale:(NSLocale *)loc {
    _pickerView2.locale = loc;
}

- (NSCalendar *)calendar {
    return _pickerView2.calendar;
}

- (void)setCalendar:(NSCalendar *)cal {
    _pickerView2.calendar = cal;
}

- (NSDate *)date {
    return _pickerView2.date;
}

- (void)setDate:(NSDate *)dt {
    [_pickerView2 setDate:dt];
}

- (void)setDate:(NSDate *)dt animated:(BOOL)animated {
    [_pickerView2 setDate:dt animated:animated];
}

- (NSDate *)minimumDate {
    return _pickerView2.minimumDate;
}

- (void)setMinimumDate:(NSDate *)minDate {
    _pickerView2.minimumDate = minDate;
}

- (NSDate *)maximumDate {
    return _pickerView2.maximumDate;
}

- (void)setMaximumDate:(NSDate *)maxDate {
    _pickerView2.maximumDate = maxDate;
}

@end
