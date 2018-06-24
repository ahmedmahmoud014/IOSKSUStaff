//
//  StaticFuntions.m
//  Swaweek
//
//  Created by EJ-Mac book on 2/13/14.
//  Copyright (c) 2014 EJ-Mac book. All rights reserved.
//

#import "StaticFuntions.h"

#import <sys/socket.h>
#import <netinet/in.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import "LocalizedMessages.h"
#import "AppDelegate.h"


@implementation StaticFuntions
+ (BOOL)hasConnectivity {
    
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (const struct sockaddr*)&zeroAddress);
    if(reachability != NULL) {
        
        SCNetworkReachabilityFlags flags;
        if (SCNetworkReachabilityGetFlags(reachability, &flags)) {
            if ((flags & kSCNetworkReachabilityFlagsReachable) == 0)
            {
                return NO;
            }
            
            if ((flags & kSCNetworkReachabilityFlagsConnectionRequired) == 0)
            {
                
                return YES;
            }
            
            
            if ((((flags & kSCNetworkReachabilityFlagsConnectionOnDemand ) != 0) ||
                 (flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0))
            {
                
                
                if ((flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0)
                {
                    
                    return YES;
                }
            }
            
            if ((flags & kSCNetworkReachabilityFlagsIsWWAN) == kSCNetworkReachabilityFlagsIsWWAN)
            {
                
                return YES;
            }
        }
    }
    
    return NO;
}


+ (void)showAlertWithTitle:(NSString *)title Message:(NSString *)message {
    NSString * messageTitle = title ? title : ApplicationTitleText;
    [[[UIAlertView alloc] initWithTitle:messageTitle
                                message:message
                               delegate:nil
                      cancelButtonTitle:OKayButtonText
                      otherButtonTitles:nil] show];
}
+ (BOOL)isStringEmpty:(NSString *)string  {
    NSString *rawString = string;
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmed = [rawString stringByTrimmingCharactersInSet:whitespace];
    if ([trimmed length] == 0) {
        return YES;
    }
    return NO;
}
+ (UIColor*)getTableLableColor{
    return [UIColor colorWithRed:135.0/255.0 green:141.0/255.0 blue:147.0/255.0 alpha:1];
}
+ (UIColor*)getTableValueColor{
    return [UIColor colorWithRed:0.0/255.0 green:137.0/255.0 blue:192.0/255.0 alpha:1];
}

+ (UIColor*)getNegativeValueColor{
     return [UIColor colorWithRed:242.0/255.0 green:14.0/255.0 blue:0.0/255.0 alpha:1];
}
+ (UIColor*)getPostiveValueColor{
     return [UIColor colorWithRed:0.0/255.0 green:160.0/255.0 blue:139.0/255.0 alpha:1];
}
//changing
//+ (NSString*)getTodayDay:(BOOL)forceHijri{
//    NSDate *today = [NSDate date];
//    return [self getDayForDate:today forceEnLocale:FALSE];
//}
////changing
//+ (NSString*)getTodayMonth:(BOOL)forceHijri{
//    NSDate *today = [NSDate date];
//    return [self getMonthForDate:today forceHijri:forceHijri];
//
//}
//changing
//+ (NSString*)getTodayYear:(BOOL)forceHijri{
//    NSDate *today = [NSDate date];
//    return [self getYearForDate:today forceHijri:forceHijri forceEnLocale:FALSE];
//}


// edit calender

+ (NSString*)getTodayDay:(BOOL)forceHijri{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSDate *today = [NSDate date];
    if(appDelegate.currentLang==English){
        return [self getDayForDate:today forceEnLocale:true];
    }
    else
    {
        return [self getDayForDate:today forceEnLocale:FALSE];
        
    }
}
//changing
+ (NSString*)getTodayMonth:(BOOL)forceHijri{
    NSDate *today = [NSDate date];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if(appDelegate.currentLang==English){
        return [self getMonthForDate:today forceHijri:false];
    }
    else
    {
        return [self getMonthForDate:today forceHijri:forceHijri];
        
    }
    
}
    // for salary
+ (NSString*)getTodayMonthForSalary:(BOOL)forceHijri{
        NSDate *today = [NSDate date];
     //   AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
//        if(appDelegate.currentLang==English){
//            return [self getMonthForDate:today forceHijri:false];
//        }
//        else
//        {
            return [self getMonthForDate:today forceHijri:forceHijri];
            
//        }
    
    }



+ (NSString*)getTodayYear:(BOOL)forceHijri{
    NSDate *today = [NSDate date];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if(appDelegate.currentLang==English){
        return [self getYearForDate:today forceHijri:false forceEnLocale:true];
    }
    else
    {
        return [self getYearForDate:today forceHijri:forceHijri forceEnLocale:FALSE];

    }
}
    // for salary
+ (NSString*)getTodayYearForSalary:(BOOL)forceHijri{
        NSDate *today = [NSDate date];
      //  AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//
//        if(appDelegate.currentLang==English){
//            return [self getYearForDate:today forceHijri:false forceEnLocale:true];
//        }
//        else
//        {
            return [self getYearForDate:today forceHijri:forceHijri forceEnLocale:FALSE];
            
        //}
    }
    // for salary

   
    
// end salary
    


//changing
+(NSString*)getYearForDate:(NSDate*)date forceHijri:(BOOL)forceHijri forceEnLocale:(BOOL)forceEnLocale{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    NSCalendar *calendar;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterFullStyle];
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    
    if (forceHijri) {
        calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierIslamicUmmAlQura];
        if(appDelegate.currentLang==English){
            dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        }else if(appDelegate.currentLang==Arabic){
            dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ar"];
        }
    }
    else
    {
        if(appDelegate.currentLang==English){
            calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
            dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        }else if(appDelegate.currentLang==Arabic){
            calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierIslamicUmmAlQura];
            dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ar"];
        }
    }
    
    if (forceEnLocale) {
        dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    }
    
    [calendar rangeOfUnit:NSCalendarUnitYear startDate:&date interval:NULL forDate:date];
    [dateFormatter setCalendar:calendar];
    
    //dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    dateFormatter.dateFormat=@"YYYY";
    
    NSString * yearString = [dateFormatter stringFromDate:date];
    NSLog(@"%@", yearString);
    return yearString;
}

+(NSString*)getDayForDate:(NSDate*)date forceEnLocale:(BOOL)forceEnLocale{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    NSCalendar *calendar;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterFullStyle];
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    

    if(appDelegate.currentLang==English){
        calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    }else if(appDelegate.currentLang==Arabic){
        calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierIslamicUmmAlQura];
        dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ar"];
    }
    
    if (forceEnLocale) {
        dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    }
    
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&date interval:NULL forDate:date];
    [dateFormatter setCalendar:calendar];
    
    dateFormatter.dateFormat=@"dd";
    NSString * dayString = [[dateFormatter stringFromDate:date] capitalizedString];
    NSLog(@"%@", dayString);
    return dayString;
    
}

////changing
+(NSString*)getMonthForDate:(NSDate*)date forceHijri:(BOOL)forceHijri{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    NSCalendar *calendar;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterFullStyle];
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    
    if (forceHijri) {
        calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierIslamicUmmAlQura];
        if(appDelegate.currentLang==English){
            dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        }
        else if(appDelegate.currentLang==Arabic){
            dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ar"];
        }
    }
    else
    {
        if(appDelegate.currentLang==English){
            calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
            dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        }else if(appDelegate.currentLang==Arabic){
            calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierIslamicUmmAlQura];
            dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ar"];
        }
    }
    
    
    [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&date interval:NULL forDate:date];
    [dateFormatter setCalendar:calendar];
    
    dateFormatter.dateFormat=@"MMMM";
    NSString * monthString = [[dateFormatter stringFromDate:date] capitalizedString];
    NSLog(@" select month  is this %@", monthString);
    return monthString;

}

+(NSString*)getIstamicMonthNumForWebService:(NSDate*)date{
    NSCalendar *islamicCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierIslamicUmmAlQura];
    [islamicCalendar rangeOfUnit:NSCalendarUnitDay startDate:&date interval:NULL forDate:date];
    
     NSDateComponents* components = [islamicCalendar components:NSCalendarUnitMonth fromDate:date]; // Get necessary date components
    NSString *monthString=[ NSString stringWithFormat:@"%02d" ,(int)[components month]];
    
    
    return monthString;

}

+(NSString*)getIstamicMonthNumForWebServiceTest:(NSDate*)date checkCall :(BOOL)checkCall{
    NSString *monthString;
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

//    if(appDelegate.currentLang==English){
//    if (checkCall ==true ){
//    NSCalendar *islamicCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierIslamicUmmAlQura];
//    [islamicCalendar rangeOfUnit:NSCalendarUnitDay startDate:&date interval:NULL forDate:date];
//
//    NSDateComponents* components = [islamicCalendar components:NSCalendarUnitMonth fromDate:date]; // Get necessary date components
//    monthString=[ NSString stringWithFormat:@"%02d" ,(int)[components month]];
//
//    }
//    else {
//        NSCalendar *islamicCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierIslamicUmmAlQura];
//        [islamicCalendar rangeOfUnit:NSCalendarUnitDay startDate:&date interval:NULL forDate:date];
//
//        NSDateComponents* components = [islamicCalendar components:NSCalendarUnitMonth fromDate:date]; // Get necessary date components
//        monthString=[ NSString stringWithFormat:@"%02d" ,(int)[components month]+1];
//    }
//    }
//    else {
        NSCalendar *islamicCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierIslamicUmmAlQura];
        [islamicCalendar rangeOfUnit:NSCalendarUnitDay startDate:&date interval:NULL forDate:date];
        
        NSDateComponents* components = [islamicCalendar components:NSCalendarUnitMonth fromDate:date]; // Get necessary date components
        monthString=[ NSString stringWithFormat:@"%02d" ,(int)[components month]];
   // }
    return monthString;
    
}
+(NSString*)getIstamicDayNumForWebService:(NSDate*)date{
    
    NSCalendar *islamicCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierIslamicUmmAlQura];
    [islamicCalendar rangeOfUnit:NSCalendarUnitDay startDate:&date interval:NULL forDate:date];
    
    NSDateComponents* components = [islamicCalendar components:NSCalendarUnitDay fromDate:date]; // Get necessary date components
    NSString *dayString=[ NSString stringWithFormat:@"%02d" ,(int)[components day]];
    
   


    NSLog(@"%@", dayString);
    return dayString;
    
}
+(NSString*)getIstamicYearNumForWebService:(NSDate*)date{
    
    NSCalendar *islamicCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierIslamicUmmAlQura];
    [islamicCalendar rangeOfUnit:NSCalendarUnitDay startDate:&date interval:NULL forDate:date];
    
    NSDateComponents* components = [islamicCalendar components:NSCalendarUnitYear fromDate:date]; // Get necessary date components
    NSString *yearString=[ NSString stringWithFormat:@"%i" ,(int)[components year]];
    NSLog(@"%@", yearString);
    return yearString;
    
}

+(NSString*)getGregorianMonthNumForWebService:(NSDate*)date{
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [gregorianCalendar rangeOfUnit:NSCalendarUnitDay startDate:&date interval:NULL forDate:date];
    
    NSDateComponents* components = [gregorianCalendar components:NSCalendarUnitMonth fromDate:date]; // Get necessary date components
    NSString *monthString=[ NSString stringWithFormat:@"%02d" ,(int)[components month]];
    NSLog(@"%@", monthString);
    return monthString;
    
}
+(NSString*)getGregorianDayNumForWebService:(NSDate*)date{
    
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [gregorianCalendar rangeOfUnit:NSCalendarUnitDay startDate:&date interval:NULL forDate:date];
    
    NSDateComponents* components = [gregorianCalendar components:NSCalendarUnitDay fromDate:date]; // Get necessary date components
    NSString *dayString=[ NSString stringWithFormat:@"%02d" ,(int)[components day]];
    NSLog(@"%@", dayString);
    return dayString;
    
}
+(NSString*)getGregorianYearNumForWebService:(NSDate*)date{
    
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [gregorianCalendar rangeOfUnit:NSCalendarUnitDay startDate:&date interval:NULL forDate:date];
    
    NSDateComponents* components = [gregorianCalendar components:NSCalendarUnitYear fromDate:date]; // Get necessary date components
    NSString *yearString=[ NSString stringWithFormat:@"%i" ,(int)[components year]];
    NSLog(@"%@", yearString);
    return yearString;
    
}

+(NSString*)getMonthNumForDate:(NSDate*)date{
    
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    NSCalendar *calendar;
    if(appDelegate.currentLang==English){
        calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    }else if(appDelegate.currentLang==Arabic){
        calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierIslamicUmmAlQura];
    }
    [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&date interval:NULL forDate:date];
    
    NSDateComponents* components = [calendar components:NSCalendarUnitMonth fromDate:date]; // Get necessary date components
    NSString *monthString=[ NSString stringWithFormat:@"%02d" ,(int)[components month]];
    NSLog(@"%@", monthString);
    return monthString;
    
}


+ (UIColor*)getTableCellBGColor_OddRow_Title{
    return [UIColor colorWithRed:218.0/255.0 green:221.0/255.0 blue:223.0/255.0 alpha:1];
}
+ (UIColor*)getTableCellBGColor_EvenRow_Title{
    return [UIColor colorWithRed:243.0/255.0 green:243.0/255.0 blue:243.0/255.0 alpha:1];

}

+ (UIColor*)getTableCellBGColor_OddRow_Value{
    return [UIColor colorWithRed:233.0/255.0 green:233.0/255.0 blue:233.0/255.0 alpha:1];

}
+ (UIColor*)getTableCellBGColor_EvenRow_Value{
    return [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1];
}
+ (UIColor*)getTableSectionBGColor{
    return [UIColor colorWithRed:0.0/255.0 green:137.0/255.0  blue:192.0/255.0  alpha:1];
}

+(UIColor*)getTableHeaderBGColor{
    return [UIColor colorWithRed:228.0/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:1];
}

+(UIColor*)getTableGridBGColor_even{
    return [UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:1];
}
+(UIColor*)getTableGridBGColor_odd{
    return [UIColor colorWithRed:231.0/255.0 green:237.0/255.0 blue:240.0/255.0 alpha:1];
}

+ (NSMutableArray*)getColors{
    NSMutableArray * arr=[[NSMutableArray alloc] init];
    [arr addObject:[UIColor colorWithRed:0/255.0 green:167.0/255.0 blue:234.0/255.0 alpha:1]];
    [arr addObject:[UIColor colorWithRed:160.0/255.0 green:70.0/255.0 blue:136.0/255.0 alpha:1]];
    [arr addObject:[UIColor colorWithRed:244.0/255.0 green:151.0/255.0 blue:42.0/255.0 alpha:1]];
    [arr addObject:[UIColor colorWithRed:236.0/255.0 green:44.0/255.0 blue:32.0/255.0 alpha:1]];
    [arr addObject:[UIColor colorWithRed:60.0/255.0 green:168.0/255.0 blue:154.0/255.0 alpha:1]];
    [arr addObject:[UIColor colorWithRed:220.0/255.0 green:26.0/255.0 blue:14.0/255.0 alpha:1]];
    
    return arr;
}

+ (BOOL)checkDatePassToday:(NSString*)date{
     NSDate *today = [NSDate date];
    NSCalendar *islamicCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierIslamicUmmAlQura];
    [islamicCalendar rangeOfUnit:NSCalendarUnitDay startDate:&today interval:NULL forDate:today];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setCalendar:islamicCalendar];
    [dateFormatter setDateFormat:@"dd/mm/YYYY"];
    NSDate *date1=[dateFormatter dateFromString:date];
    NSLog(@"%@",date1);
    
    if([date1 timeIntervalSinceNow]<0.0){
        return YES;
    }
    
    return NO;
}

+ (BOOL)isValidMailAddress :(NSString *)emailString {
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest =[NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    BOOL myStringMatchesRegEx=[emailTest evaluateWithObject:emailString];
    return myStringMatchesRegEx;
}

+(void)createFile:(ProfileObj*)obj{
    
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"data.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath: path]){
        NSString *bundle = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
        [fileManager copyItemAtPath:bundle toPath: path error:&error];
    }
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    
    [data setObject:obj.userName forKey:@"userName"];
    [data setObject:obj.password forKey:@"password"];
    if(obj.startYear&&(![StaticFuntions isStringEmpty:obj.startYear]))
        [data setObject:obj.startYear forKey:@"startYear"];
    else{
        obj.startYear=[StaticFuntions getDefaultStartYear];
        [data setObject:obj.startYear forKey:@"startYear"];
    }
    [data setObject:obj.empNo forKey:@"empNo"];
    [data setObject:[NSNumber numberWithBool: obj.isTeacher] forKey:@"isTeacher"];
    [data setObject:[NSNumber numberWithBool: obj.hasVehicles] forKey:@"hasVehicles"];
    [data setObject:[NSNumber numberWithBool: obj.showTotalsDB] forKey:@"showTotalsDB"];
    [data setObject:[NSNumber numberWithInt:(int)obj.userLang] forKey:@"userLang"];
    if(obj.empDeviceToken)
        [data setObject:obj.empDeviceToken forKey:@"deviceToken"];
    else
        [data setObject:@"" forKey:@"deviceToken"];
    [data setObject:[NSNumber numberWithBool: obj.showNotifications] forKey:@"showNotifications"];
    [data setObject:[NSNumber numberWithBool: obj.useTouchID] forKey:@"useTouchID"];
    
    [data writeToFile: path atomically:YES];
    
}

+(void)UpdateFile:(ProfileObj*)obj{
    
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"data.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath: path]){
        NSString *bundle = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
        [fileManager copyItemAtPath:bundle toPath: path error:&error];
    }
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    
    [data setObject:[NSNumber numberWithBool: obj.useTouchID] forKey:@"useTouchID"];
    [data writeToFile: path atomically:YES];
    
}

+(ProfileObj*)getSavedData{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"data.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath: path]){
        NSMutableDictionary *savedData = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
        
        ProfileObj *obj=[[ProfileObj alloc]init];
        obj.userName= [savedData objectForKey:@"userName"];
        obj.password= [savedData objectForKey:@"password"];
        obj.startYear= [savedData objectForKey:@"startYear"];
        obj.empNo= [savedData objectForKey:@"empNo"];
        obj.isTeacher = [[savedData objectForKey:@"isTeacher"] boolValue];
        obj.hasVehicles = [[savedData objectForKey:@"hasVehicles"] boolValue];
        obj.showTotalsDB = [[savedData objectForKey:@"showTotalsDB"] boolValue];
        obj.userLang=(MyLanguages)[[savedData objectForKey:@"userLang"] intValue];
        obj.empDeviceToken = [savedData objectForKey:@"deviceToken"];
        obj.showNotifications=[[savedData objectForKey:@"showNotifications"]boolValue];
        obj.useTouchID=[[savedData objectForKey:@"useTouchID"]boolValue];
        
        return obj;
    }
    return nil;
}


+(void)createTouchIDFile:(ProfileObj*)obj{
    
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"TouchIDdata.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath: path]){
        NSString *bundle = [[NSBundle mainBundle] pathForResource:@"TouchIDdata" ofType:@"plist"];
        [fileManager copyItemAtPath:bundle toPath: path error:&error];
    }
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    
    [data setObject:obj.userName forKey:@"userName"];
    [data setObject:obj.password forKey:@"password"];
    [data writeToFile: path atomically:YES];
}

+(ProfileObj*)getSavedTouchIDData{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"TouchIDdata.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath: path])
    {
        NSMutableDictionary *savedData = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
        ProfileObj *obj=[[ProfileObj alloc]init];
        
        obj.userName= [savedData objectForKey:@"userName"];
        obj.password= [savedData objectForKey:@"password"];
        return obj;
    }
    return nil;
}



+(void)createServicesFile:(NSMutableArray *)list{
    
   
  /*
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"services.plist"];
    
    NSFileManager *filemgr;
    filemgr = [NSFileManager defaultManager];
    
    if ([filemgr fileExistsAtPath: path]) {
        NSMutableDictionary *plist = [[NSDictionary dictionaryWithContentsOfFile:path] mutableCopy];
        
        NSMutableArray *newArray = [[NSMutableArray alloc] init];
        
        for(int i=0;i<list.count;i++)
        {
            [newArray addObject:[list objectAtIndex:i]];
            
        }
        
        [plist setObject:newArray forKey:@"Hi"];
        BOOL ssss=[plist writeToFile:path atomically:YES];
        
        NSString *jhsagdhjsagd = @"";
        
    }
    */
    
     NSError *error;
     NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
     NSString *documentsDirectory = [paths objectAtIndex:0];
     NSString *path = [documentsDirectory stringByAppendingPathComponent:@"services.plist"];
     NSFileManager *fileManager = [NSFileManager defaultManager];
     
     if (![fileManager fileExistsAtPath: path]){
     NSString *bundle = [[NSBundle mainBundle] pathForResource:@"services" ofType:@"plist"];
     [fileManager copyItemAtPath:bundle toPath: path error:&error];
     }
    
    
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] init];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for(int i=0;i<list.count;i++)
    {
        ServicesObj *obj = [list objectAtIndex:i];
        NSMutableDictionary *objDic = [[NSMutableDictionary alloc] init];
        [objDic setObject:obj.serviceNameAr forKeyedSubscript:serviceNameMW];
        [objDic setObject:obj.serviceNameEn forKeyedSubscript:serviceNameEnMW];
        [objDic setObject:obj.serviceCode forKeyedSubscript:serviceCodeMW];
        [array addObject:objDic];
    }
    
    [plist setObject:array forKey:@"list"];
    [plist writeToFile:path atomically:YES];
    
}

+(NSMutableArray*)getSavedServicesData{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"services.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath: path])
    {
        NSMutableDictionary *savedData = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
        return [savedData objectForKey:@"list"];
    }
    return nil;
    
}





+(NSString*)getDefaultStartYear{
    NSString *todayYear=[StaticFuntions getYearForDate:[NSDate date] forceHijri:FALSE forceEnLocale:FALSE];
    int fromYear=[todayYear intValue]- countStartJobYear;
    
    return [NSString stringWithFormat:@"%d",fromYear];
}

+(void) clearProfileData{
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"data.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath: path]){
        NSString *bundle = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
        [fileManager copyItemAtPath:bundle toPath: path error:&error];
    }
    
    AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    
    [data setObject:@"" forKey:@"userName"];
    [data setObject:@"" forKey:@"password"];
    [data setObject:@"" forKey:@"startYear"];
    [data setObject:@"" forKey:@"empNo"];
    [data setObject:[NSNumber numberWithBool: NO] forKey:@"isTeacher"];
    [data setObject:[NSNumber numberWithBool: NO] forKey:@"hasVehicles"];
    [data setObject:[NSNumber numberWithBool: NO] forKey:@"showTotalsDB"];
    [data setObject:[NSNumber numberWithInt:(int)appdelegate.currentLang] forKey:@"userLang"];
    [data setObject:@"" forKey:@"deviceToken"];
    [data setObject:[NSNumber numberWithBool:NO] forKey:@"showNotifications"];
    [data writeToFile: path atomically:YES];

}
@end
