//
//  CategoryListItems.m
//  KSU-Staff
//
//  Created by iOSAccount on 11/8/17.
//  Copyright © 2017 E-Jawdah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Foundation/Foundation.h>
#import "CategoryListItems.h"
@implementation CategoryListItems
@synthesize title,status,created,description,expiration_date,offer_url,contact, benf,discount_perc,likes,dislikes,keywords,slide_images;
-(void)
initWithCatItemName:(NSString *)title status:(NSString *)status created:(NSString *)created description:(NSString *)description expiration_date:(NSString *)expiration_date offer_url:(NSString *)offer_url contact:(Contact *)contact benf:(NSString *)benf discount_perc:(NSNumber *)discount_perc likes:(NSNumber *)likes dislikes:(NSNumber *)dislikes keywords:(NSArray *)keywords slide_images:(NSMutableArray *)slide_images{
    self.title=title;
    self.status=status;
    self.created=created;
    self.description=description;
    self.expiration_date=expiration_date;
    self.offer_url=offer_url;
    self.contact=contact;
    self.benf=benf;
    self.discount_perc=discount_perc;
    self.likes=likes;
    self.dislikes= dislikes;
    self.keywords=keywords;
    self.slide_images=slide_images;
}

@end
