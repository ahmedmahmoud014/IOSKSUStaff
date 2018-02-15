//
//  CustodyObj.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 1/4/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import <Foundation/Foundation.h>

//typedef enum custodyColor:NSInteger{
    
typedef NS_ENUM( NSUInteger, CustodyColor ){
    custodyBlue=0,
    custodyPurple,
    custodyOrange,
    custodyGreen,
    custodyRed
    
};//CustodyColor;

@interface CustodyObj : NSObject{
    NSString *cust_desc;
    NSString *cust_quantity;
    NSString *cust_remarks;
}

@property(nonatomic,retain)NSString *cust_desc;
@property(nonatomic,retain)NSString *cust_quantity;
@property(nonatomic,retain)NSString *cust_remarks;
@end
