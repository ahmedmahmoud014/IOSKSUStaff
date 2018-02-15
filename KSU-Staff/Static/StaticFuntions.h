//
//  StaticFuntions.h
//  Swaweek
//
//  Created by EJ-Mac book on 2/13/14.
//  Copyright (c) 2014 EJ-Mac book. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProfileObj.h"
#import "ServicesObj.h"

@interface StaticFuntions : NSObject

+ (BOOL)hasConnectivity;
+ (void)showAlertWithTitle:(NSString *)title Message:(NSString *)message ;
+ (BOOL)isStringEmpty:(NSString *)string ;


+ (UIColor*)getTableLableColor;
+ (UIColor*)getTableValueColor;

+ (UIColor*)getNegativeValueColor;
+ (UIColor*)getPostiveValueColor;

+ (NSString*)getTodayDay:(BOOL)forceHijri;
+ (NSString*)getTodayMonth:(BOOL)forceHijri;
+ (NSString*)getTodayYear:(BOOL)forceHijri;

// for salary
+ (NSString*)getTodayMonthForSalary:(BOOL)forceHijri;
+ (NSString*)getTodayYearForSalary:(BOOL)forceHijri;
+(NSString*)getYearForDateForSalary:(NSDate*)date forceHijri:(BOOL)forceHijri forceEnLocale:(BOOL)forceEnLocale;
+(NSString*)getMonthForDateForSalary:(NSDate*)date forceHijri:(BOOL)forceHijri;
+(NSString*)getDayForDateForSalary:(NSDate*)date forceEnLocale:(BOOL)forceEnLocale;
    // end salary

+(NSString*)getYearForDate:(NSDate*)date forceHijri:(BOOL)forceHijri forceEnLocale:(BOOL)forceEnLocale;
+(NSString*)getMonthForDate:(NSDate*)date forceHijri:(BOOL)forceHijri;
+(NSString*)getDayForDate:(NSDate*)date forceEnLocale:(BOOL)forceEnLocale;

+(NSString*)getIstamicDayNumForWebService:(NSDate*)date;
+ (NSString*)getIstamicMonthNumForWebService:(NSDate*)date;
+(NSString*)getIstamicYearNumForWebService:(NSDate*)date;

+(NSString*)getGregorianMonthNumForWebService:(NSDate*)date;
+(NSString*)getGregorianDayNumForWebService:(NSDate*)date;
+(NSString*)getGregorianYearNumForWebService:(NSDate*)date;
+(NSString*)getIstamicMonthNumForWebServiceTest:(NSDate*)date checkCall :(BOOL)checkCall;

+(NSString*)getMonthNumForDate:(NSDate*)date;

    
+ (UIColor*)getTableCellBGColor_OddRow_Title;
+ (UIColor*)getTableCellBGColor_EvenRow_Title;

+ (UIColor*)getTableCellBGColor_OddRow_Value;
+ (UIColor*)getTableCellBGColor_EvenRow_Value;

+ (UIColor*)getTableSectionBGColor;

+ (UIColor*)getTableHeaderBGColor;
+ (UIColor*)getTableGridBGColor_odd;
+ (UIColor*)getTableGridBGColor_even;

+ (NSMutableArray*)getColors;

+ (BOOL)checkDatePassToday:(NSString*)date;
+ (BOOL)isValidMailAddress :(NSString *)emailString ;

+ (void)createFile:(ProfileObj*)obj;
+(void)UpdateFile:(ProfileObj*)obj;
+ (ProfileObj*)getSavedData;
+(void)createTouchIDFile:(ProfileObj*)obj;
+(ProfileObj*)getSavedTouchIDData;

+(void)createServicesFile:(NSMutableArray *)list;
+(NSMutableArray*)getSavedServicesData;

+ (void)clearProfileData;


@end
