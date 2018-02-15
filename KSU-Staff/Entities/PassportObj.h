//
//  PassportObj.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 11/16/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum passportColor{
    passportBlue=0,
    passportPurple,
    passportOrange,
    passportGreen,
    passportRed
    
}PassportColor;

@interface PassportObj : NSObject{
    NSString *name;
    NSString *expireDate;
    NSString *passportNo;
}

@property (nonatomic,retain) NSString *name;
@property (nonatomic,retain) NSString *expireDate;
@property (nonatomic,retain) NSString *passportNo;
@end
