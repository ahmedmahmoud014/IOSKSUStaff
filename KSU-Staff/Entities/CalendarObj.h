//
//  CalendarObj.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 11/13/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalendarObj : NSObject{
    NSString *event;
    NSString *georgDate;
    NSString *hijriDate;
}

@property (nonatomic,retain) NSString *event;
@property (nonatomic,retain) NSString *georgDate;
@property (nonatomic,retain) NSString *hijriDate;

+(NSMutableArray*)getCalendarData:(BOOL)isVaction;
@end
