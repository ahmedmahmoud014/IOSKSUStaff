//
//  ForgetPWObj.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 11/26/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ForgetPWObj : NSObject{
    NSString* email;
    NSString *username;
}
@property(nonatomic,retain) NSString* email;
@property(nonatomic,retain) NSString *username;
@end
