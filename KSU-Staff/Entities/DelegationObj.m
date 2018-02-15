//
//  ScheduleObj.m
//  KSU_Students
//
//  Created by EJ-Mac book on 8/2/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "DelegationObj.h"

@implementation DelegationObj

@synthesize delegationID;
@synthesize user;
@synthesize startTime;
@synthesize startTimeNo;
@synthesize endTime;
@synthesize endTimeNo;
@synthesize serviceCode;
@synthesize serviceNameAr;
@synthesize serviceNameEn;
@synthesize requestNo;
@synthesize status;

-(void)initWithDelegationObj:(NSInteger)withDelegationID withUser:(UserObj*)withUser withStartTime:(NSString*)withStartTime withEndTime:(NSString*)withEndTime withServiceCode:(NSString*)withServiceCode withServiceNameAr:(NSString*)withServiceNameAr withServiceNameEn:(NSString*)withServiceNameEn withStatus:(BOOL)withStatus withRequestNo:(NSString*)withRequestNo
{
    self.delegationID = withDelegationID;
    self.user = withUser;
    self.startTime = withStartTime;
    self.endTime = withEndTime;
    self.serviceCode = withServiceCode;
    self.serviceNameAr = withServiceNameAr;
    self.serviceNameEn = withServiceNameEn;
    self.status = withStatus;
    self.requestNo = withRequestNo;
    
}
@end
