//
//  SalaryObj.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 10/19/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SalaryDetailsObj.h"

typedef enum salarySections{
    PaymentInfo_sec=0,
    Allowances_sec,
    Deductions_sec
   // ,Totals_sec
    
}SalarySections;

typedef enum salaryPaymentInfo{
    Date_SPInfo=0,
    Type_SPInfo,
    Bank_SPInfo
    
}SalaryPaymentInfo;


@interface SalaryObj : NSObject{
    NSString *date;
    NSString *type;
    NSString *bankName;
    
    NSMutableArray *allowanceArr;
    NSMutableArray *deductionArr;
    
    NSString *totalDeserve;
    NSString *totalDiscount;
    NSString *totalNet;
    
    NSString *basicSalary;
    
    NSString * YEAR;
    NSString * MONTH;
}

@property (nonatomic,retain) NSString *YEAR;
@property (nonatomic,retain) NSString *MONTH;


@property (nonatomic,retain) NSString *date;
@property (nonatomic,retain) NSString *type;
@property (nonatomic,retain) NSString *bankName;

@property (nonatomic,retain) NSMutableArray *allowanceArr;
@property (nonatomic,retain) NSMutableArray *deductionArr;

@property (nonatomic,retain) NSString *totalDeserve;
@property (nonatomic,retain) NSString *totalDiscount;
@property (nonatomic,retain) NSString *totalNet;

@property (nonatomic,retain) NSString *basicSalary;
@end
