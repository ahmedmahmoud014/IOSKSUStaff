//
//  RequestObj.h
//  KSU_Students
//
//  Created by EJ-Mac book on 8/2/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserObj.h"

@interface RequestActionsObj : NSObject{

    NSString * userName;
    NSString * action;
    NSString * reason;
    NSString * date;
}

@property (nonatomic,retain) NSString * userName;
@property (nonatomic,retain) NSString * action;
@property (nonatomic,retain) NSString * reason;
@property (nonatomic,retain) NSString * date;


@end
