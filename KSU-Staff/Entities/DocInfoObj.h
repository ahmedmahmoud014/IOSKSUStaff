//
//  VehicleObj.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 1/28/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DocInfoObj : NSObject{
    NSString *ActionDescription;
    NSString *DocTransactionNumber;
    NSString *DocumentDate;
}

@property(nonatomic,retain)  NSString *ActionDescription;
@property(nonatomic,retain)  NSString *DocTransactionNumber;
@property(nonatomic,retain)  NSString *DocumentDate;


@end
