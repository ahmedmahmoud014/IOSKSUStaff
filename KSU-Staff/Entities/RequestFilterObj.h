//
//  RequestObj.h
//  KSU_Students
//
//  Created by EJ-Mac book on 8/2/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestFilterObj : NSObject{

    NSString * fromDate;
    NSString * toDate;
    NSString * requestCode;
    NSString * requesterFilter;
    NSString * serviceCode;
}

@property (nonatomic,retain) NSString * fromDate;
@property (nonatomic,retain) NSString * toDate;
@property (nonatomic,retain) NSString * requestCode;
@property (nonatomic,retain) NSString * requesterFilter;
@property (nonatomic,retain) NSString * serviceCode;

@end
