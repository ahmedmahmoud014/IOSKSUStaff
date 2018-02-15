//
//  ProfileObj.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 10/16/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StaticVariables.h"

typedef enum passportInfo{
    Name_PassInfo=0,
    PassNo_PassInfo,
    Expiredate_PassInfo
    
}PassportInfo;

typedef enum personalInfo{
    Name_PInfo=0,
    Nationality_PInfo,
    Birthdate_PInfo,
    SocialNo_PInfo,
   // SocialExpire_PInfo,
    TelNo_PInfo,
    MobNo_PInfo,
    webSite_PInfo,
    AlEmail_PInfo
    
}PersonalInfo;

typedef enum jobInfo{
    EmpNo_JInfo=0,
    Rank_JInfo,
    Grade_JInfo,
    HiringDate_JInfo,
    JobTitle_JInfo,
   // Dep_JInfo,
    Section_JInfo,
    Status_JInfo,
    StartDate_JInfo,
    BankName_JInfo,
    BankAccNo_JInfo
    
    
}JobInfo;

typedef enum profileSections{
    PersonalInfo_sec=0,
    PassportInfo_sec
    
}ProfileSections;

@interface ProfileObj : NSObject{
    NSString* fullName;
    NSString* nationality;
    NSString* birthday;
    BOOL isMale;
    NSString *hijriBirthday;
    NSString* socialNo;
    NSString* socialExpire;
    NSString* telNo;
    NSString* mobNo;
    NSString* alternativeEmail;
    NSString* webSite;
    
    
    NSString* empNo;
    NSString* rank;
    NSString* grade;
    NSString* hiringDate;
    NSString* jobTitle;
    NSString* department;
    NSString* section;
    NSString* status;
    NSString* stratDate;
    NSString* type;
    NSString* bankAccNo;
    NSString* bankName;
    NSString* startYear;
    NSString* latinName;
    BOOL isTeacher;
    
    NSString* userName;
    NSString* password;
    MyLanguages userLang;
    BOOL hasVehicles;
    
    BOOL showTotalsDB;
    
    NSString *empDeviceToken;
    BOOL showNotifications;
    
    BOOL useTouchID;
}

@property(nonatomic,retain) NSString* fullName;
@property(nonatomic,retain) NSString* nationality;
@property(nonatomic,retain) NSString* birthday;
@property(nonatomic) BOOL isMale;
@property(nonatomic,retain) NSString *hijriBirthday;
@property(nonatomic,retain) NSString* socialNo;
@property(nonatomic,retain) NSString* socialExpire;
@property(nonatomic,retain) NSString* telNo;
@property(nonatomic,retain) NSString* mobNo;
@property(nonatomic,retain) NSString* alternativeEmail;
@property(nonatomic,retain) NSString* webSite;


@property(nonatomic,retain) NSString* empNo;
@property(nonatomic,retain) NSString* rank;
@property(nonatomic,retain) NSString* grade;
@property(nonatomic,retain) NSString* hiringDate;
@property(nonatomic,retain) NSString* jobTitle;
@property(nonatomic,retain) NSString* department;
@property(nonatomic,retain) NSString* section;
@property(nonatomic,retain) NSString* status;
@property(nonatomic,retain) NSString* stratDate;
@property(nonatomic,retain) NSString* type;
@property(nonatomic,retain) NSString* bankAccNo;
@property(nonatomic,retain) NSString* bankName;
@property(nonatomic,retain) NSString* startYear;
@property(nonatomic,retain) NSString* latinName;

@property(nonatomic) BOOL isTeacher;
@property(nonatomic) BOOL hasVehicles;

@property(nonatomic) BOOL showTotalsDB;

@property(nonatomic,retain) NSString* userName;
@property(nonatomic,retain) NSString* password;

@property(nonatomic) MyLanguages userLang;

@property(nonatomic) BOOL useTouchID;


@property(nonatomic,retain) NSString *empDeviceToken;
@property (nonatomic, readwrite) BOOL showNotifications;


-(void)initWithEmpNo:(NSString*)emNo withStartYear:(NSString*)st_Year isATeacher:(BOOL) flag hasVehicles:(BOOL)hasVeh;

@end
