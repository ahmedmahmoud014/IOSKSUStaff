//
//  CustomError.m
//  KSU-Staff
//
//  Created by EJ-Mac book on 12/10/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import "CustomError.h"
#import "StaticVariables.h"
#import "LocalizedMessages.h"

@implementation CustomError

//@synthesize errorCode;
@synthesize errorMessage;
//@synthesize erroeCodeString;

+ (id)initWithError:(id)data   {
    
    return [[CustomError alloc] initWithData:data];
}

- (id)initWithData:(id)data {
    
    self = [super init];
    if (self) {
        
        //[self setErrorCode:[[data valueForKeyPath:MWErrorCode] intValue]];
        if([data objectForKeyedSubscript:MWErrorMessage]!=[NSNull null])
            [self setErrorMessage:[data objectForKeyedSubscript:MWErrorMessage]];
        else
            [self setErrorMessage:ErrorGeneralTitle];
        
    }
    return self;
}

@end
