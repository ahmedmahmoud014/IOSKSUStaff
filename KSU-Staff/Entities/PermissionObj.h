//
//  PermissionObj.h
//  KSU_Students
//
//  Created by EJ-Mac book on 8/2/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PermissionObj.h"


@interface PermissionObj : NSObject{

    NSString * serviceName;
    NSMutableArray *pages;
}
@property (nonatomic,retain) NSString * serviceName;
@property (nonatomic,retain) NSMutableArray *pages;
@end
