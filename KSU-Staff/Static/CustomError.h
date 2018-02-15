//
//  CustomError.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 12/10/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomError : NSObject

//@property (nonatomic ,readwrite) int errorCode;
//@property (nonatomic, retain)   NSString *erroeCodeString;
@property (nonatomic, retain    )NSString *errorMessage;

+(id)initWithError:(id)data;

@end
