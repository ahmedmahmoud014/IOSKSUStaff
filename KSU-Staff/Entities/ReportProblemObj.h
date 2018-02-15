//
//  ReportProblemObj.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 11/25/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReportProblemObj : NSObject{
    UIImage *capturedProblem;
    NSString* message;
}
@property (nonatomic,retain) UIImage *capturedProblem;
@property (nonatomic,retain) NSString* message;

@end
