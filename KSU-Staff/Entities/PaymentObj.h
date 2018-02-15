//
//  PaymentObj.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 10/22/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PaymentObj : NSObject{
    BOOL isPaid;
    NSString *date;
    
    NSMutableArray *paidDetailsArr;
    NSMutableArray *notPaidDetailsArr;
    
}

@property (nonatomic)BOOL isPaid;
@property (nonatomic, retain)NSString *date;

@property (nonatomic, retain)NSMutableArray *paidDetailsArr;
@property (nonatomic, retain)NSMutableArray *notPaidDetailsArr;
@end
