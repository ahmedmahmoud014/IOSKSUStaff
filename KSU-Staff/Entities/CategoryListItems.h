//
//  CategoryListItems.h
//  KSU-Staff
//
//  Created by iOSAccount on 11/8/17.
//  Copyright © 2017 E-Jawdah. All rights reserved.
//

#ifndef CategoryListItems_h
#define CategoryListItems_h
#import "Contact.h"

#endif /* CategoryListItems_h */
@interface CategoryListItems : NSObject{
    NSString* title;
    NSString* status;
    NSString* created;
    NSString* description;
    
    NSString* expiration_date;
    NSString* offer_url;
    Contact* contact;
    NSString* benf;
    NSNumber* discount_perc;
    NSNumber* likes;
    NSNumber* dislikes;
    NSArray* keywords;
    NSMutableArray* slide_images;

    
    
    
    
}

@property(nonatomic,retain) NSString* title;
@property(nonatomic,retain) NSString* status;
@property(nonatomic,retain) NSString* created;
@property(nonatomic,retain) NSString* description;

@property(nonatomic,retain) NSString* expiration_date;
@property(nonatomic,retain) NSString* offer_url;
@property(nonatomic,retain) Contact* contact;
@property(nonatomic,retain) NSString* benf;
@property(nonatomic,retain) NSNumber* discount_perc;
@property(nonatomic,retain) NSNumber* likes;
@property(nonatomic,retain) NSNumber* dislikes;

@property(nonatomic,retain) NSArray* keywords;

@property (nonatomic, strong) NSMutableArray* slide_images;

-(void)initWithCatItemName:(NSString*)title status:(NSString*)status created:(NSString*)created description:(NSString*)description
 expiration_date:(NSString*)expiration_date offer_url:(NSString*)offer_url contact:(Contact*)contact
benf:(NSString*)benf discount_perc:(NSNumber*)discount_perc likes:(NSNumber*)likes  dislikes:(NSNumber*)dislikes keywords:(NSArray*)keywords slide_images:(NSMutableArray*)slide_images
;


@end
