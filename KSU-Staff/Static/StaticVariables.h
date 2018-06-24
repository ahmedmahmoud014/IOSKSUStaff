//
//  StaticVariables.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 9/17/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef KSU_Staff_StaticVariables_h
#define KSU_Staff_StaticVariables_h

typedef enum myLanguages{
    Arabic =0,
    English =1
}MyLanguages;

typedef enum mainMenuItems{
    //HomeItem=0,
    ChangePWItem = 0,
    getDocInquiryItem,
    SettingITem,
    LogoutItem,
    
    EditProfileItem,
    ContactsItem,
    ReportProblemItem,
    NotifcationItem,
    LanguageItem,
    AboutItem,
    ItSupportItem
    
}MainMenuItems;

typedef enum service{
    Login_WS,
    ChangePassword_WS,
    UserProfile_WS,
    EmployeeSalaryInfo_WS,
    UpdateDeviceToken_WS,
    EditUserProfile_WS,
    EmployeePaymentList_WS,
    GetTasksList_WS,
    SendClaim_WS,
    GetClaimsList_WS,
    GetPassportInfo_WS,
    GetSchdule_WS,
    GetVacationBalance_WS,
    GetContactList_WS,
    GetCustodyList_WS,
    ForgetPassword_WS,
    GetExternalDocumentUnit_WS,
    GetDocSelfInquiryDate_WS,
    GetDocSelfInquiry_WS,
    ITSupport_WS,
    Vehicles_WS,
    VerifyForgetPW_WS,
    BookBorrowed_WS,
    GetNotifications_WS,
    DeleteNotifications_WS,
    DeleteDeviceToken_WS,
    GetServicesList_WS,
    GetDelegationsList_WS,
    AddDelegationsList_WS,
    GetUsersList_WS,
    EditDelegationsList_WS,
    DeleteDelegationsList_WS,
    UpdateLanguage_WS,
    GetRequestsList_WS,
    GetRequestActionsList_WS,
    GetRequestDetails_WS,
    GetPermissionsList_WS,
    SendEmail_WS,
    getCategories,
    getCategoryItems
}Service;

#define maxITSupportSubjectText                   50
#define maxITSupportDescText                      255
#define maxClaimMsgText                           255
#define minPWLenght                               6
#define countStartJobYear                         4
#define NumberSettingItems                        4
#define NumberMenuItems                           4//5//9//10
#define MenuStartX                                70
#define MenuStartXIPad                            100
#define NumberDashBoardItems                      10//9
#define NumberPersonalInfoItems                   8//9
#define NumberJobInfoItems                        10// 11
#define NumberSalaryPaymentInfoItems              3
#define NumberPaymentDetailsItems                 4//5
#define NumberTaskDetailsItems                    3
#define NumberpassportInfoItems                   3
#define maxMailNameText                           35
#define maxMailPhoneText                          15
#define maxMailEmailText                          40
#define maxMailMsgText                            255
#define BUTTONS_Y                                 50// 15
#define BUTTONS_SIZE                              60//36
#define RESET_REQUEST_ROWS                      0//-9999
#define NUMBER_OF_LINES                           1000

#define showTotalsDBDefaultVal                    YES
#define showNotificationDefaultVal                YES

///////////////////////////////////////////////////////////////////////////////
#define nilOrJSONObjectForKey(JSON_, KEY_) [[JSON_ objectForKey:KEY_] isKindOfClass:[NSNull null]] ? nil : [JSON_ objectForKey:KEY_];



#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


/*#ifdef UI_USER_INTERFACE_IDIOM
#define IS_IPAD() (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#else
#define IS_IPAD() (false)
#endif*/

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? YES : NO)


//#define IS_IPAD ([[UIDevice currentDevice] respondsToSelector:@selector(userInterfaceIdiom)] && [[UIDevice currentDevice] userInterfaceIdiom] != UIUserInterfaceIdiomPhone)

/////////////////////////////////////////////////////////////////
//////////////////////View Seague constants///////////////////////
//////////////////////////////////////////////////////////////////
#define SeagueLoginScreen                          @"LoginViewController"

#define SeagueDashBoardScreen                      @"DashBoardViewController"
#define SeagueProfileScreen                        @"ProfileViewController"
#define SeagueSalaryScreen                         @"SalaryViewController"
#define SeaguePaymentScreen                        @"PaymentViewController"
#define SeagueVacationScreen                       @"VacationsViewController"
#define SeagueSchduleScreen                        @"ScheduleViewController"
#define SeaguePermissionsScreen                    @"PermissionsViewController"
#define SeagueRequestsScreen                       @"RequestsViewController"
#define SeagueRequestActionsScreen                 @"RequestActionsViewController"
#define SeagueRequestDetailsScreen                 @"RequestDetailsViewController"
#define SeagueRequestRowDetailsScreen              @"RequestRowDetailsViewController"
#define SeagueDelegationsScreen                    @"DelegationViewController"
#define SeagueCalendarScreen                       @"CalenderViewController"
#define SeagueTaskScreen                           @"TasksViewController"
#define SeaguePassportScreen                       @"PassportViewController"
#define SeagueTicketScreen                         @"TicketViewController"
#define SeagueContactsScreen                       @"ContactsViewController"
#define SeagueAboutScreen                          @"AboutViewController"
#define SeagueEditProfileScreen                    @"EditProfileViewController"
#define SeagueChangePasswordScreen                 @"ChangePWViewController"
#define SeagueITSupportScreen                      @"ITSupportViewController"
#define SeagueReportProblemScreen                  @"MailViewController"
#define SeagueForgetPasswordScreen                 @"ForgetPWViewController"
#define SeagueDocInfoScreen                        @"DocInfoViewController"
#define SeagueJobInfoScreen                        @"JobInfoViewController"
#define SeagueCustodyScreen                        @"CustodyViewController"
#define SeagueFinancialScreen                      @"FinancialViewController"
#define SeagueSettingScreen                        @"SettingViewController"
#define SeagueSettingArScreen                        @"SettingArViewController"

#define SeagueVehiclsScreen                        @"VehiclesViewController"
#define SeagueSendClaimScreen                      @"SendClaimViewController"
#define SeagueClaimListScreen                      @"ClaimListViewController"
#define SeagueBookScreen                           @"BookViewController"
#define SeagueNotifictaionScreen                   @"NotificationViewController"
#define SeagueCategoriesScreen                      @"CartegoriesViewController"
///////////////////////////Services general/////////////////////////////////
#define MW_URL                                     @"https://mobileapi.ksu.edu.sa/"//@"http://212.57.192.229:8016/"
#define MWPortalDev_URL                            @"http://t-k2-v01.cloudapp.net:86/Services/"
#define MWPortaltest_URL                           @"https://emptest.ksu.edu.sa/KsuMobileService/Services/"
#define MWPortalProduction_URL                     @"https://mobileapi.ksu.edu.sa/KSUSuiteMobile/Services/"
#define MWServiceName                              @"MobileAppData.svc/"
#define MWDelegationServiceName                    @"Delegations.svc/"
#define MWUsersServiceName                         @"Users.svc/"
#define MWServicesServiceName                      @"Services.svc/"
#define MWRequestsServiceName                      @"Requests.svc/"
#define MW_ScreatKeyParam                          @"SKey=943D4D1F-E067-4534-B80A-D5618D38C213"//@"SKey=M0bILe12"
#define MW_GeneralDel                              @"&"
#define MWErrorMessage                             @"Message"
#define MWlanguageParam                            @"Language="
#define operationStatusMW                          @"OperationStatus"
#define ObjPayMW                                   @"objPay"
#define ObjResultMW                                @"objResult"

#define EmployeeNumParam                           @"EmployeeNumber="
#define YearParam                                  @"Year="
#define MonthParam                                 @"Month="
///////////////////////////////////web service////////////////////////////
#define MW_LoginWS                                 @"LoginQS?"
#define MW_changePassWS                            @"ChangePassword?"
#define MW_UserProfileWS                           @"UserProfile?"
#define MW_EmployeeSalaryInfoWS                    @"EmployeeSalaryInfo?"
#define MW_UpdateDeviceTokenWS                     @"UpdateDeviceToken?"
#define MW_EditUserProfileWS                       @"EditUserProfile/"
#define MW_EmployeePaymentListWS                   @"EmployeeAllowancesInfo?"//@"EmployeePaymentList?"
#define MW_GetTasksListWS                          @"GetTasksList/"
#define MW_SendClaimWS                             @"SendClaim?"
#define MW_GetClaimsListWS                         @"GetClaimsList?"
#define MW_GetPassportInfoWS                       @"GetPassportInfo?"
#define MW_GetSchduleWS                            @"GetEmployeeCoursesSchedule?"
#define MW_GetVacationBalanceWS                    @"GetVacationBalance?"
#define MW_GetContactListWS                        @"GetContactList?"
#define MW_GetCustodyList_WS                       @"EmployeeCustody?"
#define MW_ForgetPasssword_WS                      @"ForgetPassword?"
#define MW_GetExternalDocumentUnit_WS              @"GetExternalDocumentUnit?"
#define MW_GetDocSelfInquiryDate_WS                @"GetMadarDocumentStatusWithDate?"
#define MW_GetDocSelfInquiry_WS                    @"GetMadarDocumentStatusWithCode?"
#define MW_ITSupport_WS                            @"AddITSupportRequest?"
#define MW_VerifyForgetPW_WS                       @"ForgetPasswordVerification?"
#define MW_Vehicles_WS                             @"GetVehicleList?"
#define MW_BookBorrowed_WS                         @"GetStudentBooksData?"
#define MW_GetNotifications_WS                     @"GetPushNotificationHistory?"
#define MW_DeleteNotifications_WS                  @"DeletePushNotificationHistory?"
#define MW_DeleteDeviceToken_WS                    @"DeleteDeviceToken?"
#define MW_SendEmail_WS                            @"SendEmailMobileApp?"

#define MW_ListOfServices_WS                       @"GetServiceList"
#define MW_ListOfDelegations_WS                    @"GetDelegationListIMade"
#define MW_AddDelegation_WS                        @"AddDelegation"
#define MW_GetUsers_WS                             @"GetUsersList"
#define MW_EditDelegation_WS                       @"EditDelegation"
#define MW_DeleteDelegation_WS                     @"DeleteDelegation"
#define MW_UpdateLanguage_WS                       @"UpdateLanguage"
#define MW_ListOfPermissions_WS                    @"GetPermissionList"
#define MW_ListOfRequests_WS                       @"GetRequestList"
#define MW_ListOfRequestActions_WS                 @"GetRequestActions"
#define MW_RequestDetails_WS                       @"GetRequestDetails"
/////////////////////////////login web service/////////////////////////////
#define userNameMW_param                           @"UserName="
#define passwordMW_param                           @"Password="
#define UserNameMW_paramPost                       @"UserName"
#define passwordMW_paramPost                       @"Password"
#define MW_ScreatKeyParamPost                      @"\"SKey\":\"943D4D1F-E067-4534-B80A-D5618D38C213\""//@"\"SKey\":\"M0bILe12\""
#define MW_ScreatKeyPostParamValue                 @"943D4D1F-E067-4534-B80A-D5618D38C213"
#define MW_ScreatKeyPostParam                      @"SKey"
#define MW_LanguageParamPost                       @"Language"
#define deviceTypeMW_param                         @"DeviceType=0"

#define loginResults_MW                            @"LoginQSResult"
#define startJobYear_MW                            @"StartJobYear"
#define EmpNo_MW                                   @"EmpNo"
//#define EmployeeFlag_MW                            @"EmployeeFlag"
#define loginEmpVehicleCount_MW                    @"EmpVehicleCount"
#define FacultyMember_MW                           @"FacultyMember"
#define loginEmpCustodyCount_MW                    @"EmpCustodyCount"
////////////////////////////////contacts web service///////////////////////
#define contactsResults_MW                         @"GetContactListResult"
#define contactsDescriptionMW                      @"Description"
#define contactsPhoneNumberMW                      @"PhoneNumber"
//////////////////////////////profile web service//////////////////////////
#define profileResultMW                            @"UserProfileResult"
#define profileArabicName                          @"EmployeeName"
#define profileBankAccNo                           @"BankAccNo"
#define profileBankName                            @"BankName"
#define profileCellNumber                          @"CellNumber"
#define profileContractEndDate                     @"ContractEndDate"
#define profileContractStartDate                   @"ContractStartDate"
#define profileDepartment                          @"Department"
#define profileEmailAddress                        @"EmailAddress"
#define profileEmpNumber                           @"EmployeeNumber"
#define profileEmployeeStatus                      @"EmployeeStatus"
#define profileEmpType                             @"EmployeeType"
#define profileGovStartWork                        @"GovStartWork"
#define profileGrade                               @"Grade"
#define profileGregBirthDate                       @"GregorianBirthDate"
#define profileHijriBirthDate                      @"HijriBirthDate"
#define profileHiringDate                          @"HiringDate"
#define profileLatinFullName                       @"LatinFullName"
#define profileNationalityID                       @"NationalityID"
#define profileNationalityName                     @"NationalityName"
#define profileRank                                @"Rank"
#define profileSection                             @"Section"
#define profileSocialNo                            @"SocialNo"
#define profilejobTitle                            @"jobTitle"
#define profileTelephone                           @"TelephoneNumber"
#define profileWebSite                             @"Website"
#define profileGenderFlag                          @"GenderFlag"
////////////////////////////////passportInfo/////////////////////////
#define passportExpirationDate                     @"ExpirationDate"
#define passportNumebr_mw                          @"PassportNumber"
#define passportEmployeeName                       @"EmployeeName"
#define passportInfoListMW                         @"GetPassportInfoResult"
///////////////////////////////Salary info/////////////////////////////
#define salaryResultListMW                         @"EmployeeSalaryInfoResult"
#define salaryParentObjMW                          @"objParent"
#define salaryBankNameMW                           @"BankName"
#define salaryBasicSalaryMW                        @"BasicSalary"
#define salaryPayIndicatorMW                       @"PayIndicator"
#define salaryTotalAllowanceMW                     @"TotalAllowance"
#define salaryTotalDeductionMW                     @"TotalDeduction"
#define salaryAllownanceMW                         @"Allownance"
#define salaryAllownanceAmountMW                   @"AllownanceAmount"
#define salaryAllownanceCodeMW                     @"AllownanceCode"
#define salaryIsAllownanceMW                       @"IsAllownance"

///////////////////////payment info////////////////////////////////////
#define paymentResultListMW                        @"EmployeeAllowancesInfoResult"//@"EmployeePaymentListResult"
#define paymentDetailsMW                           @"Details"
#define paymentExpenseAmountMW                     @"ExpenseAmount"
#define paymentExpenseNameMW                       @"ExpenseName"
#define paymentPayrollDateMW                       @"PayrollDate"
#define paymentIsPaidMW                            @"IsPaid"
#define paymentPayrollNumberMW                     @"PayrollNumber"
#define paymentNotesMW                             @"Notes"

//////////////////////////////change password//////////////////////////////////
#define changePWOldParam                           @"OldPassword"
#define changePWNewParam                           @"NewPassword"

#define changePWResultMW                           @"ChangePasswordResult"
/////////////////////////schedule///////////////////////////
#define scheduleResultMW                           @"GetEmployeeCoursesScheduleResult"
#define scheduleClassbuildingIdMW                   @"Buildingno"
#define scheduleClassPartitionIdMW                  @"Partition"
#define scheduleClassfloorIdMW                      @"Floorno"
#define scheduleClassroomIdMW                       @"CLASSROOM_ID"
#define scheduleCourseCodeMW                        @"CourseNo"
#define scheduleDayMW                               @"DAYNo"
#define scheduleEndTimeMW                           @"END_TIME"
#define scheduleFromTimeMW                          @"FROM_TIME"
#define scheduleSectionIDMW                         @"SECTION_ID"
////////////////////////////vacation/////////////////////////////////////////
#define vacationResultMW                           @"GetVacationBalanceResult"
#define vacationEmergencybalanceMW                 @"Emergencybalance"
#define vacationNormalBalanceMW                    @"NormalBalance"
////////////////////////////send claim////////////////////////////////////////
#define sendClaimResultMW                          @"SendClaimResult"
#define sendClaimDescParam                         @"ClaimDescription="
//////////////////////////claim list //////////////////////////////////////////
#define claimLstResultMW                           @"GetClaimsListResult"
#define claimLstDescrpMW                           @"ClaimDescription"
#define claimLstDateMW                             @"CreatedDate"
#define claimLstTicketNoMW                         @"TicketNo"
//////////////////////////custody list //////////////////////////////////////////
#define custodyLstResultMW                         @"EmployeeCustodyResult"
#define custodyQuantityMW                          @"ItemQuantity"
#define custodyItemNameMW                          @"ItemName"
#define custodyItemUnitNameMW                      @"ItemUnitName"
//////////////////////////forget password//////////////////////////////////////////
#define forgetPWResultMW                           @"ForgetPasswordResult"
#define FWVerificationMW                           @"VerificationCode"
#define FWVerifyResultMW                           @"ForgetPasswordVerificationResult"
////////////////////////////////Doc Inquiry web service////////////////////
#define DocNumberMW                                @"DocNumber="
#define DocDateMW                                  @"DocDate="
#define DocCodeMW                                  @"DocCode="
#define DocLogBookEntryYearMW                      @"DocYear="
#define ExternalDocumentUnitResult_MW              @"GetExternalDocumentUnitResult"
#define ExternalDocumentUnitObjData_MW             @"objData"
#define ExternalUnitCodeMW                         @"ExternalUnitCode"
#define ExternalUnitIDMW                           @"ExternalUnitID"
#define ExternalUnitNameMW                         @"ExternalUnitName"
#define DocEnquiryResposedate_MW                   @"GetMadarDocumentStatusWithDateResult"
#define DocEnquiryRespose_MW                       @"GetMadarDocumentStatusWithCodeResult"
#define DocEnquiryParentObjMW                      @"objParent"
#define DocActionDescriptionMW                     @"ActionDescription"
#define DocTransactionNumberMW                     @"DocTransactionNumber"
#define DocumentDateMW                             @"DocumentDate"

//////////////////////////it support///////////////////////////////////////////////
#define ITRequesterMWParam                         @"Requester="
#define ITSubjectMWParam                           @"Subject="
#define ITDescriptionMWParam                       @"Description="
#define ITPriorityMWParam                          @"Priority="
#define ITUrgencyMWParam                           @"Urgency="
#define ITAddITSupportRequestResultMW              @"success"//@"AddITSupportRequestResult"
#define ITAddingEmailParam                         @"@ksu.edu.sa"
////////////////////////vehicles///////////////////////////////////////////////
#define vehiclesRespose_MW                         @"GetVehicleListResult"
#define vehiclesArabicBoard_MW                     @"ArabicBoard"
#define vehiclesAssignDateTime_MW                  @"AssignDateTime"
#define vehiclesDeliveryDateTime_MW                @"DeliveryDateTime"
#define vehiclesModelType_MW                       @"ModelType"

///////////////////////////////////calendar/////////////////////////////////////
#define calendarListJson                           @"calendar"
#define calendarTypeJson                           @"v_type"
#define calendarHijriJson                          @"hijriDate"
#define calendarGreogJson                          @"greogDate"
////////////////////////book borrowed///////////////////////////////////////////////
#define bookResposeResult_MW                       @"GetStudentBooksDataResult"
#define bookBorrowedStudentParam                   @"RequesterId="
#define bookNameTag_MW                             @"BookTagName"
//////////////////////updateDevice token///////////////////////////////////////////
#define deviceTokenMWParam                         @"DeviceTokenId="
#define deviceTokenResult_MW                       @"UpdateDeviceTokenResult"
/////////////////////////////get notifications/////////////////////////////////////
#define getPushNotifyResult_MW                     @"GetPushNotificationHistoryResult"
#define deletePushNotifyResult_MW                     @"DeletePushNotificationHistoryResult"
#define getPushNotifyMessageDate_MW                @"MessageDate"
#define getPushNotifyMessageText_MW                @"MessageText"
///////////////////////////////////notification//////////////////////////////////
#define MWNotificationBody                        @"aps"
#define MWNotificationMessage                     @"body"
#define MWNotificationAlert                       @"alert"
#define MWNotificationMessLocalize                @"loc-key"
#define MWNotificationBadge                       @"badge"
////////////////////////////////delete device token////////////////////////////
#define DeleteDeviceResult_MW                     @"DeleteDeviceTokenResult"

/////////////////////////////Services web service/////////////////////////////
#define userNameMW_paramPost                       @"userName"
#define MW_languageParamPost                       @"language"
#define forceGetMW_paramPost                       @"forceGet"
#define getServiceListResults_MW                   @"GetServiceListResult"
#define response_MW                                @"response"
#define servicesCashedMW                           @"cached"
#define listMW                                     @"list"
#define serviceCodeMW                              @"serviceCode"
#define serviceNameMW                              @"serviceName"
#define serviceNameEnMW                            @"serviceName_en"
#define error_message_MW                           @"error_message"
#define status_MW                                  @"status"
#define successStatusMW                            @"success"
/////////////////////////////Permissions web service/////////////////////////////
#define getPermissionsListResults_MW               @"GetPermissionListResult"
#define pagesMW                                    @"pages"
#define pageNameMW                                 @"pageName"
#define actionsMW                                  @"actions"
/////////////////////////////Delegations web service/////////////////////////////
#define delegationIDMW_paramPost                   @"delegationID"
#define directionMW_paramPost                      @"direction"
#define filter_paramPost                           @"filter"
#define getDelegationListIMadeResults_MW           @"GetDelegationListIMadeResult"
#define addDelegationResult_MW                     @"AddDelegationResult"
#define getUsersListResults_MW                     @"GetUsersListResult"
#define editDelegationResults_MW                   @"EditDelegationResult"
#define deleteDelegationResults_MW                 @"DeleteDelegationResult"
#define listOfDelegationsMW                        @"delegationsObj"
#define delegationIdMW                             @"delegationId"
#define delegationrequesterUserNameMW              @"requesterUserName"
#define delegationactorUserNameMW                  @"actorUserName"
#define requestCodeMW                              @"requestCode"
#define serviceCodeMW                              @"serviceCode"
#define startDateMW                                @"startDate"
#define startDateNoMW                              @"startDateNo"
#define endDateMW                                  @"endDate"
#define endDateNoMW                                @"endDateNo"
#define statusMW                                   @"status"
#define userMW                                     @"user"
#define userNameMW                                 @"userName"
#define nameMW                                     @"name"
#define jobTitleMW                                 @"jobTitle"
#define jobCodeMW                                  @"jobCode"
#define delegationsCountMW                         @"delegationsCount"
////////////////////updateLanguage web service/////////////////////////////////////////
#define updateLanguageResult_MW                    @"UpdateLanguageResult"
//////////////////////////////request web service//////////////////////////
#define requestResultMW                            @"GetRequestListResult"
#define category_paramPost                         @"category"
#define filter_paramPost                           @"filter"
#define requesterFilter_paramPost                  @"requesterFilter"
#define fromDate_paramPost                         @"fromDate"
#define toDate_paramPost                           @"toDate"
#define completedCount_MW                          @"completedCount"
#define inboxCount_MW                              @"inboxCount"
#define mineCount_MW                               @"mineCount"
#define searchCount_MW                             @"searchCount"

#define processedCount_MW                          @"processedCount"
#define requestDate_MW                             @"requestDate"
#define requestStatus_MW                           @"requestStatus"
#define requesterName_MW                           @"requesterName"
#define requesterTypeName_MW                       @"requestTypeName"
#define requestActionsResultMW                     @"GetRequestActionsResult"
#define requestActionMW                            @"action"
#define requestActorNameMW                         @"actorName"
#define requestNotesMW                             @"notes"
#define requestDateMW                              @"requestDate"
#define requestDetailsResultMW                     @"GetRequestDetailsResult"
#define requestPagesMW                             @"pages"
#define requestPageSectionsMW                      @"sections"
#define requestPageSectionRowsMW                   @"rows"
#define SectionTitleMW                             @"title"
#define rowDataTypeMW                              @"dataType"
#define rowLabelMW                                 @"label"
#define rowListValueMW                             @"listValue"
#define rowSingleValueMW                           @"singleValue"
//////////////////////////////Send Mail web service//////////////////////////
#define NameParam                                  @"Name="
#define MobileNoParam                              @"mobileNo="
#define SenderEmailParam                           @"SenderEmail="
#define MessageTextParam                           @"MessageText="
#define SendEmailMobileMW                          @"SendEmailMobileAppResult"


#pragma mark - Cells' Constants -

#define STATUS @"STATUS"
#define TYPE @"TYPE"
#define ITEM @"ITEM"
#define ACTION @"ACTION"
#define ACTION_VALUE @"ACTION_VALUE"

#define MIN_DETAILS_CELL_HEIGHT 44.0f
#define MIN_CELL_HEIGHT 55.0f // Default height for regular cells
#define MIN_HEADER_HEIGHT 22.0f
#define MARGIN 12.0f

#pragma mark - Cell Type Enum -

typedef enum {
    HEADER_CELL = 1,
    LIST_CELL = 2,
    DETAILED_CELL = 3,
    TITLE_VALUE_CELL = 4,
    VALUE_ONLY_CELL = 5
} CELL_TYPE;

#pragma mark - Cell Action Enum -

typedef enum {
    ADD = 1,
    DETAILS = 2,
    NOTHING = 3
} CELL_ACTION;

#pragma mark - Cell Status Enum -

typedef enum {
    CLOSED = 1,
    OPENED = 2
} CELL_STATUS;

#pragma mark - UIColorFromRGB-

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#endif
