//
//  ClaimObj.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 2/2/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClaimObj : NSObject{

    NSString* createDate;
    NSString* claimDescp;
    NSString* ticketNo;
}

@property (nonatomic,retain) NSString* createDate;
@property (nonatomic,retain) NSString* claimDescp;
@property (nonatomic,retain) NSString* ticketNo;


@end
