//
//  ITSupportObj.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 11/24/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ITSupportObj : NSObject{
    NSString *message;
    NSString *subject;
    
}
@property(nonatomic,retain)NSString *message;
@property(nonatomic,retain)NSString *subject;
@end
