//
//  Categories.m
//  KSU-Staff
//
//  Created by iOSAccount on 11/1/17.
//  Copyright © 2017 E-Jawdah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Categories.h"
@implementation Categories
@synthesize fullName,category_id,url_title,offersPath;

-(void)initWithCatName:(NSString *)fullName category_id:(NSString *)category_id url_title:(NSString *)url_title offersPath:(NSString *)offersPath{
    self.fullName= fullName;
    self.category_id= category_id;
    self.url_title= url_title;
    self.offersPath= offersPath;
}

@end

