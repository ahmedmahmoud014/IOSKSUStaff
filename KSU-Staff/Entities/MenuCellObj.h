//
//  MenuCellObj.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 11/10/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuCellObj : NSObject

@property (nonatomic,retain) NSString* menuName;
@property (nonatomic,retain) UIImage* menuImg;
//@property (nonatomic,retain) UIImage* selectedMenuImg;
@property (nonatomic) BOOL isNotifSwitch;


+(MenuCellObj*)getHomeMenu;
+(MenuCellObj*)getChangePWMenu;
+(MenuCellObj*)getEditProfileMenu;
+(MenuCellObj*)getContactsMenu;
+(MenuCellObj*)getItSupportMenu;
+(MenuCellObj*)getReportProblemMenu;
+(MenuCellObj*)getNotificationMenu;
+(MenuCellObj*)getLanguageMenu;
+(MenuCellObj*)getLogOutMenu;
+(MenuCellObj*)getAboutMenu;
+(MenuCellObj*)getSettingMenu;

+(MenuCellObj*)getMenuForindex:(int)index;

+(NSString*)getSeagueName:(int)index;
@end
