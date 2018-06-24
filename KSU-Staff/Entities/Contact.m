//
//  Contact.m
//  KSU-Staff
//
//  Created by iOSAccount on 11/8/17.
//  Copyright © 2017 E-Jawdah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Contact.h"
@implementation Contact
@synthesize phone,mobile,email,website,location ;
-(void)initWithContact:(NSString *)phone mobile:(NSString *)mobile email:(NSString *)email website:(NSString *)website location:(NSString *)location{
    self.phone=phone;
    self.email= email;
    self.website= website;
    self.location=location;
    self.mobile=mobile;
    
}
@end
