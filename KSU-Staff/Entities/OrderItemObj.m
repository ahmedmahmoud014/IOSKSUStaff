//
//  OrderItemObj.m
//  KSU-Staff
//
//  Created by iOSAccount on 11/13/17.
//  Copyright © 2017 E-Jawdah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderItemObj.h"
@implementation OrderItemObj
@synthesize orderName,orderImageName ;

-(void)initWithOderName:(NSString *)orderName orderImageName:(NSString *)orderImageName{
    self.orderName= orderName;
    self.orderImageName=orderImageName;
}

@end
