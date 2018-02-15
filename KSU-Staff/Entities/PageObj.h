//
//  PageObj.h
//  KSU_Students
//
//  Created by EJ-Mac book on 8/2/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserObj.h"


@interface PageObj : NSObject{

    NSString * pageName;
    NSString * actions;
}
@property (nonatomic,retain) NSString * pageName;
@property (nonatomic,retain) NSString * actions;
@end
