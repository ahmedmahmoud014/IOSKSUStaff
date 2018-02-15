//
//  VehicleObj.m
//  KSU-Staff
//
//  Created by EJ-Mac book on 1/28/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "VehicleObj.h"

@implementation VehicleObj
@synthesize assignDate,vehicleNo,vehicleType,deliverDate;


-(NSString*)getDate:(NSTimeInterval)time{
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
   // [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setDateFormat:@"dd/MM/YYYY"];
     NSCalendar *islamicCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierIslamicUmmAlQura];
    [dateFormatter setCalendar:islamicCalendar];
    return [dateFormatter stringFromDate:date];
}
@end
