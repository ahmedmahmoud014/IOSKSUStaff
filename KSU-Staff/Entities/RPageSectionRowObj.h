//
//  PageObj.h
//  KSU_Students
//
//  Created by EJ-Mac book on 8/2/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface RPageSectionRowObj : NSObject{

    NSString * dataType;
    NSString * label;
    NSString * singleValue;
    NSMutableArray * listValue;
}
@property (nonatomic,retain) NSString * dataType;
@property (nonatomic,retain) NSString * label;
@property (nonatomic,retain) NSString * singleValue;
@property (nonatomic,retain) NSMutableArray * listValue;
@end
