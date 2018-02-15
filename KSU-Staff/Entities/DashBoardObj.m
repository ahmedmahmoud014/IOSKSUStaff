//
//  DashBoardObj.m
//  KSU-Staff
//
//  Created by EJ-Mac book on 10/14/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import "DashBoardObj.h"
#import "LocalizedMessages.h"
#import "AppDelegate.h"

@implementation DashBoardObj

#pragma mark - static methods

+(UIImage*)getDBItemImage:(MyDashBoard)dashboardItem{
    switch ((int)dashboardItem) {
        case (int)ProfileDB:
            return [UIImage imageNamed:@"profile.png"];
            break;
        case (int)JobInfoDB:
            return [UIImage imageNamed:@"job_infoDB.png"];
            break;
        case (int)CustodyDB:
            return [UIImage imageNamed:@"custody.png"];
            break;
        case (int)PermissionsDB:
            return [UIImage imageNamed:@"Permissions.png"];
            break;
        case (int)RequestsDB:
            return [UIImage imageNamed:@"requests.png"];
            break;
        case (int)DelegationsDB:
            return [UIImage imageNamed:@"delegation.png"];
            break;
        case (int)VacationsDB:
            return [UIImage imageNamed:@"vacations.png"];
            break;
        case (int)SchduleDB:
            return [UIImage imageNamed:@"schedule.png"];
            break;
      
            
       /* case (int)RequestsDB:
            return [UIImage imageNamed:@"requests.png"];
            break;
        case (int)TasksDB:
            return [UIImage imageNamed:@"tasks.png"];
            break;*/
        case (int)SalaryDB:
            return [UIImage imageNamed:@"salary.png"];
            break;
        case (int)PaymentDB:
            return [UIImage imageNamed:@"payment.png"];
            break;
        case (int)CalenderDB:
            return [UIImage imageNamed:@"calendar.png"];
            break;
        case (int)ContactsDB:
            return [UIImage imageNamed:@"contactsDB.png"];
            break;
        case (int)VehiclesDB:
            return [UIImage imageNamed:@"vechiles.png"];
            break;
        case (int)ITSupportDB:
            return [UIImage imageNamed:@"ITSupportDB.png"];
            break;
        case (int)ReportProblemDB:
            return [UIImage imageNamed:@"reportProblemDB.png"];
            break;
        case (int)NoftificationDB:
            return [UIImage imageNamed:@"notificationDB.png"];
            break;
        case (int)BookDB:
            return [UIImage imageNamed:@"books_db.png"];
            break;
        case (int)Nafee:
            return [UIImage imageNamed:@"nafea.png"];
            break;
        default:
            break;
    }
    return nil;
}

+(NSString*)getDBItemTitle:(MyDashBoard)dashboardItem{
    switch ((int)dashboardItem) {
        case (int)ProfileDB:
            return profileDBText;
            break;
        case (int)JobInfoDB:
            return JobInfoText;
            break;
        case (int)PaymentDB:
            return paymentDBText;
            break;
        case (int)SalaryDB:
            return salaryDBText;
            break;
        case (int)PermissionsDB:
            return permissionsDBText;
            break;
        case (int)RequestsDB:
            return requestsDBText;
            break;
        case (int)DelegationsDB:
            return delegationsDBText;
            break;
        case (int)VacationsDB:
            return vacationsDBText;
            break;
        case (int)SchduleDB:
            return schduleDBText;
            break;
        
       /* case (int)RequestsDB:
            return requestsDBText;
            break;
        case (int)TasksDB:
            return TasksDBText;
            break;*/
        case (int)ContactsDB:
            return MenuItemContactsText;
            break;
        case (int)CustodyDB:
            return custodyDBText;
            break;
        case (int)CalenderDB:
            return calenderDBText;
            break;
        case (int)VehiclesDB:
            return VehiclesDBText;
            break;
        case (int)ITSupportDB:
            return MenuItemSupportText;
            break;
        case (int)ReportProblemDB:
            return MenuItemReportProbText;
            break;
        case (int)NoftificationDB:
            return notificationDBText;
            break;
        case (int)BookDB:
            return bookScreenTitle;
            break;
        case (int)Nafee:
            return nafeeText;
            break;

        default:
            break;
    }

    return @"";
}
+(NSString*)getDBItemSeague:(MyDashBoard)dashboardItem{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    switch ((int)dashboardItem) {
        case (int)ProfileDB:
            return SeagueProfileScreen;
            break;
        case (int)JobInfoDB:
            return SeagueJobInfoScreen;
            break;
        case (int)CustodyDB:
            return SeagueCustodyScreen;
            break;
        case (int)PermissionsDB:
            return SeaguePermissionsScreen;
            break;
        case (int)RequestsDB:
            return SeagueRequestsScreen;
            break;
        case (int)DelegationsDB:
            return SeagueDelegationsScreen;
            break;
        case (int)VacationsDB:
            if(appDelegate.EmployeeObj.isTeacher)
                return SeagueCalendarScreen;
            else
                return SeagueVacationScreen;
            break;
        case (int)SchduleDB:
            return SeagueSchduleScreen;
            break;
            
       /* case (int)RequestsDB:
            return SeagueRequestsScreen;
            break;
        case (int)TasksDB:
           return SeagueTaskScreen;
            break;*/
        case (int)PaymentDB:
            return SeaguePaymentScreen;
            break;
        case (int)SalaryDB:
            return SeagueSalaryScreen;
            break;
        case (int)ContactsDB:
            return SeagueContactsScreen;
            break;
        case (int)CalenderDB:
            return SeagueCalendarScreen;
            break;
        case (int)VehiclesDB:
            return SeagueVehiclsScreen;
            break;
        case (int)ITSupportDB:
            return SeagueITSupportScreen;
            break;
        case (int)ReportProblemDB:
            return SeagueReportProblemScreen;
            break;
        case (int)NoftificationDB:
            return SeagueNotifictaionScreen;
            break;
        case (int)BookDB:
            return SeagueBookScreen;
            break;
        case (int)Nafee:
            return SeagueCategoriesScreen;
            break;
        default:
            break;
    }
    
    return SeagueDashBoardScreen;
}

+(BOOL)getDBItemIsCommingSoon:(MyDashBoard)dashboardItem{
    switch ((int)dashboardItem) {
       /* case (int)CalenderDB:
            return YES;
            break;
        case (int)ITSupportDB:
            return YES;
            break;
        case (int)ReportProblemDB:
            return YES;
            break;
        case (int)NoftificationDB:
            return YES;
            break;*/
        default:
            break;
    }
    
    return NO;
}
@end
