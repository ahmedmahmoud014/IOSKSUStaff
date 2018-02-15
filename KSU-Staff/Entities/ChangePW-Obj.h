//
//  ChangePW-Obj.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 11/24/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChangePW_Obj : NSObject{
    NSString *passwordOld;
    NSString *passwordNew;
    NSString *passwordConfirm;
}

@property (nonatomic,retain) NSString *passwordOld;
@property (nonatomic,retain) NSString *passwordNew;
@property (nonatomic,retain) NSString *passwordConfirm;

-(BOOL)validateConfirmationPw;
@end
