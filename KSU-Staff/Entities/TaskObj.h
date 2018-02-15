//
//  TaskObj.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 11/16/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum taskSectionItems{
    Department_TSItem=0,
    Date_TSItem,
    Status_TSItem,
    Remarks_TSItem
    
}TaskSectionItems;

@interface TaskObj : NSObject{
    
    NSString *task;
    NSString *department;
    NSString *date;
    NSString *status;
    NSString *remarks;
    
}
@property(nonatomic,retain) NSString *task;
@property(nonatomic,retain) NSString *department;
@property(nonatomic,retain) NSString *date;
@property(nonatomic,retain) NSString *status;
@property(nonatomic,retain) NSString *remarks;

@end
