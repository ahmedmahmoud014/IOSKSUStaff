//
//  AppDelegate.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 9/17/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IIViewDeckController.h"
#import "StaticVariables.h"
//#import "TestFlight.h"
#import "ProfileObj.h"
#import "DashboardDataObj.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate,IIViewDeckControllerDelegate>{
    BOOL pased;
    MyLanguages currentLang;
    BOOL islogOut;
    DashboardDataObj *DB_data;
    bool isSendingDeviceToken;
}


@property (strong, nonatomic) UIWindow *window;
@property (readonly, retain) NSString *deviceToken;

@property (nonatomic) BOOL pased;
@property (nonatomic) bool isSendingDeviceToken;

@property (retain, nonatomic) UIViewController *centerController;
@property (retain, nonatomic) UIViewController *leftController;
@property (retain, nonatomic) UIViewController *rightController;
@property (nonatomic, readwrite) BOOL canPan;
@property (nonatomic)MyLanguages currentLang;
@property (nonatomic) BOOL islogOut;


@property (nonatomic,retain) ProfileObj *EmployeeObj;
@property (nonatomic,retain) DashboardDataObj *DB_data;

- (IIViewDeckController*)generateControllerStack;

-(void) updateDeviceToken;
-(void) deleteDeviceToken;


-(void) switchMenuDirection;
@end
