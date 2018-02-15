//
//  Categories.h
//  KSU-Staff
//
//  Created by iOSAccount on 11/1/17.
//  Copyright © 2017 E-Jawdah. All rights reserved.
//

#ifndef Categories_h
#define Categories_h

#endif /* Categories_h */
@interface Categories : NSObject{
    NSString* name;
    NSString* category_id;
    NSString* url_title;
    NSString* offersPath;


}

@property(nonatomic, retain) NSString* fullName;
@property(nonatomic,retain) NSString* category_id;
@property(nonatomic,retain) NSString* url_title;
@property(nonatomic,retain) NSString* offersPath;
-(void)initWithCatName:(NSString*)fullName category_id:(NSString*)category_id url_title:(NSString*)url_title offersPath:(NSString*)offersPath;
@end


