//
//  PaymentDetailsObj.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 10/22/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum paymentSectionItems{
    Number_PSItem=0,
    Description_PSItem,
    //Amount_PSItem,
    Date_PSItem,
    Indicator_PSItem
    
}PaymentSectionItems;

@interface PaymentDetailsObj : NSObject{
    NSString *number;
    NSString *description;
    NSString *date;
    NSString *month;
    NSString *amount;
    NSString *idicator;
    NSString *mainName;
    BOOL isPaid;
}

@property (nonatomic,retain) NSString *number;
@property (nonatomic,retain) NSString *description;
@property (nonatomic,retain) NSString *date;
@property (nonatomic,retain) NSString *month;
@property (nonatomic,retain) NSString *amount;
@property (nonatomic,retain) NSString *idicator;
@property (nonatomic,retain) NSString *mainName;
@property (nonatomic) BOOL isPaid;


@end
