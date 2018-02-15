//
//  BookObj.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 4/15/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum bookColor{
    bookBlue=0,
    bookPurple,
    bookOrange,
    bookGreen,
    bookRed
    
}BookColor;

@interface BookObj : NSObject{
    NSString * bookName;
    NSString *borrowedDate;

}

@property(nonatomic,retain) NSString * bookName;
@property(nonatomic,retain) NSString *borrowedDate;
@end
