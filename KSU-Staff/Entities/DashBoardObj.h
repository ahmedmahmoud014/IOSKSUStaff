//
//  DashBoardObj.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 10/14/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum myDashBoard{
    ProfileDB=0,
    JobInfoDB,
    CustodyDB,
    SalaryDB,
    PaymentDB,
    SchduleDB,
    PermissionsDB,
    RequestsDB,
    DelegationsDB,
    VacationsDB,
    //RequestsDB,
    //TasksDB,
    ContactsDB,
    ITSupportDB,
    CalenderDB,
    NoftificationDB,
    ReportProblemDB,
    VehiclesDB,
    BookDB,
    Nafee
}MyDashBoard;

@interface DashBoardObj : NSObject{
}

+(UIImage*)getDBItemImage:(MyDashBoard)dashboardItem;
+(NSString*)getDBItemTitle:(MyDashBoard)dashboardItem;
+(NSString*)getDBItemSeague:(MyDashBoard)dashboardItem;
+(BOOL)getDBItemIsCommingSoon:(MyDashBoard)dashboardItem;

@end
