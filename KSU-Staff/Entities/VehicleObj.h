//
//  VehicleObj.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 1/28/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VehicleObj : NSObject{
    NSString *vehicleNo;
    NSString *vehicleType;
    NSString *deliverDate;
    NSString *assignDate;
}

@property(nonatomic,retain)  NSString *vehicleNo;
@property(nonatomic,retain)  NSString *vehicleType;
@property(nonatomic,retain)  NSString *deliverDate;
@property(nonatomic,retain)  NSString *assignDate;

-(NSString*)getDate:(NSTimeInterval)time;
@end
