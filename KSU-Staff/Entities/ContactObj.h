//
//  ContactObj.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 11/18/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactObj : NSObject{
    NSString *phoneNo;
    NSString *contactName;
}
@property(nonatomic,retain) NSString *phoneNo;
@property(nonatomic,retain) NSString *contactName;

@end
