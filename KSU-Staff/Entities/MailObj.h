//
//  BookObj.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 4/15/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MailObj : NSObject{
    NSString *userName;
    NSString *mobileNum;
    NSString *email;
    NSString *message;

}

@property(nonatomic,retain) NSString *userName;
@property(nonatomic,retain) NSString *mobileNum;
@property(nonatomic,retain) NSString *email;
@property(nonatomic,retain) NSString *message;
@end
