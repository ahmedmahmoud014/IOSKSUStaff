//
//  NotifyObj.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 6/25/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotifyObj : NSObject{
    
    NSString* date;
    NSMutableArray* notifyArr;
}

@property(nonatomic, retain) NSMutableArray* notifyArr;
@property(nonatomic, retain) NSString* date;

@end
