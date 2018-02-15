//
//  DashboardDataObj.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 2/23/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum myDashBoardData{
    salaryData=0,
    vacationData,
    paymentData
}MyDashBoardData;

@interface DashboardDataObj : NSObject{
    NSString *salary;
    NSString *paid;
    NSString *notPaid;
    NSString *normalVacation;
    NSString *emergencyVacation;
}

@property (nonatomic,retain) NSString *salary;
@property (nonatomic,retain) NSString *paid;
@property (nonatomic,retain) NSString *notPaid;
@property (nonatomic,retain) NSString *normalVacation;
@property (nonatomic,retain) NSString *emergencyVacation;
@end
