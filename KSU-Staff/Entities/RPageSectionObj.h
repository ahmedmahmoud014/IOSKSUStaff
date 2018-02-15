//
//  PageObj.h
//  KSU_Students
//
//  Created by EJ-Mac book on 8/2/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RPageSectionObj : NSObject {

    NSString *sectionName;
    NSMutableArray *rows;
}
@property (nonatomic, retain) NSString *sectionName;
@property (nonatomic, retain) NSMutableArray *rows;
@end
