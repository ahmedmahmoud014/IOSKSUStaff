//
//  NotifyDetailsObj.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 7/2/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotifyDetailsObj : NSObject{
    NSString* notifyText;
    NSString* time;
}

@property(nonatomic, retain) NSString* notifyText;
@property(nonatomic, retain) NSString* time;

@end
