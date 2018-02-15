//
//  SettingViewController.m
//  KSU-Staff
//
//  Created by EJ-Mac book on 1/20/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "SettingViewController.h"
#import "LocalizedMessages.h"
#import "StaticVariables.h"
#import "AppDelegate.h"
#import "StaticFuntions.h"
#import "RequestManager.h"
#import "CustomError.h"
@interface SettingViewController ()

@end

@implementation SettingViewController
@synthesize titleLbl;
@synthesize tableView;
@synthesize languageCell;
@synthesize notificationCell;
@synthesize aboutCell;

@synthesize totalsDBCell;

@synthesize languageLbl;
@synthesize languageValLbl;
@synthesize notifictionLbl;
@synthesize notificationSwitch;
@synthesize aboutLbl;

@synthesize totalsDBLbl,totalsSwitch;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self customizeNavigationBar:YES WithMenu:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - base methods

-(void)initalizeViews{
    self.BGImage.image= [UIImage imageNamed:@"bg.png"];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    totalsSwitch.on=appDelegate.EmployeeObj.showTotalsDB;
    notificationSwitch.on=appDelegate.EmployeeObj.showNotifications;
    
    /*AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
     if(appDelegate.currentLang==Arabic){
     
     }*/
}

-(void)locatizeLables{
    
    titleLbl.text=MenuItemSettingText;
    aboutLbl.text=MenuItemAboutText;
    notifictionLbl.text=MenuItemNotifText;
    languageLbl.text=currentLangText;
    languageValLbl.text=MenuItemLanguageText;
    totalsDBLbl.text= changeTotalsDBText;
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(appDelegate.currentLang==Arabic){
    }else{
        
    }
}

-(void)switchToLeftLayout{
    NSTextAlignment align=NSTextAlignmentLeft;
    titleLbl.textAlignment=align;
}

-(void)switchToRightLayout{
    NSTextAlignment align=NSTextAlignmentRight;
    titleLbl.textAlignment=align;
    
}


#pragma mark - events

-(IBAction)onswitchchanged:(id)sender{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.EmployeeObj.showNotifications=notificationSwitch.on;
    /*if(notificationSwitch.on)
        appDelegate.EmployeeObj.showNotifications=NO;
    else{
        appDelegate.EmployeeObj.showNotifications=YES;
    }*/
    [StaticFuntions createFile:appDelegate.EmployeeObj];
    [appDelegate updateDeviceToken];
}

-(IBAction)onTotalsSwitchchanged:(id)sender{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.EmployeeObj.showTotalsDB=totalsSwitch.on;
    [StaticFuntions createFile:appDelegate.EmployeeObj];
}

#pragma mark - table delegate

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    int row=(int)indexPath.row;
    switch (row) {
        case (int)LangSettingItem:
            return languageCell;
            break;
        case (int)NotifSettingItem:
            return notificationCell;
            break;
        case TotalsDBSettingItem:
            return totalsDBCell;
            break;
        case (int)AboutSettingItem:
            return aboutCell;
            break;
            
        default:
            break;
    }
    return nil;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return NumberSettingItems;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    int row=(int)indexPath.row;
    switch (row) {
        case (int)LangSettingItem:
            [self showLanguageAlert];
            break;
        case (int)NotifSettingItem:
            break;
        case (int)TotalsDBSettingItem:
            break;
        case (int)AboutSettingItem:
            [self openAboutScreen];
            break;
            
        default:
            break;
    }

}


#pragma mark - methods
-(void)openAboutScreen{
    UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:SeagueAboutScreen];
    [self.navigationController pushViewController:viewController animated:NO];
}

-(void)showLanguageAlert{
  
//    
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:ApplicationTitleText message:changeLangMsgText delegate:self cancelButtonTitle:CancelButtonText otherButtonTitles: OKayButtonText, nil];
    [alert show];
}

#pragma mark- alert delegate

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==0)return;
    
    
   // [[RequestManager sharedInstance] updateLanguage:self];
    [self changeLanguag];
    //[self showActivityViewer];
    
    
    

}
#pragma mark - connection


-(void) changeLanguag{
   // [self showActivityViewer];
    NSString *language=@"";
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(appDelegate.currentLang==Arabic){
        appDelegate.currentLang=English;
        language=@"en";
    }else{
        appDelegate.currentLang=Arabic;
        language= @"ar";
    }
    ICLocalizationSetLanguage(language);
    
    appDelegate.EmployeeObj.userLang=appDelegate.currentLang;
    appDelegate.EmployeeObj.empDeviceToken=appDelegate.deviceToken;
    [StaticFuntions createFile:appDelegate.EmployeeObj];
    
    [appDelegate switchMenuDirection];
    [tableView reloadData];
   // [self hideActivityViewer];
    [self onHomePressed:nil];
    
    //[StaticFuntions showAlertWithTitle:ApplicationTitleText Message:UpdateLanguageConfirmationMsg];
}

- (void)processCompleted:(id)data error:(CustomError *)error withService:(NSNumber *)service{
    [self hideActivityViewer];
    if(data!=nil){
        if ([service intValue]==(int)UpdateLanguage_WS)
        {
           
        }
        
    }else{
        
        [StaticFuntions showAlertWithTitle:ErrorGeneralTitle Message:error.errorMessage];
        
    }
}

@end
