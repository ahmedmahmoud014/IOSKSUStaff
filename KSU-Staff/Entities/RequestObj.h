//
//  RequestObj.h
//  KSU_Students
//
//  Created by EJ-Mac book on 8/2/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserObj.h"

typedef NS_ENUM( NSUInteger, RequestsType ){
    My=0,
    Processed,
    Completed,
    Recieved
    
};



@interface RequestObj : NSObject{

    NSString * requestCode;
    NSString * requestDate;
    NSString * requestStatus;
    NSString * requesterName;
    NSString * serviceCode;
    NSString * serviceName;
    NSString * serviceTypeName;
    //RequestsType type;
}

@property (nonatomic,retain) NSString * requestCode;
@property (nonatomic,retain) NSString * requestDate;
@property (nonatomic,retain) NSString * requestStatus;
@property (nonatomic,retain) NSString * requesterName;
@property (nonatomic,retain) NSString * serviceCode;
@property (nonatomic,retain) NSString * serviceName;
@property (nonatomic,retain) NSString * serviceTypeName;

//@property (nonatomic) RequestsType type;


@end
