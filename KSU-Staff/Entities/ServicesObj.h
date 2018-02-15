//
//  ScheduleObj.h
//  KSU_Students
//
//  Created by EJ-Mac book on 8/2/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserObj.h"


@interface ServicesObj : NSObject{

    NSString * serviceCode;
    NSString * serviceNameAr;
    NSString * serviceNameEn;
}
@property (nonatomic,retain) NSString * serviceCode;
@property (nonatomic,retain) NSString * serviceNameAr;
@property (nonatomic,retain) NSString * serviceNameEn;

@end
