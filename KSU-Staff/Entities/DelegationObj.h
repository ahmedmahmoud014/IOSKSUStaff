//
//  ScheduleObj.h
//  KSU_Students
//
//  Created by EJ-Mac book on 8/2/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserObj.h"


@interface DelegationObj : NSObject{

    NSInteger  delegationID;
    UserObj * user;
    NSString * startTime;
    NSString * startTimeNo;
    NSString * endTime;
    NSString * endTimeNo;
    NSString * serviceCode;
    NSString * serviceNameAr;
    NSString * serviceNameEn;
    NSString * requestNo;
    BOOL status;
}
@property (nonatomic) NSInteger delegationID;
@property (nonatomic,retain) UserObj * user;
@property (nonatomic,retain) NSString * startTime;
@property (nonatomic,retain) NSString * startTimeNo;
@property (nonatomic,retain) NSString * endTime;
@property (nonatomic,retain) NSString * endTimeNo;
@property (nonatomic,retain) NSString * serviceCode;
@property (nonatomic,retain) NSString * serviceNameAr;
@property (nonatomic,retain) NSString * serviceNameEn;
@property (nonatomic,retain) NSString * requestNo;
@property (nonatomic) BOOL status;

-(void)initWithDelegationObj:(NSInteger)withDelegationID withUser:(UserObj*)withUser withStartTime:(NSString*)withStartTime withEndTime:(NSString*)withEndTime withServiceCode:(NSString*)withServiceCode withServiceNameAr:(NSString*)withServiceNameAr withServiceNameEn:(NSString*)withServiceNameEn withStatus:(BOOL)withStatus withRequestNo:(NSString*)withRequestNo;
    
    
@end
