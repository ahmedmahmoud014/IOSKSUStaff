//
//  NTMonthYearPicker.m
//  NTMonthYearPicker
//
//  Created by Arun Nair on 10/29/13.
//  Copyright (c) 2013 Arun Nair. All rights reserved.
//
//  http://github.com/nairteashop/NTMonthYearPicker
//

#import "NTMonthYearPicker.h"
#import "AppDelegate.h"


@implementation NTMonthYearPickerView

@synthesize datePickerMode;
@synthesize locale = _locale;
@synthesize calendar = _calendar;
@synthesize date = _date;
@synthesize minimumDate;
@synthesize maximumDate;
@synthesize pickerDelegate;
@synthesize isForceHijri;

// Picker data (list of days,months and years)
NSArray *_daysArray;
NSArray *_monthsArray;
NSArray *_yearsArray;

// Cached min/max year/month values
// We do this to avoid expensive NSDateComponents-based date math in pickerView:viewForRow
NSInteger _minimumYear = -1;
NSInteger _maximumYear = -1;
NSInteger _minimumMonth = -1;
NSInteger _maximumMonth = -1;
NSInteger _minimumDay = -1;
NSInteger _maximumDay = -1;

// Default min/max year values used if minimumDate/maximumDate is not set
// These values match that of UIDatePicker
const NSInteger kMinYear = 1400;
const NSInteger kMaxYear = 10000;

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

    // Set default date to today
    _date = [NSDate date];
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    
    // Set initial picker selection
    [self selectionFromDate:FALSE];
}

#pragma mark - Date picker mode

- (void)setDatePickerMode:(NTMonthYearPickerMode)mode {
    datePickerMode = mode;
    [self reloadAllComponents];
    [self selectionFromDate:FALSE];
}

#pragma mark - Locale

- (NSLocale *)locale {
    if( _locale == nil ) {
        _locale = [self.calendar locale];
    }
    return _locale;
}

- (void)setLocale:(NSLocale *)loc {
    _locale = loc;
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
    
    // Form list of months
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:self.locale];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if ([isForceHijri isEqualToString:@"YES"]) {
        _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierIslamicUmmAlQura];
    }
    else
    {
        
        if(appDelegate.currentLang==English)
            _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        else
            _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierIslamicUmmAlQura];
    }
    
    NSDate *today = [NSDate date];
    
    
    [_calendar rangeOfUnit:NSCalendarUnitDay startDate:&today interval:NULL forDate:today];
    [dateFormatter setCalendar:_calendar];
    
    if(appDelegate.currentLang==English){
        //english output
        dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    }else if(appDelegate.currentLang==Arabic){
        //english output
        dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ar"];
    }
    
    _monthsArray = [dateFormatter monthSymbols];
    
    if(appDelegate.currentLang==English){
        
        if (_minimumMonth == 2){
        _daysArray = [[NSArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28", nil];
        }
        else if(_minimumMonth == 1 ||_minimumMonth == 3 ||_minimumMonth == 5 ||_minimumMonth == 7 ||_minimumMonth == 8 ||_minimumMonth == 10|| _minimumMonth == 12){
             _daysArray = [[NSArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31", nil];
        }
        else {
            _daysArray = [[NSArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30", nil];
        }
    }
    else
    {
        _daysArray = [[NSArray alloc] initWithObjects:@"١",@"٢",@"٣",@"٤",@"٥",@"٦",@"٧",@"٨",@"٩",@"١٠",@"١١",@"١٢",@"١٣",@"١٤",@"١٥",@"١٦",@"١٧",@"١٨",@"١٩",@"٢٠",@"٢١",@"٢٢",@"٢٣",@"٢٤",@"٢٥",@"٢٦",@"٢٧",@"٢٨",@"٢٩",@"٣٠", nil];
    }
    
    
    // Form list of years
    [dateFormatter setDateFormat:@"yyyy"];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    NSMutableArray *years = [[NSMutableArray alloc] init];
    for( int year = kMinYear ; year <= kMaxYear ; ++year ) {
        [comps setYear:year];
        NSDate *yearDate = [self.calendar dateFromComponents:comps];
        NSString *yearStr = [dateFormatter stringFromDate:yearDate];
        
        [years addObject:yearStr];
    }
    _yearsArray = years;
    
    
    
    [self reloadAllComponents];
    
    
}



- (void)setCalendarAfterSelect:(NSCalendar *)cal mimimonth :(NSInteger *) mini_month _monthsArray: (NSArray *) monthsArray
                   _yearsArray: (NSArray *)yearsArray{
    _calendar = cal;
    
    // Form list of months
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:self.locale];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if ([isForceHijri isEqualToString:@"YES"]) {
        _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierIslamicUmmAlQura];
    }
    else
    {
        
        if(appDelegate.currentLang==English)
            _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        else
            _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierIslamicUmmAlQura];
    }
    
 //   NSDate *today = [NSDate date];
//
//
  //  [_calendar rangeOfUnit:NSCalendarUnitDay startDate:&today interval:NULL forDate:today];
    
    [dateFormatter setCalendar:cal];
    
    if(appDelegate.currentLang==English){
        //english output
        dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    }else if(appDelegate.currentLang==Arabic){
        //english output
        dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ar"];
    }
    
    _monthsArray = monthsArray;
    
    if(appDelegate.currentLang==English){
//        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:today];
//
//        int month = [components month];
        
        if (mini_month == 2){
            _daysArray = [[NSArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28", nil];
        }
        else if( mini_month == 1 ||mini_month == 3 ||mini_month == 5 ||mini_month == 7 ||mini_month == 8 ||mini_month == 10|| mini_month == 12){
            _daysArray = [[NSArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31", nil];
        }
        else {
            _daysArray = [[NSArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30", nil];
        }
    }
    else
    {
        if(mini_month == 2 ||mini_month == 6 ||mini_month == 8 ||mini_month == 10|| mini_month == 11){
        
        _daysArray = [[NSArray alloc] initWithObjects:@"١",@"٢",@"٣",@"٤",@"٥",@"٦",@"٧",@"٨"
                      ,@"٩"
                      ,@"١٠",@"١١",@"١٢",@"١٣",@"١٤",@"١٥",@"١٦",@"١٧",@"١٨",@"١٩",@"٢٠",@"٢١",@"٢٢",@"٢٣",@"٢٤",@"٢٥",@"٢٦",@"٢٧",@"٢٨",@"٢٩", nil];
        }else {
            _daysArray = [[NSArray alloc] initWithObjects:@"١",@"٢",@"٣",@"٤",@"٥",@"٦",@"٧",@"٨",@"٩",@"١٠",@"١١",@"١٢",@"١٣",@"١٤",@"١٥",@"١٦",@"١٧",@"١٨",@"١٩",@"٢٠",@"٢١",@"٢٢",@"٢٣",@"٢٤",@"٢٥",@"٢٦",@"٢٧",@"٢٨",@"٢٩",@"٣٠", nil];
        }
    }
    
    // Form list of years
    [dateFormatter setDateFormat:@"yyyy"];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    NSMutableArray *years = [[NSMutableArray alloc] init];
    for( int year = kMinYear ; year <= kMaxYear ; ++year ) {
        [comps setYear:year];
        NSDate *yearDate = [self.calendar dateFromComponents:comps];
        NSString *yearStr = [dateFormatter stringFromDate:yearDate];
        
        [years addObject:yearStr];
    }
    _yearsArray = yearsArray;
    
    
    
    [self reloadAllComponents];
    
    
}

#pragma mark - Date

- (NSDate *)date {
    return _date;
}

- (void)setDate:(NSDate *)dt {
    [self setDate:dt animated:FALSE];
}

- (void)setDate:(NSDate *)dt animated:(BOOL)animated {
    _date = dt;
    [self selectionFromDate:animated];
}

#pragma mark - isForceHijri
- (void)setIsForceHijri:(NSString *)sallaryStr {
    isForceHijri = sallaryStr;
}
#pragma mark - Min / Max date

- (void)setMinimumDate:(NSDate *)minDate {
    minimumDate = minDate;

    // Pre-calculate min year & month
    if( minimumDate != nil ) {
        NSDateComponents *comps = [self.calendar components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:minimumDate];
        _minimumYear = comps.year;
        _minimumMonth = comps.month;
        _minimumDay = comps.day;
    } else {
        _minimumYear = -1;
        _minimumMonth = -1;
        _minimumDay = -1;
    }

    [self reloadAllComponents];
}

- (void)setMaximumDate:(NSDate *)maxDate {
    maximumDate = maxDate;

    // Pre-calculate max year & month
    if( maximumDate != nil ) {
        NSDateComponents *comps = [self.calendar components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:maximumDate];
        _maximumYear = comps.year;
        _maximumMonth = comps.month;
        _maximumDay = comps.day;
    } else {
        _maximumYear = -1;
        _maximumMonth = -1;
        _maximumDay = -1;
    }

    [self reloadAllComponents];
}

#pragma mark - Date <-> selection

- (void)selectionFromDate:(BOOL)animated {
    // Extract the month and year from the current date value
    NSDateComponents* comps = [self.calendar components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:self.date];
    NSInteger day = [comps day];
    NSInteger month = [comps month];
    NSInteger year = [comps year];
    
    
    
    // Select the corresponding rows in the UI
    if( datePickerMode == NTMonthYearPickerModeDayMonthAndYear ) {
        [self selectRow:(day - 1) inComponent:0 animated:animated];
        [self selectRow:(month - 1) inComponent:1 animated:animated];
        [self selectRow:(year - kMinYear) inComponent:2 animated:animated];
    }
    else if( datePickerMode == NTMonthYearPickerModeMonthAndYear)
    {
        [self selectRow:(month - 1) inComponent:0 animated:animated];
        [self selectRow:(year - kMinYear) inComponent:1 animated:animated];
    }
    else
    {
        [self selectRow:(year - kMinYear) inComponent:0 animated:animated];
    }
}

- (NSDate *)dateFromSelection {
    NSInteger day, month, year;


    // Get the currently selected month and year
    if( datePickerMode == NTMonthYearPickerModeDayMonthAndYear ) {
        day = [self selectedRowInComponent:0] + 1;
        month = [self selectedRowInComponent:1] + 1;
        year  = [self selectedRowInComponent:2] + kMinYear;
        NSLog(@"your scroll date is s %ld",month);
        NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
                    [dateComponents setMonth:month -1];
                    NSCalendar *calendar = [NSCalendar currentCalendar];
                    NSDate *newDate = [calendar dateByAddingComponents:dateComponents toDate:[NSDate date] options:0];
//                    [self setMinimumDate:newDate];
        
        
        [self setCalendarAfterSelect:calendar mimimonth:month _monthsArray:_monthsArray _yearsArray:_yearsArray] ;
         //[self reloadAllComponents];

    } else if( datePickerMode == NTMonthYearPickerModeMonthAndYear ) {
        day = 1;
        month = [self selectedRowInComponent:0] + 1;
        year  = [self selectedRowInComponent:1] + kMinYear;
    }
    else
    {
        day = 1;
        month = 1;
        year  = [self selectedRowInComponent:0] + kMinYear;
        
    }

    // Assemble into a date object
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:day];
    [comps setMonth:month];
    [comps setYear:year];

    return [self.calendar dateFromComponents:comps];
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (datePickerMode == NTMonthYearPickerModeDayMonthAndYear) {
        return 3;
    }
    else if (datePickerMode == NTMonthYearPickerModeMonthAndYear)
    {
        return 2;
    }
    else
    {
        return 1;
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    if (datePickerMode == NTMonthYearPickerModeDayMonthAndYear) {
        if (component == 0) {
            return [_daysArray count];
        }
        else if (component == 1) {
            return [_monthsArray count];
        }
        else
        {
            return [_yearsArray count];
        }

    }
    else if (datePickerMode == NTMonthYearPickerModeMonthAndYear)
    {
        if (component == 0) {
            return [_monthsArray count];
        }
        else
        {
            return [_yearsArray count];
        }
    }
    else
    {
        return [_yearsArray count];
        
    }
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

    // Is this the year component?
  //  BOOL isYearComponent = (datePickerMode == NTMonthYearPickerModeYear) || (component == 1);

    // Is the month or year represented by this component out of bounds? (i.e. < min or > max)
    BOOL outOfBounds = FALSE;
    if( datePickerMode == NTMonthYearPickerModeDayMonthAndYear ) {
        if (component == 0) {
            int day = (int)row + 1;
            
            // Extract the year from the current date
            NSDateComponents *comps = [self.calendar components:(NSCalendarUnitYear) fromDate:self.date];
            int year = (int)comps.year;
            
            if( ( (maximumDate != nil) && ((year > _maximumYear) || ((year == _maximumYear) && (day > _maximumDay))) )
               ||
               ( (minimumDate != nil) && ((year < _minimumYear) || ((year == _minimumYear) && (day < _minimumDay))) ) )
            {
                outOfBounds = TRUE;
            }
            label.text = [_daysArray objectAtIndex:row];
        }
        else if (component == 1) {
            int month = (int)row + 1;
            // Extract the year from the current date
            NSDateComponents *comps = [self.calendar components:(NSCalendarUnitYear) fromDate:self.date];
            int year = (int)comps.year;
            
            if( ( (maximumDate != nil) && ((year > _maximumYear) || ((year == _maximumYear) && (month > _maximumMonth))) ) ||
               ( (minimumDate != nil) && ((year < _minimumYear) || ((year == _minimumYear) && (month < _minimumMonth))) ) ) {
                outOfBounds = TRUE;
            }
//
//            NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
//            [dateComponents setMonth:month];
//            NSCalendar *calendar = [NSCalendar currentCalendar];
//            NSDate *newDate = [calendar dateByAddingComponents:dateComponents toDate:[NSDate date] options:0];
//            [self setMinimumDate:newDate];
           // [self reloadAllComponents];
            label.text = [_monthsArray objectAtIndex:row];
        }
        else
        {
            int year = (int)row + kMinYear;
            
            if( ((maximumDate != nil) && (year > _maximumYear)) ||
               ((minimumDate != nil) && (year < _minimumYear)) ) {
                outOfBounds = TRUE;
            }
            label.text = [_yearsArray objectAtIndex:row];
        }
    }
    else if (datePickerMode == NTMonthYearPickerModeMonthAndYear)
    {
        if (component == 0) {
            int month = (int)row + 1;
            
            // Extract the year from the current date
            NSDateComponents *comps = [self.calendar components:(NSCalendarUnitYear) fromDate:self.date];
            int year = (int)comps.year;
            
            if( ( (maximumDate != nil) && ((year > _maximumYear) || ((year == _maximumYear) && (month > _maximumMonth))) ) ||
               ( (minimumDate != nil) && ((year < _minimumYear) || ((year == _minimumYear) && (month < _minimumMonth))) ) ) {
                outOfBounds = TRUE;
            }
            label.text = [_monthsArray objectAtIndex:row];
        }
        else
        {
            int year = (int)row + kMinYear;
            
            if( ((maximumDate != nil) && (year > _maximumYear)) ||
               ((minimumDate != nil) && (year < _minimumYear)) ) {
                outOfBounds = TRUE;
            }
            label.text = [_yearsArray objectAtIndex:row];
        }

    }
    else
    {
        int year = (int)row + kMinYear;
        
        if( ((maximumDate != nil) && (year > _maximumYear)) ||
           ((minimumDate != nil) && (year < _minimumYear)) ) {
            outOfBounds = TRUE;
        }
        label.text = [_yearsArray objectAtIndex:row];
        

        
    }

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

    if (datePickerMode == NTMonthYearPickerModeDayMonthAndYear) {
        if (component == 2) {
            [self reloadComponent:0];
        }

    }
    else if (datePickerMode == NTMonthYearPickerModeMonthAndYear) {
        if (component == 1) {
            [self reloadComponent:0];
        }
    }
    else
    {
        [self reloadComponent:0];
    }

    // Notify delegate
    [pickerDelegate didSelectDate];
}

- (NSComparisonResult)compareMonthYear:(NSDate *)date1 with:(NSDate *)date2 {
    NSDateComponents *comps = [self.calendar components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:date1];
    date1 = [self.calendar dateFromComponents:comps];

    comps = [self.calendar components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:date2];
    date2 = [self.calendar dateFromComponents:comps];

    return [date1 compare:date2];
}

@end

//
// NTMonthYearPicker
//

@interface NTMonthYearPicker (Delegate) <NTMonthYearPickerViewDelegate>
@end

@implementation NTMonthYearPicker

@synthesize datePickerMode;
@synthesize locale;
@synthesize calendar;
@synthesize date;
@synthesize minimumDate;
@synthesize maximumDate;
@synthesize pickerView;

#pragma mark - Initialization

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        pickerView = [[NTMonthYearPickerView alloc] initWithFrame:frame];
        [self initCommon];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        pickerView = [[NTMonthYearPickerView alloc] initWithCoder:aDecoder];

        CGSize pickerSize = [pickerView sizeThatFits:CGSizeZero];
        pickerView.frame = CGRectMake( 0, 0, pickerSize.width, pickerSize.height );

        [self initCommon];
    }
    return self;
}

- (void)initCommon {
    self.frame = pickerView.frame;
    pickerView.pickerDelegate = self;
    
    
    [self addSubview:pickerView];
}

- (CGSize)sizeThatFits:(CGSize)size {
    return [pickerView sizeThatFits:size];
}

- (void)didSelectDate {
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

#pragma mark - NTMonthYearPicker API

- (NTMonthYearPickerMode)datePickerMode {
    return pickerView.datePickerMode;
}

- (void)setDatePickerMode:(NTMonthYearPickerMode)dpm {
    pickerView.datePickerMode = dpm;
}

- (NSLocale *)locale {
    return pickerView.locale;
}

- (void)setLocale:(NSLocale *)loc {
    pickerView.locale = loc;
}

- (NSCalendar *)calendar {
    return pickerView.calendar;
}

- (void)setCalendar:(NSCalendar *)cal {
    pickerView.calendar = cal;
}

- (NSDate *)date {
    return pickerView.date;
}

- (void)setDate:(NSDate *)dt {
    [pickerView setDate:dt];
}

- (void)setDate:(NSDate *)dt animated:(BOOL)animated {
    [pickerView setDate:dt animated:animated];
}
- (NSString *)isForceHijri {
    return pickerView.isForceHijri;
}

- (void)setIsForceHijri:(NSString *)sallaryStr {
    pickerView.isForceHijri = sallaryStr;
}

- (NSDate *)minimumDate {
    return pickerView.minimumDate;
}

- (void)setMinimumDate:(NSDate *)minDate {
    pickerView.minimumDate = minDate;
}

- (NSDate *)maximumDate {
    return pickerView.maximumDate;
}

- (void)setMaximumDate:(NSDate *)maxDate {
    pickerView.maximumDate = maxDate;
}

@end
