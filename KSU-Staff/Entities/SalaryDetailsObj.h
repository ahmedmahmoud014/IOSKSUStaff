//
//  SalaryDetailsObj.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 10/20/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SalaryDetailsObj : NSObject{
    NSString *code;
    NSString *description;
    NSString *value;
    BOOL isAllowance;
    
}

@property(nonatomic,retain) NSString *code;
@property(nonatomic,retain) NSString *description;
@property(nonatomic,retain) NSString *value;
@property(nonatomic) BOOL isAllowance;
@end
