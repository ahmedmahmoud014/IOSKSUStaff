//
//  AppDelegate.m
//  KSU-Staff
//
//  Created by EJ-Mac book on 9/17/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//


#import "AppDelegate.h"
#import "MenuViewController.h"
#import "CustomNavigationController.h"
#import "LocalizationSystem.h"
#import "LoginViewController.h"
#import "ForgetPWViewController.h"
#import "StaticFuntions.h"
#import "RequestManager.h"
#import "LocalizedMessages.h"
#import "NotificationViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>

#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>


@implementation AppDelegate

@synthesize pased;
@synthesize centerController = _viewController;
@synthesize leftController = _leftController;
@synthesize rightController =_rightController;
@synthesize deviceToken = _deviceToken;
@synthesize canPan = _canPan;
@synthesize currentLang;
@synthesize EmployeeObj;
@synthesize islogOut;
@synthesize DB_data;
@synthesize isSendingDeviceToken;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    pased=NO;
    _canPan=YES;
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [self SetAppLanguage];
    
    [Fabric with:@[[Crashlytics class]]];
    
    IIViewDeckController* deckController = [self generateControllerStack];
    self.leftController = deckController.leftController;
    self.rightController = deckController.rightController;
    self.centerController = deckController.centerController;
    self.window.rootViewController = deckController;
    [self.window makeKeyAndVisible];
    deckController.panningMode = IIViewDeckFullViewPanning;
    deckController.centerhiddenInteractivity=IIViewDeckCenterHiddenNotUserInteractiveWithTapToClose;
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        UIView *addStatusBar = [[UIView alloc] init];
        addStatusBar.frame = CGRectMake(0, 0, self.window.frame.size.width, 20);
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        addStatusBar.backgroundColor = [UIColor colorWithRed:249.0/255.0 green:249.0/255.0 blue:249.0/255.0 alpha:1];
        [self.window.rootViewController.view addSubview:addStatusBar];
    }

    
    
    if([[[UIDevice currentDevice] systemVersion] floatValue] > 8.0)
    {
        
        //Right, that is the point
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIRemoteNotificationTypeBadge
                                                                                             |UIRemoteNotificationTypeSound
                                                                                             |UIRemoteNotificationTypeAlert) categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }else{
        //register to receive notifications
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
    }
    
    
    
    NSDictionary *remoteNotif = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if(remoteNotif)
    {
        application.applicationIconBadgeNumber -= 1;
        //[self setApplicationBadgeNumber:(application.applicationIconBadgeNumber-1)];
        [self pushNotificationViewController:remoteNotif withOpenedApp:NO];
    }else{
        [self setApplicationBadgeNumber:0];
    }
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0")) {
        [[UIView appearance] setSemanticContentAttribute:UISemanticContentAttributeForceLeftToRight];
        
        [[UIView appearanceWhenContainedIn:[UIAlertController class], nil] setSemanticContentAttribute:UISemanticContentAttributeUnspecified];
        [[UIView appearanceWhenContainedIn:[UIAlertView class], nil] setSemanticContentAttribute:UISemanticContentAttributeUnspecified];
        
        
    }

    
   // [TestFlight takeOff:@"89e32e95-cb76-42d3-abb4-100318006d8b" ];//@"2989d3fd-91e5-46b9-bc04-9e4326566bc9"];
    
    
    
    
    ProfileObj * obj= [StaticFuntions getSavedData];
    if(obj!=nil && obj.userName!=nil && ![StaticFuntions isStringEmpty:obj.userName])
    {
        if (obj.useTouchID) {
            LAContext *context = [[LAContext alloc] init];
            NSError *error = nil;
            
            if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
                [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                        localizedReason:@"Are you the device owner?"
                                  reply:^(BOOL success, NSError *error)
                 {
                     if (error) {
                         //fraz request
                         [self deleteDeviceToken];
                         ///
                         [StaticFuntions clearProfileData];
                         
                         IIViewDeckController* deckController = [self generateControllerStack];
                         self.leftController = deckController.leftController;
                         self.rightController = deckController.rightController;
                         self.centerController = deckController.centerController;
                         self.window.rootViewController = deckController;
                         [self.window makeKeyAndVisible];
                         deckController.panningMode = IIViewDeckFullViewPanning;
                         deckController.centerhiddenInteractivity=IIViewDeckCenterHiddenNotUserInteractiveWithTapToClose;
                         
                         if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
                             UIView *addStatusBar = [[UIView alloc] init];
                             addStatusBar.frame = CGRectMake(0, 0, self.window.frame.size.width, 20);
                             [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
                             addStatusBar.backgroundColor = [UIColor colorWithRed:249.0/255.0 green:249.0/255.0 blue:249.0/255.0 alpha:1];
                             [self.window.rootViewController.view addSubview:addStatusBar];
                         }
                         return;
                     }
                     if (success) {
                         
                     }else {
                         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:ErrorGeneralTitle message:@"You are not the device owner." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                         [alert show];
                     }
                     
                 }];
                
            }
            
        }
    }
    
    
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     pased=YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    isSendingDeviceToken=NO;
    pased=YES;
    
    
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
   /* application.applicationIconBadgeNumber = 0;
	[application cancelAllLocalNotifications];
    
    if (!_deviceToken) {
       // _deviceToken = [[DatabaseManager sharedInstance] currentDeviceToken];
    }
    if (_deviceToken) {
        
        // [[RequestManager sharedInstance] isDeviceActive:_deviceToken :self];
    }
   // [[((CustomNavigationController*)self.centerController) getTopView ] viewWillAppear:YES];*/
    pased=NO;

    
    
    
    
    
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - view deck delegate

- (BOOL)viewDeckController:(IIViewDeckController *)viewDeckController shouldBeginPanOverView:(UIView *)view {
    if (([NSStringFromClass([view class]) isEqualToString:@"UINavigationButton"] && [[[(id)view titleLabel] text] isEqualToString:@"bounce"] ) || !_canPan)
        return NO;
    if( [[((CustomNavigationController*)self.centerController) getTopView ] class] == [LoginViewController class]) {
        return NO;
    }
    
    if( [[((CustomNavigationController*)self.centerController) getTopView ] class] == [ForgetPWViewController class]) {
        return NO;
    }
    return YES;
}



- (IIViewDeckController*)generateControllerStack {
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                             bundle: nil];
    
    
    MenuViewController* menuController = [mainStoryboard instantiateViewControllerWithIdentifier:@"MenuViewController"];
    
    CustomNavigationController *centerController = [mainStoryboard instantiateViewControllerWithIdentifier:@"CustomNavigationController"];
    IIViewDeckController* deckController =  [[IIViewDeckController alloc] initWithCenterViewController:centerController leftViewController:menuController rightViewController:nil];
    if(currentLang==Arabic){
        deckController.leftController=nil;
        deckController.rightController=menuController;
    }
    if(IS_IPAD){
        deckController.leftSize = MenuStartXIPad;
        deckController.rightSize = MenuStartXIPad;
    }else{
        deckController.leftSize = MenuStartX;
        deckController.rightSize = MenuStartX;
    }
    [deckController setShadowEnabled:NO];
    [deckController setDelegate:self];
    [deckController disablePanOverViewsOfClass:NSClassFromString(@"_UITableViewHeaderFooterContentView")];
    return deckController;
}

- (BOOL)viewDeckController:(IIViewDeckController*)viewDeckController shouldOpenViewSide:(IIViewDeckSide)viewDeckSide {
    UINavigationController *navController = (UINavigationController*)self.centerController;
    
    if([[navController viewControllers] count] < 2) {
        return NO;
    }
    
    return YES;
}

-(void)switchMenuDirection{
    IIViewDeckController* deckController =(IIViewDeckController*)self.window.rootViewController;
    UIViewController* menuControler=nil;
    if(deckController.rightController!=nil)
        menuControler=deckController.rightController;
    else if (deckController.leftController!=nil)
        menuControler=deckController.leftController;
    if(menuControler==nil)return;
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                             bundle: nil];

    if(currentLang==English){
        deckController.leftController= [mainStoryboard instantiateViewControllerWithIdentifier:@"MenuViewController"];
        self.leftController=menuControler;
        self.rightController=nil;
        deckController.rightController=nil;
    }else{
        deckController.rightController=[mainStoryboard instantiateViewControllerWithIdentifier:@"MenuViewController"];//menuControler;
        self.rightController=menuControler;
        self.leftController=nil;
        deckController.leftController=nil;
    }
}
#pragma mark - funtions

-(void) updateDeviceToken{
    if(!_deviceToken){
        ProfileObj * obj= [StaticFuntions getSavedData];
        _deviceToken=obj.empDeviceToken;//[[DatabaseManager sharedInstance] currentDeviceToken];
        
    }
    
    if (_deviceToken) {
        [[RequestManager sharedInstance] updateDeviceToken:_deviceToken :self];
    }else{
        [[RequestManager sharedInstance] updateDeviceToken:@"" :self];
        
    }
}

-(void) deleteDeviceToken{
    if(!_deviceToken){
        ProfileObj * obj= [StaticFuntions getSavedData];
        _deviceToken=obj.empDeviceToken;//[[DatabaseManager sharedInstance] currentDeviceToken];
        
    }
    
    if (_deviceToken) {
        [[RequestManager sharedInstance] deleteDeviceToken:_deviceToken :self];
    }else{
        [[RequestManager sharedInstance] deleteDeviceToken:@"" :self];
        
    }
}

-(void) SetAppLanguage{
    NSString * language = [[NSLocale preferredLanguages] objectAtIndex:0];
    NSLog(@"language=%@",language);
    language=@"ar";
    if([language isEqualToString:@"en"]){
        currentLang=English;
        ICLocalizationSetLanguage(language);
    }else if([language isEqualToString:@"ar"]){
        currentLang=Arabic;
        ICLocalizationSetLanguage(language);
    }else{ // default if the device language is not form all of this
        currentLang=Arabic;
        ICLocalizationSetLanguage(@"ar");
    }
}


#pragma mark - push notification delegate


#ifdef __IPHONE_8_0

- (BOOL)checkNotificationType:(UIUserNotificationType)type
{
    UIUserNotificationSettings *currentSettings = [[UIApplication sharedApplication] currentUserNotificationSettings];
    
    return (currentSettings.types & type);
}

#endif

- (void)setApplicationBadgeNumber:(NSInteger)badgeNumber
{
    UIApplication *application = [UIApplication sharedApplication];
    
#ifdef __IPHONE_8_0
    // compile with Xcode 6 or higher (iOS SDK >= 8.0)
    
    if(SYSTEM_VERSION_LESS_THAN(@"8.0"))
    {
        application.applicationIconBadgeNumber = badgeNumber;
    }
    else
    {
        if ([self checkNotificationType:UIUserNotificationTypeBadge])
        {
            NSLog(@"badge number changed to %ld", (long)badgeNumber);
            application.applicationIconBadgeNumber = badgeNumber;
        }
        else
            NSLog(@"access denied for UIUserNotificationTypeBadge");
    }
    
#else
    // compile with Xcode 5 (iOS SDK < 8.0)
    application.applicationIconBadgeNumber = badgeNumber;
    
#endif
    
}


-(BOOL)pushNotificationOnOrOff{
    
    BOOL pushEnabled=NO;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        if ([[UIApplication sharedApplication] isRegisteredForRemoteNotifications]) {
            pushEnabled=YES;
        } else
            pushEnabled=NO;
    } else {
        UIRemoteNotificationType types = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        if (types & UIRemoteNotificationTypeAlert)
            pushEnabled=YES;
        else
            pushEnabled=NO;
    }
    return pushEnabled;
}

#ifdef __IPHONE_8_0
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    //register to receive notifications
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler
{
    //handle the actions
    if ([identifier isEqualToString:@"declineAction"]){
    }
    else if ([identifier isEqualToString:@"answerAction"]){
    }
}
#endif

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    _deviceToken = [[[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]]stringByReplacingOccurrencesOfString:@" " withString:@""];
    
   // [StaticFuntions showAlertWithTitle:@"test" Message:_deviceToken];
    
   /* if ([[DatabaseManager sharedInstance] currentUserId]!=-1) {
        if (_deviceToken) {
            if (_deviceToken.length >20) {
                [[DatabaseManager sharedInstance] setCurrentDeviceToken:_deviceToken];
            }
        }
    }*/
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    //nslog(@"Failed to get token, error: %@", error);
    
    /* [[[UIAlertView alloc] initWithTitle:@"Fail"
     message:error.debugDescription
     delegate:self
     cancelButtonTitle:@"موافق"
     otherButtonTitles:nil] show];*/
    
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    
    //application.applicationIconBadgeNumber = 0;
    [self setApplicationBadgeNumber:0];
    [self pushNotificationViewController:userInfo withOpenedApp:YES];
    [application cancelAllLocalNotifications];
    
}

-(void) pushNotificationViewController :(NSDictionary *)dictionary  withOpenedApp:(BOOL)openedApp{

    if (self.islogOut || self.EmployeeObj == nil || self.EmployeeObj.userName == nil || !self.EmployeeObj.showNotifications)
        return;
//    if(self.islogOut)return;
//    if(self.EmployeeObj==nil || self.EmployeeObj.userName==nil) return;
//    if(!self.EmployeeObj.showNotifications) return;
    NSLog(@"notifications Object: %@",dictionary);
    
   NSDictionary *notificationBody=[dictionary objectForKey:MWNotificationBody];
    NSString * message =[notificationBody objectForKey:MWNotificationAlert];
    if(openedApp)
        [StaticFuntions showAlertWithTitle:ApplicationTitleText Message:message];
    //else
        [self openScreen:SeagueNotifictaionScreen];
}

-(void)openScreen:(NSString*)seagueName{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    CustomNavigationController *navigationController = (CustomNavigationController *)appDelegate.centerController;
    if([navigationController.viewDeckController isSideOpen:IIViewDeckLeftSide]){
        [navigationController.viewDeckController toggleLeftViewAnimated:YES];
    }else if([navigationController.viewDeckController isSideOpen:IIViewDeckRightSide]){
        [navigationController.viewDeckController toggleRightViewAnimated:YES];
    }
    UIViewController *viewController = [[navigationController getTopView].storyboard instantiateViewControllerWithIdentifier:seagueName];
    if([[navigationController getTopView] class]!=[viewController class]){
        [navigationController pushViewController:viewController animated:NO];
    }else{
        if([[navigationController getTopView] class]==[NotificationViewController class]){
            [((NotificationViewController*)[navigationController getTopView]) connect];
        }
    }
}

#pragma mark - connection delegate

- (void)processCompleted:(id)data error:(CustomError *)error withService:(NSNumber *)service {
    
    if (!error) {
        if([service integerValue]==UpdateDeviceToken_WS){
            
        }else if([service integerValue]==DeleteDeviceToken_WS){
         //   [StaticFuntions showAlertWithTitle:@"delete" Message:@"test"];
        }
    }else{
        if([service integerValue]==UpdateDeviceToken_WS){
            
            NSLog(@"update device token failed");
        }else if([service integerValue]==DeleteDeviceToken_WS){
            
            NSLog(@"delete device token failed");
        }
    }
}

@end
