//
//  ProfileObj.m
//  KSU-Staff
//
//  Created by EJ-Mac book on 10/16/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import "ProfileObj.h"
#import "AppDelegate.h"

@implementation ProfileObj
@synthesize fullName;
@synthesize nationality;
@synthesize birthday;
@synthesize isMale;
@synthesize hijriBirthday;
@synthesize socialNo;
@synthesize socialExpire;
@synthesize telNo;
@synthesize mobNo;
@synthesize alternativeEmail;
@synthesize webSite;

@synthesize empNo;
@synthesize rank;
@synthesize grade;
@synthesize hiringDate;
@synthesize jobTitle;
@synthesize department;
@synthesize section;
@synthesize status;
@synthesize stratDate;
@synthesize type;
@synthesize bankAccNo;
@synthesize bankName;

@synthesize startYear;
@synthesize latinName;
@synthesize isTeacher;
@synthesize hasVehicles;

@synthesize userName,password;
@synthesize userLang;

@synthesize showTotalsDB;
@synthesize empDeviceToken;
@synthesize showNotifications;

@synthesize useTouchID;

-(void)initWithEmpNo:(NSString*)emNo withStartYear:(NSString*)st_Year isATeacher:(BOOL)flag hasVehicles:(BOOL)hasVeh{
    self.empNo=emNo;
    self.startYear=st_Year;
    self.isTeacher=flag;
    self.hasVehicles=hasVeh;
    showTotalsDB=showTotalsDBDefaultVal;
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.empDeviceToken=appDelegate.deviceToken;
    
    showNotifications= showNotificationDefaultVal;
    
}
@end
