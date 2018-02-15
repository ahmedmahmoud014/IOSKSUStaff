//
//  EditProfileObj.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 11/20/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EditProfileObj : NSObject{
    NSString* mobile;
    NSString *email;
    NSString *telephone;
    NSString *website;
}
@property(nonatomic,retain) NSString* mobile;
@property(nonatomic,retain) NSString *email;
@property(nonatomic,retain) NSString *telephone;
@property(nonatomic,retain) NSString *website;

@end
