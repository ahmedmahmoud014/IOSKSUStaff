//
//  MenuCellObj.m
//  KSU-Staff
//
//  Created by EJ-Mac book on 11/10/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import "MenuCellObj.h"
#import "LocalizedMessages.h"
#import "StaticVariables.h"
#import "BaseViewController.h"
#import "CustomNavigationController.h"
#import "AppDelegate.h"

@implementation MenuCellObj
@synthesize menuImg;
@synthesize menuName;
@synthesize isNotifSwitch;
//@synthesize selectedMenuImg;

#pragma mark - get menu objects

+(MenuCellObj*)getHomeMenu{
    MenuCellObj *cell=[[MenuCellObj alloc] init];
    cell.menuImg=[UIImage imageNamed:@"home.png"];
    //cell.selectedMenuImg=[UIImage imageNamed:@"home_s.png"];
    cell.isNotifSwitch=NO;
    cell.menuName=MenuItemHomeText;
    return cell;
}

+(MenuCellObj*)getChangePWMenu{
    MenuCellObj *cell=[[MenuCellObj alloc] init];
    cell.menuImg=[UIImage imageNamed:@"change_password.png"];
    //cell.selectedMenuImg=[UIImage imageNamed:@"select_new_location_menu_s.png"];
    cell.isNotifSwitch=NO;
    cell.menuName=MenuItemChangePWText;
    return cell;
}

+(MenuCellObj*)getDocInquiry{
    MenuCellObj *cell=[[MenuCellObj alloc] init];
    cell.menuImg=[UIImage imageNamed:@"Docinfo.png"];
    cell.isNotifSwitch=NO;
    cell.menuName=MenuItemDocInquiryText;
    return cell;
}

+(MenuCellObj*)getEditProfileMenu{
    MenuCellObj *cell=[[MenuCellObj alloc] init];
    cell.menuImg=[UIImage imageNamed:@"edit_profile.png"];
    //cell.selectedMenuImg=[UIImage imageNamed:@"edit_profile_s.png"];
    cell.isNotifSwitch=NO;
    cell.menuName=MenuItemEditProfileText;
    return cell;
}

+(MenuCellObj*)getContactsMenu{
    MenuCellObj *cell=[[MenuCellObj alloc] init];
    cell.menuImg=[UIImage imageNamed:@"contacts.png"];
    //cell.selectedMenuImg=[UIImage imageNamed:@"people_s.png"];
    cell.isNotifSwitch=NO;
    cell.menuName=MenuItemContactsText;
    return cell;
}

+(MenuCellObj*)getItSupportMenu{
    MenuCellObj *cell=[[MenuCellObj alloc] init];
    cell.menuImg=[UIImage imageNamed:@"support.png"];
    //cell.selectedMenuImg=[UIImage imageNamed:@"add_people_s.png"];
    cell.isNotifSwitch=NO;
    cell.menuName=MenuItemSupportText;
    return cell;
}

+(MenuCellObj*)getReportProblemMenu{
    MenuCellObj *cell=[[MenuCellObj alloc] init];
    cell.menuImg=[UIImage imageNamed:@"report_problem.png"];
    //cell.selectedMenuImg=[UIImage imageNamed:@"favourites_s.png"];
    cell.isNotifSwitch=NO;
    cell.menuName=MenuItemReportProbText;
    return cell;
}

+(MenuCellObj*)getNotificationMenu{
    MenuCellObj *cell=[[MenuCellObj alloc] init];
    cell.menuImg=[UIImage imageNamed:@"notifications.png"];
    //cell.selectedMenuImg=[UIImage imageNamed:@"notifications.png"];
    cell.isNotifSwitch=YES;
    cell.menuName=MenuItemNotifText;
    return cell;
}

+(MenuCellObj*)getLanguageMenu{
    MenuCellObj *cell=[[MenuCellObj alloc] init];
    cell.menuImg=[UIImage imageNamed:@"lang.png"];
    //cell.selectedMenuImg=[UIImage imageNamed:@"language_s.png"];
    cell.isNotifSwitch=NO;
    cell.menuName=MenuItemLanguageText;
    return cell;
}

+(MenuCellObj*)getLogOutMenu{
    MenuCellObj *cell=[[MenuCellObj alloc] init];
    cell.menuImg=[UIImage imageNamed:@"log_out.png"];
  //  cell.selectedMenuImg=[UIImage imageNamed:@"locate_driver_s.png"];
    cell.isNotifSwitch=NO;
    cell.menuName=MenuItemLogoutText;
    return cell;
}


+(MenuCellObj*)getAboutMenu{
    MenuCellObj *cell=[[MenuCellObj alloc] init];
    cell.menuImg=[UIImage imageNamed:@"about.png"];
 //   cell.selectedMenuImg=[UIImage imageNamed:@"about_swaweeg_s.png"];
    cell.isNotifSwitch=NO;
    cell.menuName=MenuItemAboutText;
    return cell;
}

+(MenuCellObj*)getSettingMenu{
    MenuCellObj *cell=[[MenuCellObj alloc] init];
    cell.menuImg=[UIImage imageNamed:@"settings.png"];
    //   cell.selectedMenuImg=[UIImage imageNamed:@"about_swaweeg_s.png"];
    cell.isNotifSwitch=NO;
    cell.menuName=MenuItemSettingText;
    return cell;
}
+(MenuCellObj*)getMenuForindex:(int)index{
    
    switch (index) {
        case HomeItem:
            return  [self getHomeMenu];
            break;
        case EditProfileItem:
            return [self getEditProfileMenu];
            break;
        case ChangePWItem:
            return  [self getChangePWMenu];
            break;
        case getDocInquiryItem:
            return  [self getDocInquiry];
            break;
        case ContactsItem:
            return  [self getContactsMenu];
            break;
        case NotifcationItem:
            return [self getNotificationMenu];
            break;
        case LanguageItem:
            return  [self getLanguageMenu];
            break;
        case ItSupportItem:
            return  [self getItSupportMenu];
            break;
        case ReportProblemItem:
            return  [self getReportProblemMenu];
            break;
        case AboutItem:
            return  [self getAboutMenu];
            break;
        case LogoutItem:
            return  [self getLogOutMenu];
            break;
        case SettingITem:
            return  [self getSettingMenu];
            break;
        default:
            break;
    }
    
    return nil;
}

+(NSString*)getSeagueName:(int)index{
     AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    switch (index) {
        case HomeItem:
            return  SeagueDashBoardScreen;
            break;
        case EditProfileItem:
            return SeagueEditProfileScreen;
            break;
        case ChangePWItem:
            return  SeagueChangePasswordScreen;
            break;
        case getDocInquiryItem:
            return  SeagueDocInfoScreen;
            break;
            
        case ContactsItem:
            return  SeagueContactsScreen;
            break;
        case NotifcationItem:
           // return SeagueFavoriteView;
            break;
        case LanguageItem:
            [self logout_method];
            break;
        case ItSupportItem:
            return SeagueITSupportScreen;
            break;
        case ReportProblemItem:
            return  SeagueReportProblemScreen;
            break;
        case LogoutItem:
            [self logout_method];
            break;
        case AboutItem:
            return  SeagueAboutScreen;
            break;
        case SettingITem:
           
            if(appDelegate.currentLang==English)
            {
                return  SeagueSettingScreen;
            }else {
              return  SeagueSettingArScreen;
            }
            
            break;
        default:
            break;
    }
    
    return @"";
}

+(void)logout_method{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    CustomNavigationController *nav=(CustomNavigationController*)appDelegate.centerController;
    //[((BaseViewController*)[nav getTopView]) hideMenuViewer];
    [((BaseViewController*)[nav getTopView]) onMenuButtonPressed:nil];
    [((BaseViewController*)[nav getTopView]) logout];

}
@end
