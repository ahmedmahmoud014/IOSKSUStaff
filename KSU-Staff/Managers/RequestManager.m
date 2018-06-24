//
//  RequestManager.m
//  KSU-Staff
//
//  Created by EJ-Mac book on 12/10/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import "RequestManager.h"
#import "AppDelegate.h"
#import "DataTransfer.h"
#import "ExternalDocumentUnitObj.h"
#import "DocInfoObj.h"
#import "ScheduleObj.h"
#import "ProfileObj.h"
#import "ContactObj.h"
#import "RequestObj.h"
#import "RequestActionsObj.h"
#import "RPageObj.h"
#import "RPageSectionObj.h"
#import "RPageSectionRowObj.h"
#import "PassportObj.h"
#import "SalaryObj.h"
#import "PaymentDetailsObj.h"
#import "ClaimObj.h"
#import "CustodyObj.h"
#import "LocalizedMessages.h"
#import "VehicleObj.h"
#import "BookObj.h"
#import "NotifyObj.h"
#import "NotifyDetailsObj.h"
#import "ServicesObj.h"
#import "PermissionObj.h"
#import "PageObj.h"
#import "UserObj.h"
#import "Categories.h"
#import "CategoryListItems.h"

#import "Contact.h"

#import "NSDictionary+NotNull.h"

#import "AFHTTPSessionManager.h"

@implementation RequestManager

#pragma mark - general funtions
+ (RequestManager *)sharedInstance   {
    static RequestManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[RequestManager alloc] init];
    });
    return sharedInstance;
}

- (NSString *)getFullServiceString:(Service)service  {
    if (service == GetPermissionsList_WS || service == GetServicesList_WS || service == GetDelegationsList_WS || service == AddDelegationsList_WS || service == GetUsersList_WS || service == EditDelegationsList_WS || service == DeleteDelegationsList_WS || service == UpdateLanguage_WS || service == GetRequestsList_WS || service == GetRequestActionsList_WS || service == GetRequestDetails_WS) {
        NSLog(@"%@", [NSString stringWithFormat:@"%@%@%@",MWPortalProduction_URL,[self getServiceName:service],[self getStringForService:service]]);
        return [NSString stringWithFormat:@"%@%@%@",MWPortalProduction_URL,[self getServiceName:service],[self getStringForService:service]];
        //return [NSString stringWithFormat:@"%@%@%@",MWPortaltest_URL,[self getServiceName:service],[self getStringForService:service]];
        //return [NSString stringWithFormat:@"%@%@%@",MWPortalDev_URL,[self getServiceName:service],[self getStringForService:service]];
    } else {
        NSLog(@"%@", [NSString stringWithFormat:@"%@%@%@",MW_URL,[self getServiceName:service],[self getStringForService:service]]);
        return [NSString stringWithFormat:@"%@%@%@",MW_URL,[self getServiceName:service],[self getStringForService:service]];
    }
}


-(NSString *)getServiceName:(Service)service{
    
    if (service == GetPermissionsList_WS || service == GetUsersList_WS || service == UpdateLanguage_WS)
        return MWUsersServiceName;
    else if (service == GetServicesList_WS)
        return MWServicesServiceName;
    else if (service == GetDelegationsList_WS || service == AddDelegationsList_WS || service == EditDelegationsList_WS || service == DeleteDelegationsList_WS)
        return MWDelegationServiceName;
    else if (service == GetRequestsList_WS || service == GetRequestActionsList_WS || service == GetRequestDetails_WS)
        return MWRequestsServiceName;
    else
        return MWServiceName;
    
    
//    if (service == GetPermissionsList_WS)
//        return MWUsersServiceName;
//    else if (service == GetServicesList_WS)
//        return MWServicesServiceName;
//    else if (service == GetDelegationsList_WS)
//        return MWDelegationServiceName;
//    else if (service == AddDelegationsList_WS)
//        return MWDelegationServiceName;
//    else if (service == GetUsersList_WS)
//        return MWUsersServiceName;
//    else if (service == EditDelegationsList_WS)
//        return MWDelegationServiceName;
//    else if (service == DeleteDelegationsList_WS)
//        return MWDelegationServiceName;
//    else if (service == UpdateLanguage_WS)
//        return MWUsersServiceName;
//    else if (service == GetRequestsList_WS)
//        return MWRequestsServiceName;
//    else if (service == GetRequestActionsList_WS)
//        return MWRequestsServiceName;
//    else if (service == GetRequestDetails_WS)
//        return MWRequestsServiceName;
//    else
//        return MWServiceName;
    
}

- (NSString *)getStringForService:(Service)service   {
    
    NSString * serviceString ;
    switch (service) {
        case Login_WS:
            serviceString = MW_LoginWS;
            break;
        case GetContactList_WS:
            serviceString = MW_GetContactListWS;
            break;
        case UserProfile_WS:
            serviceString=MW_UserProfileWS;
            break;
        case GetPassportInfo_WS:
            serviceString=MW_GetPassportInfoWS;
            break;
        case EmployeeSalaryInfo_WS:
            serviceString=MW_EmployeeSalaryInfoWS;
            break;
        case EmployeePaymentList_WS:
            serviceString=MW_EmployeePaymentListWS;
            break;
        case ChangePassword_WS:
            serviceString=MW_changePassWS;
            break;
        case GetSchdule_WS:
            serviceString=MW_GetSchduleWS;
            break;
        case GetVacationBalance_WS:
            serviceString=MW_GetVacationBalanceWS;
            break;
        case SendClaim_WS:
            serviceString=MW_SendClaimWS;
            break;
        case GetClaimsList_WS:
            serviceString=MW_GetClaimsListWS;
            break;
        case GetCustodyList_WS:
            serviceString=MW_GetCustodyList_WS;
            break;
        case ForgetPassword_WS:
            serviceString=MW_ForgetPasssword_WS;
            break;
        case GetExternalDocumentUnit_WS:
            serviceString=MW_GetExternalDocumentUnit_WS;
            break;
        case GetDocSelfInquiryDate_WS:
            serviceString=MW_GetDocSelfInquiryDate_WS;
            break;
        case GetDocSelfInquiry_WS:
            serviceString=MW_GetDocSelfInquiry_WS;
            break;
        case ITSupport_WS:
            serviceString=MW_ITSupport_WS;
            break;
        case VerifyForgetPW_WS:
            serviceString=MW_VerifyForgetPW_WS;
            break;
        case Vehicles_WS:
            serviceString=MW_Vehicles_WS;
            break;
        case BookBorrowed_WS:
            serviceString=MW_BookBorrowed_WS;
            break;
        case UpdateDeviceToken_WS:
            serviceString=MW_UpdateDeviceTokenWS;
            break;
        case GetNotifications_WS:
            serviceString=MW_GetNotifications_WS;
            break;
        case DeleteNotifications_WS:
            serviceString=MW_DeleteNotifications_WS;
            break;
        case DeleteDeviceToken_WS:
            serviceString=MW_DeleteDeviceToken_WS;
            break;
        case GetServicesList_WS:
            serviceString=MW_ListOfServices_WS;
            break;
        case GetDelegationsList_WS:
            serviceString=MW_ListOfDelegations_WS;
            break;
        case AddDelegationsList_WS:
            serviceString=MW_AddDelegation_WS;
            break;
        case GetUsersList_WS:
            serviceString=MW_GetUsers_WS;
            break;
        case EditDelegationsList_WS:
            serviceString=MW_EditDelegation_WS;
            break;
        case DeleteDelegationsList_WS:
            serviceString=MW_DeleteDelegation_WS;
            break;
        case UpdateLanguage_WS:
            serviceString=MW_UpdateLanguage_WS;
            break;
        case GetPermissionsList_WS:
            serviceString=MW_ListOfPermissions_WS;
            break;
        case GetRequestsList_WS:
            serviceString=MW_ListOfRequests_WS;
            break;
        case GetRequestActionsList_WS:
            serviceString=MW_ListOfRequestActions_WS;
            break;
        case GetRequestDetails_WS:
            serviceString=MW_RequestDetails_WS;
            break;
        case SendEmail_WS:
            serviceString=MW_SendEmail_WS;
            break;
        default:
            break;
    }
    return serviceString;
    
}

+ (NSString *)addSecretKeyURL:(NSString*)URL{
    return [NSString stringWithFormat:@"%@%@%@",URL,MW_GeneralDel,MW_ScreatKeyParam];
}

+ (NSString *)addLanguageURL:(NSString*)URL{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return [NSString stringWithFormat:@"%@%@%@%d",URL,MW_GeneralDel,MWlanguageParam,(int)appDelegate.currentLang];
}

#pragma mark - private methods

- (NSString *)stringIntParam:(NSString *)key value:(int)value   {
    
    return [NSString stringWithFormat:@"%@%d",key,value];
}
- (NSString *)stringDoubleParam:(NSString *)key value:(double)value   {
    
    return [NSString stringWithFormat:@"%@%f",key,value];
}
- (NSString *)stringParam:(NSString *)key value:(NSString *)value {
    
    return [NSString stringWithFormat:@"%@%@",key,value];
}

- (NSString *)stringBoolParam:(NSString *)key value:(BOOL)value {
    
    return [NSString stringWithFormat:@"%@%d",key,value?1:0];
}

#pragma mark - services methods

-(void)login:(id)delegate withUsername:(NSString*)user withPassword:(NSString*)pass{
    Service serv= Login_WS;
    NSString *urlString=[self getFullServiceString:serv];
    
    NSLog(@"login url=%@",urlString);
    
    NSURL *url =  [[NSURL alloc] initWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    DataTransfer *dataTransfer= [[DataTransfer alloc] init];
    dataTransfer.delegate = delegate;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSDictionary *parameter = @{UserNameMW_paramPost:user,
                                passwordMW_paramPost:pass,
                                MW_LanguageParamPost:[NSNumber numberWithInt:(int)appDelegate.currentLang],
                                MW_ScreatKeyPostParam:MW_ScreatKeyPostParamValue};
    
    [manager POST:[url absoluteString]
       parameters:parameter
          success:^(NSURLSessionDataTask *task, id responseObject) {
              [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
              NSLog(@"success: %@",responseObject);
              id result = [responseObject objectForKeyedSubscript:loginResults_MW];
              id op_result= [result objectForKeyedSubscript:ObjResultMW];
              BOOL operationStatus=[[op_result objectForKeyedSubscript:operationStatusMW] boolValue];
              
              if (operationStatus) {
                  NSArray* objPay =(NSArray*) [result objectForKeyedSubscript:ObjPayMW]  ;
                  NSString *startYear=@"";
                  if([[objPay objectAtIndex:0] objectForKeyedSubscript:startJobYear_MW]!= [NSNull null])
                      startYear=[[objPay objectAtIndex:0] objectForKeyedSubscript:startJobYear_MW];
                  NSString *emId=[[objPay objectAtIndex:0]  objectForKeyedSubscript:EmpNo_MW];
                  BOOL flag=[[[objPay objectAtIndex:0]  objectForKeyedSubscript:FacultyMember_MW] boolValue];
                  BOOL hasVel=[[[objPay objectAtIndex:0]  objectForKeyedSubscript:loginEmpVehicleCount_MW] boolValue];
                  
                  ProfileObj *obj=[[ProfileObj alloc] init];
                  [obj initWithEmpNo:emId withStartYear:startYear isATeacher:flag hasVehicles:hasVel];
                  [dataTransfer dataLoaded:obj error:nil withService:serv];
              }else{
                  CustomError *customError = [CustomError initWithError:op_result];
                  [dataTransfer dataLoaded:nil error:customError withService:serv];
                  
              }
        
          }
          failure:^(NSURLSessionDataTask *task, NSError *error) {
              [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
              

              CustomError * customError = [[CustomError alloc] init];
              /*if(error)
               customError.errorMessage = [error.userInfo objectForKey:@"NSLocalizedDescription"];
               else
               customError.errorMessage=@"unknown error";*/
              customError.errorMessage=ServerErrorMsg;
              [dataTransfer dataLoaded:nil error:customError withService:serv];
          }];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

-(void)contacts:(id)delegate{
    Service serv= GetContactList_WS;
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSString * urlString = [NSString stringWithFormat:@"%@%@%d",[self getFullServiceString:serv],MWlanguageParam,(int)appDelegate.currentLang] ;
    //urlString=[RequestManager addLanguageURL:urlString];
    urlString=[RequestManager addSecretKeyURL:urlString];
    
    NSLog(@"contacts url=%@",urlString);
    
    NSURL *url =  [[NSURL alloc] initWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    DataTransfer *dataTransfer= [[DataTransfer alloc] init];
    dataTransfer.delegate = delegate;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    
    [manager GET:[url absoluteString]
      parameters:nil
         success:^(NSURLSessionDataTask *task, id responseObject) {
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        NSLog(@"success: %@",responseObject);
        id result = [responseObject objectForKeyedSubscript:contactsResults_MW];
        id op_result= [result objectForKeyedSubscript:ObjResultMW];
        BOOL operationStatus=[[op_result objectForKeyedSubscript:operationStatusMW] boolValue];
        
        if (operationStatus) {
            NSArray* objPay =(NSArray*) [result objectForKeyedSubscript:ObjPayMW]  ;
            
            NSMutableArray *contacts= [[NSMutableArray alloc] init];
            if(objPay && objPay!=(NSArray*)[NSNull null]){
                for(int i=0; i<[objPay count];i++){
                    NSString *descr=[[objPay objectAtIndex:i] objectForKeyedSubscript:contactsDescriptionMW];
                    NSString *phNo=[[objPay objectAtIndex:i]  objectForKeyedSubscript:contactsPhoneNumberMW];
                    ContactObj *obj=[[ContactObj alloc] init];
                    obj.contactName=descr;
                    obj.phoneNo=phNo;
                    [contacts addObject:obj];
                }
            }
            [dataTransfer dataLoaded:contacts error:nil withService:serv];
        }else{
            CustomError *customError = [CustomError initWithError:op_result];
            [dataTransfer dataLoaded:nil error:customError withService:serv];
        }
        
    }  failure:^(NSURLSessionDataTask *task, NSError *error) {
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
             
             // Handle failure
             NSLog(@"failed: %@",error);
             CustomError * customError = [[CustomError alloc] init];
             customError.errorMessage=ServerErrorMsg;
             [dataTransfer dataLoaded:nil error:customError withService:serv];
         }];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];


}

-(void)getOffersCategories:(id)delegate{
    Service serv= getCategories;
    NSString * urlString=@"https://nafae.ksu.edu.sa/api/offersCategories";
   // urlString=[self stringParam:urlString value:MW_GeneralDel];
   // urlString=[RequestManager addSecretKeyURL:urlString];
    NSLog(@"categories  url=%@",urlString);
    NSURL *url =  [[NSURL alloc] initWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    DataTransfer *dataTransfer= [[DataTransfer alloc] init];
    dataTransfer.delegate = delegate;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    
    [manager GET:[url absoluteString]
      parameters:nil
         success:^(NSURLSessionDataTask *task, id responseObject) {
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
             
          //   NSLog(@"success: %@",responseObject);
             
             // create new array for all categories
             NSMutableArray *categoriesArray = [[NSMutableArray alloc] init];
             
             for (NSDictionary *cat in responseObject) {
                 Categories *obj=[[Categories alloc] init];
                 [obj initWithCatName:cat[@"name"] category_id:cat[@"category_id"] url_title:cat[@"url_title"] offersPath:cat[@"offersPath"]];
                 [categoriesArray addObject:obj];
                 NSLog(@"category_id test : %@", obj.category_id);
                 NSLog(@"fullName: %@",  obj.fullName);

             }
             [dataTransfer dataLoaded:categoriesArray error:nil withService:serv];

            

            // NSLog(@"success: %@",responseObject[4]);

             
             
//             id result = [responseObject objectForKeyedSubscript:profileResultMW];
//             id op_result= [result objectForKeyedSubscript:ObjResultMW];
//             BOOL operationStatus=[[op_result objectForKeyedSubscript:operationStatusMW] boolValue];
//             if (operationStatus) {
//                 NSArray* objPay =(NSArray*) [result objectForKeyedSubscript:ObjPayMW]  ;
//
//                 AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//                 ProfileObj *obj= appDelegate.EmployeeObj;
//                 appDelegate.EmployeeObj=obj;
//                 [dataTransfer dataLoaded:obj error:nil withService:serv];
//             }else{
//                 CustomError *customError = [CustomError initWithError:op_result];
//                 [dataTransfer dataLoaded:nil error:customError withService:serv];
//
//             }
             
         } failure:^(NSURLSessionDataTask *task, NSError *error) {
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
             
             // Handle failure
             NSLog(@"failed: %@",error);
             CustomError * customError = [[CustomError alloc] init];
             customError.errorMessage=ServerErrorMsg;
             [dataTransfer dataLoaded:nil error:customError withService:serv];
         }];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    
}
-(UIImage *)generateImage:(NSString *)url{
        NSString *imageFromUrl= url;
        NSURL *urlValue = [NSURL URLWithString:imageFromUrl];
        NSData *data = [NSData dataWithContentsOfURL:urlValue];
        UIImage *image = [UIImage imageWithData:data];
    return image;
}

-(void)getCategoryItems:(id)delegate CatName:(NSString *)CatName{
    Service serv= getCategoryItems;
    NSString * urlString= [NSString stringWithFormat: @"%@%@", @"https://nafae.ksu.edu.sa/api/offersJSON/category/", CatName];
 
    // urlString=[self stringParam:urlString value:MW_GeneralDel];
    // urlString=[RequestManager addSecretKeyURL:urlString];
    NSLog(@"categoryItems_url=%@",urlString);
    NSURL *url =  [[NSURL alloc] initWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    DataTransfer *dataTransfer= [[DataTransfer alloc] init];
    dataTransfer.delegate = delegate;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    
    [manager GET:[url absoluteString]
      parameters:nil
         success:^(NSURLSessionDataTask *task, id responseObject) {
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
             
             //   NSLog(@"success: %@",responseObject);
             
             // create new array for all categories
             NSMutableArray *categoriesArray = [[NSMutableArray alloc] init];
             
             for (NSDictionary *cat in responseObject) {
                Contact *contact = [[Contact alloc] init];;
     
                NSDictionary  *contactValue= cat[@"contact"][0];
                 [contact initWithContact:[contactValue objectForKey:@"phone"] mobile:[ contactValue objectForKey:@"mobile"] email:[contactValue objectForKey:@"email"] website:[contactValue objectForKey:@"website"]  location:[contactValue objectForKey:@"location"] ];
                 NSMutableArray *allIamge =[[NSMutableArray alloc]init];
                 NSArray *allImageValue=cat[@"slide_images"];
                 //for (NSString *imageUrl in  allImageValue ){
//                   UIImage *image =   [self generateImage:imageUrl];
//                     if(image != nil)
//                     {
//                     [allIamge addObject:image];
//                     }
//                 }
                 
                 CategoryListItems *obj=[[CategoryListItems alloc] init];
                 [obj initWithCatItemName:cat[@"title"]status:cat[@"status"] created:cat[@"created"] description:cat[@"description"] expiration_date:cat[@"expiration_date"] offer_url:cat[@"offer_url"] contact:contact  benf:cat[@"benf"] discount_perc:cat[@"discount_perc"] likes:cat[@"likes"] dislikes:cat[@"dislikes"] keywords:cat[@"keywords"] slide_images:allImageValue];
                 [categoriesArray addObject:obj];
                 
                // NSLog(@"fullName: %@",  obj.title);
                 
             }
             [dataTransfer dataLoaded:categoriesArray error:nil withService:serv];
             
             
             
             // NSLog(@"success: %@",responseObject[4]);
             
             
             
             //             id result = [responseObject objectForKeyedSubscript:profileResultMW];
             //             id op_result= [result objectForKeyedSubscript:ObjResultMW];
             //             BOOL operationStatus=[[op_result objectForKeyedSubscript:operationStatusMW] boolValue];
             //             if (operationStatus) {
             //                 NSArray* objPay =(NSArray*) [result objectForKeyedSubscript:ObjPayMW]  ;
             //
             //                 AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
             //                 ProfileObj *obj= appDelegate.EmployeeObj;
             //                 appDelegate.EmployeeObj=obj;
             //                 [dataTransfer dataLoaded:obj error:nil withService:serv];
             //             }else{
             //                 CustomError *customError = [CustomError initWithError:op_result];
             //                 [dataTransfer dataLoaded:nil error:customError withService:serv];
             //
             //             }
             
         } failure:^(NSURLSessionDataTask *task, NSError *error) {
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
             
             // Handle failure
             NSLog(@"failed: %@",error);
             CustomError * customError = [[CustomError alloc] init];
             customError.errorMessage=ServerErrorMsg;
             [dataTransfer dataLoaded:nil error:customError withService:serv];
         }];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    
}

-(void)getProfileData:(id)delegate forEmpNo:(NSString*)Empno{
    Service serv= UserProfile_WS;
    NSString * urlString = [NSString stringWithFormat:@"%@%@%@",
                            [self getFullServiceString:serv],
                            EmployeeNumParam,Empno];
    urlString=[RequestManager addLanguageURL:urlString];
    urlString=[self stringParam:urlString value:MW_GeneralDel];
    urlString=[RequestManager addSecretKeyURL:urlString];
    
    NSLog(@"profile url=%@",urlString);
    NSURL *url =  [[NSURL alloc] initWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    DataTransfer *dataTransfer= [[DataTransfer alloc] init];
    dataTransfer.delegate = delegate;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    
    [manager GET:[url absoluteString]
      parameters:nil
         success:^(NSURLSessionDataTask *task, id responseObject) {
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
             
             NSLog(@"success: %@",responseObject);
             id result = [responseObject objectForKeyedSubscript:profileResultMW];
             id op_result= [result objectForKeyedSubscript:ObjResultMW];
             BOOL operationStatus=[[op_result objectForKeyedSubscript:operationStatusMW] boolValue];
             
             if (operationStatus) {
                 NSArray* objPay =(NSArray*) [result objectForKeyedSubscript:ObjPayMW]  ;
                 
                 AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                 ProfileObj *obj= appDelegate.EmployeeObj;
                 
                 obj.bankAccNo=[[objPay objectAtIndex:0] objectForKeyedSubscript:profileBankAccNo];
                 obj.bankName=[[objPay objectAtIndex:0]  objectForKeyedSubscript:profileBankName];
                 
                 obj.birthday=[[objPay objectAtIndex:0] objectForKeyedSubscript:profileGregBirthDate];
                 obj.hijriBirthday=[[objPay objectAtIndex:0]  objectForKeyedSubscript:profileHijriBirthDate];
                 
                 obj.department=[[objPay objectAtIndex:0] objectForKeyedSubscript:profileDepartment];
                 obj.fullName=[[objPay objectAtIndex:0]  objectForKeyedSubscript:profileArabicName];
                 
                 obj.grade=[[objPay objectAtIndex:0] objectForKeyedSubscript:profileGrade];
                 obj.hiringDate=[[objPay objectAtIndex:0]  objectForKeyedSubscript:profileHiringDate];
                 
                 obj.jobTitle=[[objPay objectAtIndex:0] objectForKeyedSubscript:profilejobTitle];
                 obj.mobNo=[[objPay objectAtIndex:0]  objectForKeyedSubscript:profileCellNumber];
                 
                 obj.nationality=[[objPay objectAtIndex:0] objectForKeyedSubscript:profileNationalityName];
                 obj.rank=[[objPay objectAtIndex:0]  objectForKeyedSubscript:profileRank];
                 
                 obj.section=[[objPay objectAtIndex:0] objectForKeyedSubscript:profileSection];
                 obj.socialNo=[[objPay objectAtIndex:0]  objectForKeyedSubscript:profileSocialNo];
                 
                 obj.stratDate=[[objPay objectAtIndex:0] objectForKeyedSubscript:profileGovStartWork];
                 obj.type=[[objPay objectAtIndex:0]  objectForKeyedSubscript:profileEmpType];
                 
                 obj.telNo=[[objPay objectAtIndex:0]  objectForKeyedSubscript:profileTelephone];
                 obj.alternativeEmail=[[objPay objectAtIndex:0]  objectForKeyedSubscript:profileEmailAddress];
                 
                 obj.status=[[objPay objectAtIndex:0] objectForKeyedSubscript:profileEmployeeStatus];
                 obj.webSite=[[objPay objectAtIndex:0]  objectForKeyedSubscript:profileWebSite];
                 
                 obj.latinName=[[objPay objectAtIndex:0]  objectForKeyedSubscript:profileLatinFullName];
                 obj.isMale=[[[objPay objectAtIndex:0]  objectForKeyedSubscript:profileGenderFlag] boolValue];
                 
             
                 [dataTransfer dataLoaded:obj error:nil withService:serv];
             }else{
                 CustomError *customError = [CustomError initWithError:op_result];
                 [dataTransfer dataLoaded:nil error:customError withService:serv];
                 
             }
             
         } failure:^(NSURLSessionDataTask *task, NSError *error) {
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
             
             // Handle failure
             NSLog(@"failed: %@",error);
             CustomError * customError = [[CustomError alloc] init];
             customError.errorMessage=ServerErrorMsg;
             [dataTransfer dataLoaded:nil error:customError withService:serv];
         }];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
   
}
-(void)getPassportInfo:(id)delegate forEmpNo:(NSString*)Empno{
    Service serv= GetPassportInfo_WS;
    NSString * urlString = [NSString stringWithFormat:@"%@%@%@",
                            [self getFullServiceString:serv],
                            EmployeeNumParam,Empno];
    urlString=[RequestManager addLanguageURL:urlString];
    urlString=[self stringParam:urlString value:MW_GeneralDel];
    urlString=[RequestManager addSecretKeyURL:urlString];
    
    NSLog(@"passport url=%@",urlString);
    
    NSURL *url =  [[NSURL alloc] initWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    DataTransfer *dataTransfer= [[DataTransfer alloc] init];
    dataTransfer.delegate = delegate;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    
    [manager GET:[url absoluteString]
      parameters:nil
         success:^(NSURLSessionDataTask *task, id responseObject) {
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
             
        NSLog(@"success: %@",responseObject);
        id result = [responseObject objectForKeyedSubscript:passportInfoListMW];
        id op_result= [result objectForKeyedSubscript:ObjResultMW];
        BOOL operationStatus=[[op_result objectForKeyedSubscript:operationStatusMW] boolValue];
        
        if (operationStatus) {
            NSArray* objPay =(NSArray*) [result objectForKeyedSubscript:ObjPayMW]  ;
            PassportObj *obj=[[PassportObj alloc] init];
            obj.expireDate=[[objPay objectAtIndex:0] objectForKeyedSubscript:passportExpirationDate];
            obj.passportNo=[[objPay objectAtIndex:0] objectForKeyedSubscript:passportNumebr_mw];
            obj.name=[[objPay objectAtIndex:0] objectForKeyedSubscript:passportEmployeeName];
            
            [dataTransfer dataLoaded:obj error:nil withService:serv];
        }else{
   
            PassportObj *obj=[[PassportObj alloc] init];
            [dataTransfer dataLoaded:obj error:nil withService:serv];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        // Handle failure
        NSLog(@"failed: %@",error);
        CustomError * customError = [[CustomError alloc] init];
        customError.errorMessage=ServerErrorMsg;
        [dataTransfer dataLoaded:nil error:customError withService:serv];
    }];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];

}

-(void)getSalaryData:(id)delegate forEmpNo:(NSString*)Empno withMonth:(NSString*)month withYear:(NSString*)Year{
    Service serv= EmployeeSalaryInfo_WS;
    NSString * urlString = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@",
                            [self getFullServiceString:serv],
                            EmployeeNumParam,Empno,MW_GeneralDel,
                            YearParam,Year,MW_GeneralDel,
                            MonthParam,month];
    urlString=[RequestManager addLanguageURL:urlString];
    urlString=[self stringParam:urlString value:MW_GeneralDel];
    urlString=[RequestManager addSecretKeyURL:urlString];
    
    NSLog(@"salary url=%@",urlString);
    
    NSURL *url =  [[NSURL alloc] initWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    DataTransfer *dataTransfer= [[DataTransfer alloc] init];
    dataTransfer.delegate = delegate;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    
    [manager GET:[url absoluteString]
      parameters:nil
         success:^(NSURLSessionDataTask *task, id responseObject) {
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
             
             NSLog(@"success: %@",responseObject);
             id result = [responseObject objectForKeyedSubscript:salaryResultListMW];
             id op_result= [result objectForKeyedSubscript:ObjResultMW];
             BOOL operationStatus=[[op_result objectForKeyedSubscript:operationStatusMW] boolValue];
             
             if (operationStatus) {
                 NSDictionary* objParent =(NSDictionary*) [result objectForKeyedSubscript:salaryParentObjMW]  ;
                 SalaryObj *obj=[[SalaryObj alloc] init];
                 
                 NSArray* objPay =(NSArray*) [result objectForKeyedSubscript:ObjPayMW];
                 obj.allowanceArr=[[NSMutableArray alloc] init];
                 obj.deductionArr=[[NSMutableArray alloc] init];
                 if(objPay && objPay!=(NSArray*)[NSNull null]
                    && objParent && objParent!=(NSDictionary*)[NSNull null]){
                     
                     obj.bankName=[objParent objectForKeyedSubscript:salaryBankNameMW];
                     obj.type=[objParent objectForKeyedSubscript:salaryPayIndicatorMW];
                     obj.totalDeserve=[objParent objectForKeyedSubscript:salaryTotalAllowanceMW];
                     obj.totalDiscount=[objParent objectForKeyedSubscript:salaryTotalDeductionMW];
                     obj.basicSalary=[objParent objectForKeyedSubscript:salaryBasicSalaryMW];
                     
                     float totalDeserve=0,totalDiscount=0;
                     for (int i=0; i<[objPay count]; i++) {
                         SalaryDetailsObj *det=[[SalaryDetailsObj alloc] init];
                         det.value=[[objPay objectAtIndex:i] objectForKeyedSubscript:salaryAllownanceAmountMW];
                         det.code=[[objPay objectAtIndex:i] objectForKeyedSubscript:salaryAllownanceCodeMW];
                         det.description=[[objPay objectAtIndex:i] objectForKeyedSubscript:salaryAllownanceMW];
                         det.isAllowance=[[[objPay objectAtIndex:i] objectForKeyedSubscript:salaryIsAllownanceMW] boolValue];
                         if(det.isAllowance){
                             [obj.allowanceArr addObject:det];
                             totalDeserve+=[det.value floatValue];
                         }else{
                             [obj.deductionArr addObject:det];
                             totalDiscount+=[det.value floatValue];
                         }
                     }
                     obj.totalDiscount=[NSString stringWithFormat:@"%f", totalDiscount];
                     obj.totalDeserve=[NSString stringWithFormat:@"%f",totalDeserve];
                 }
                 [dataTransfer dataLoaded:obj error:nil withService:serv];
             }else{
                 CustomError *customError = [CustomError initWithError:op_result];
                 [dataTransfer dataLoaded:nil error:customError withService:serv];
                 
             }
             
         }failure:^(NSURLSessionDataTask *task, NSError *error) {
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
             
             // Handle failure
             NSLog(@"failed: %@",error);
             CustomError * customError = [[CustomError alloc] init];
             customError.errorMessage=ServerErrorMsg;
             [dataTransfer dataLoaded:nil error:customError withService:serv];
         }];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];

}

-(void)getPaymentData:(id)delegate forEmpNo:(NSString*)Empno withYear:(NSString*)Year{
    Service serv= EmployeePaymentList_WS;
    //Empno=@"14796";
    NSString * urlString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                            [self getFullServiceString:serv],
                            EmployeeNumParam,Empno,MW_GeneralDel,
                            YearParam,Year];
    
    urlString=[RequestManager addLanguageURL:urlString];
    urlString=[RequestManager addSecretKeyURL:urlString];
    
    NSLog(@"payment url=%@",urlString);
    
    NSURL *url =  [[NSURL alloc] initWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    DataTransfer *dataTransfer= [[DataTransfer alloc] init];
    dataTransfer.delegate = delegate;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    
    [manager GET:[url absoluteString]
      parameters:nil
         success:^(NSURLSessionDataTask *task, id responseObject) {
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

             NSLog(@"success: %@",responseObject);
             id result = [responseObject objectForKeyedSubscript:paymentResultListMW];
             id op_result= [result objectForKeyedSubscript:ObjResultMW];
             BOOL operationStatus=[[op_result objectForKeyedSubscript:operationStatusMW] boolValue];
        
             if (operationStatus) {
                 NSArray* objPay =(NSArray*) [result objectForKeyedSubscript:ObjPayMW]  ;
            
                 NSMutableArray *requests= [[NSMutableArray alloc] init];
                 if(objPay && objPay!=(NSArray*)[NSNull null]){
                     for(int i=0; i<[objPay count];i++){
                         PaymentDetailsObj *obj=[[PaymentDetailsObj alloc] init];
                         if([[objPay objectAtIndex:i] objectForKeyedSubscript:paymentPayrollNumberMW] && [[objPay objectAtIndex:i] objectForKeyedSubscript:paymentPayrollNumberMW]!=(NSString*)[NSNull null])
                             obj.number=[[objPay objectAtIndex:i] objectForKeyedSubscript:paymentPayrollNumberMW];
                    
                         if([[objPay objectAtIndex:i] objectForKeyedSubscript:paymentDetailsMW] && [[objPay objectAtIndex:i] objectForKeyedSubscript:paymentDetailsMW]!=(NSString*)[NSNull null])
                             obj.description=[[objPay objectAtIndex:i] objectForKeyedSubscript:paymentDetailsMW];
                    
                         if([[objPay objectAtIndex:i] objectForKeyedSubscript:paymentPayrollDateMW] && [[objPay objectAtIndex:i] objectForKeyedSubscript:paymentPayrollDateMW]!=(NSString*)[NSNull null])
                             obj.date=[[objPay objectAtIndex:i] objectForKeyedSubscript:paymentPayrollDateMW];
                    
                         if([[objPay objectAtIndex:i] objectForKeyedSubscript:paymentExpenseAmountMW] && [[objPay objectAtIndex:i] objectForKeyedSubscript:paymentExpenseAmountMW]!=(NSString*)[NSNull null])
                             obj.amount=[[objPay objectAtIndex:i] objectForKeyedSubscript:paymentExpenseAmountMW];
                    
                         if([[objPay objectAtIndex:i] objectForKeyedSubscript:paymentNotesMW] && [[objPay objectAtIndex:i] objectForKeyedSubscript:paymentNotesMW]!=(NSString*)[NSNull null])
                             obj.idicator=[[objPay objectAtIndex:i] objectForKeyedSubscript:paymentNotesMW];
                    
                         if([[objPay objectAtIndex:i] objectForKeyedSubscript:paymentExpenseNameMW] && [[objPay objectAtIndex:i] objectForKeyedSubscript:paymentExpenseNameMW]!=(NSString*)[NSNull null])
                             obj.mainName=[[objPay objectAtIndex:i] objectForKeyedSubscript:paymentExpenseNameMW];
                    
                         obj.isPaid=[[[objPay objectAtIndex:i] objectForKeyedSubscript:paymentIsPaidMW] boolValue];
                         [requests addObject:obj];
                     }
                 }
                 [dataTransfer dataLoaded:requests error:nil withService:serv];
             }else{
                 CustomError *customError = [CustomError initWithError:op_result];
                 [dataTransfer dataLoaded:nil error:customError withService:serv];
            
             }
        
         } failure:^(NSURLSessionDataTask *task, NSError *error) {
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
             
             // Handle failure
             NSLog(@"failed: %@",error);
             CustomError * customError = [[CustomError alloc] init];
             customError.errorMessage=ServerErrorMsg;
             [dataTransfer dataLoaded:nil error:customError withService:serv];
         }];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
}

-(void)changePassword:(id)delegate forEmpNo:(NSString*)Empno withOldPassword:(NSString*)oldPW withNewPassword:(NSString*)newPW{
    Service serv= ChangePassword_WS;
    NSString *urlString=[self getFullServiceString:serv];
    
    NSLog(@"change password url=%@",urlString);
    
    NSURL *url =  [[NSURL alloc] initWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    DataTransfer *dataTransfer= [[DataTransfer alloc] init];
    dataTransfer.delegate = delegate;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSDictionary *parameter = @{UserNameMW_paramPost:appDelegate.EmployeeObj.userName,
                                changePWOldParam:oldPW,
                                changePWNewParam:newPW,
                                MW_LanguageParamPost:[NSNumber numberWithInt:(int)appDelegate.currentLang],
                                MW_ScreatKeyPostParam:MW_ScreatKeyPostParamValue};
    
    [manager POST:[url absoluteString]
       parameters:parameter
          success:^(NSURLSessionDataTask *task, id responseObject) {
              [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
              NSLog(@"success: %@",responseObject);
              id result = [responseObject objectForKeyedSubscript:changePWResultMW];
              // id op_result= [result valueForKeyPath:ObjResultMW];
              BOOL operationStatus=[[result objectForKeyedSubscript:operationStatusMW] boolValue];
        
              if (operationStatus) {
                  NSString *msg=[result objectForKeyedSubscript:MWErrorMessage];
                  [dataTransfer dataLoaded:msg error:nil withService:serv];
              }else{
                  CustomError *customError = [CustomError initWithError:result];
                  [dataTransfer dataLoaded:nil error:customError withService:serv];
                  
              }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        // Handle failure
        NSLog(@"failed: %@",error);
        CustomError * customError = [[CustomError alloc] init];
        customError.errorMessage=ServerErrorMsg;
        [dataTransfer dataLoaded:nil error:customError withService:serv];
    }];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    

}
-(void)getSchedule:(id)delegate forEmpNo:(NSString*)Empno
{
    Service serv= GetSchdule_WS;
    //NSString * urlString = [NSString stringWithFormat:@"%@%@%@",[self getFullServiceString:serv],EmployeeNumParam,Empno];
    
    NSString * urlString = [NSString stringWithFormat:@"%@%@%@",[self getFullServiceString:serv],EmployeeNumParam,Empno];
    
    urlString=[RequestManager addLanguageURL:urlString];
    urlString=[RequestManager addSecretKeyURL:urlString];
    
    NSLog(@"Student schedule url=%@",urlString);
    
    NSURL *url =  [[NSURL alloc] initWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    DataTransfer *dataTransfer= [[DataTransfer alloc] init];
    dataTransfer.delegate = delegate;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    
    [manager GET:[url absoluteString]
      parameters:nil
         success:^(NSURLSessionDataTask *task, id responseObject) {
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
             NSLog(@"JSON: %@", responseObject);
             
             id result = [responseObject objectForKeyedSubscript:scheduleResultMW];
             id op_result= [result objectForKeyedSubscript:ObjResultMW];
             BOOL operationStatus=[[op_result objectForKeyedSubscript:operationStatusMW] boolValue];
             
             if (operationStatus) {
                 NSMutableArray *lst=[[NSMutableArray alloc] init];
                 NSArray* objPay =(NSArray*) [result objectForKeyedSubscript:ObjPayMW]  ;
                 for(int i=0;i<[objPay count];i++){
                     ScheduleObj *obj=[[ScheduleObj alloc] init];
                     obj.classRoomId=[[objPay objectAtIndex:i]  objectForKeyedSubscript:scheduleClassroomIdMW];
                     obj.day=(ScheduleDays)[[[objPay objectAtIndex:i]  objectForKeyedSubscript:scheduleDayMW] intValue];
                     obj.courseNo=[[objPay objectAtIndex:i]  objectForKeyedSubscript:scheduleCourseCodeMW];
                     obj.startTime=[[objPay objectAtIndex:i]  objectForKeyedSubscript:scheduleFromTimeMW];
                     obj.endTime=[[objPay objectAtIndex:i]  objectForKeyedSubscript:scheduleEndTimeMW];
                     obj.SectionNo=[[objPay objectAtIndex:i] objectForKeyedSubscript:scheduleSectionIDMW];
                     obj.classBuildingId= [[objPay objectAtIndex:i]  objectForKeyedSubscript:scheduleClassbuildingIdMW];
                     obj.classpartitionId= [[objPay objectAtIndex:i]  objectForKeyedSubscript:scheduleClassPartitionIdMW];
                     obj.classFloorId= [[objPay objectAtIndex:i]  objectForKeyedSubscript:scheduleClassfloorIdMW];
                     obj.classRoomId=[[objPay objectAtIndex:i]  objectForKeyedSubscript:scheduleClassroomIdMW];
                     
                     [lst addObject:obj];
                     
                     
                 }
                 [dataTransfer dataLoaded:lst error:nil withService:serv];
             }else{
                 CustomError *customError = [CustomError initWithError:op_result];
                 [dataTransfer dataLoaded:nil error:customError withService:serv];
                 
             }
         }
         failure:^(NSURLSessionDataTask *task, NSError *error) {
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
             
             // Handle failure
             NSLog(@"failed: %@",error);
             CustomError * customError = [[CustomError alloc] init];
             customError.errorMessage=ServerErrorMsg;
             [dataTransfer dataLoaded:nil error:customError withService:serv];
         }];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    
    
}
-(void)getVacations:(id)delegate forEmpNo:(NSString*)Empno{
    Service serv= GetVacationBalance_WS;
    NSString * urlString = [NSString stringWithFormat:@"%@%@%@",
                            [self getFullServiceString:serv],
                            EmployeeNumParam,Empno];
    
    urlString=[RequestManager addLanguageURL:urlString];
    urlString=[RequestManager addSecretKeyURL:urlString];
    
    NSLog(@"vacation url=%@",urlString);
    
    NSURL *url =  [[NSURL alloc] initWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    DataTransfer *dataTransfer= [[DataTransfer alloc] init];
    dataTransfer.delegate = delegate;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    
    [manager GET:[url absoluteString]
      parameters:nil
         success:^(NSURLSessionDataTask *task, id responseObject) {
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
             
        
             NSLog(@"success: %@",responseObject);
             id result = [responseObject objectForKeyedSubscript:vacationResultMW];
             id op_result= [result objectForKeyedSubscript:ObjResultMW];
             BOOL operationStatus=[[op_result objectForKeyedSubscript:operationStatusMW] boolValue];
        
             if (operationStatus) {
                 NSArray* objPay =(NSArray*) [result objectForKeyedSubscript:ObjPayMW]  ;
            
                 NSString* emergen=[[objPay objectAtIndex:0] objectForKeyedSubscript:vacationEmergencybalanceMW];
                 NSString *normal=[[objPay objectAtIndex:0] objectForKeyedSubscript:vacationNormalBalanceMW];

                 [dataTransfer dataLoaded:[[NSMutableArray alloc] initWithObjects:emergen,normal, nil] error:nil withService:serv];
             }else{
                 CustomError *customError = [CustomError initWithError:op_result];
                 [dataTransfer dataLoaded:nil error:customError withService:serv];
            
             }
        
         }  failure:^(NSURLSessionDataTask *task, NSError *error) {
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
             
             // Handle failure
             NSLog(@"failed: %@",error);
             CustomError * customError = [[CustomError alloc] init];
             customError.errorMessage=ServerErrorMsg;
             [dataTransfer dataLoaded:nil error:customError withService:serv];
         }];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

-(void)sendClaim:(id)delegate forEmpNo:(NSString*)Empno withText:(NSString*)text{
    Service serv= SendClaim_WS;
    
    NSString * urlString = [NSString stringWithFormat:@"%@%@%@%@%@%@",[self getFullServiceString:serv],sendClaimDescParam,text,MW_GeneralDel,EmployeeNumParam,Empno] ;
    urlString=[RequestManager addLanguageURL:urlString];
    urlString=[RequestManager addSecretKeyURL:urlString];
    
    NSLog(@"send claim url=%@",urlString);
    
    NSURL *url =  [[NSURL alloc] initWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    DataTransfer *dataTransfer= [[DataTransfer alloc] init];
    dataTransfer.delegate = delegate;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    
    [manager GET:[url absoluteString]
      parameters:nil
         success:^(NSURLSessionDataTask *task, id responseObject) {
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
             
             NSLog(@"success: %@",responseObject);
             id result = [responseObject objectForKeyedSubscript:sendClaimResultMW];
             // id op_result= [result valueForKeyPath:ObjResultMW];
             BOOL operationStatus=[[result objectForKeyedSubscript:operationStatusMW] boolValue];
        
             if (operationStatus) {
                 NSString *msg=[result objectForKeyedSubscript:MWErrorMessage];
                 [dataTransfer dataLoaded:msg error:nil withService:serv];
             }else{
                 CustomError *customError = [CustomError initWithError:result];
                 [dataTransfer dataLoaded:nil error:customError withService:serv];
            
             }
        
         } failure:^(NSURLSessionDataTask *task, NSError *error) {
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
             
             // Handle failure
             NSLog(@"failed: %@",error);
             CustomError * customError = [[CustomError alloc] init];
             customError.errorMessage=ServerErrorMsg;
             [dataTransfer dataLoaded:nil error:customError withService:serv];
         }];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];

}

-(void)getClaimLst:(id)delegate forEmpNo:(NSString*)Empno{
    Service serv= GetClaimsList_WS;
    NSString * urlString = [NSString stringWithFormat:@"%@%@%@",[self getFullServiceString:serv],EmployeeNumParam,Empno] ;
    urlString=[RequestManager addLanguageURL:urlString];
    urlString=[RequestManager addSecretKeyURL:urlString];
    
    NSLog(@"claim list url=%@",urlString);
    
    NSURL *url =  [[NSURL alloc] initWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    DataTransfer *dataTransfer= [[DataTransfer alloc] init];
    dataTransfer.delegate = delegate;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    
    [manager GET:[url absoluteString]
      parameters:nil
         success:^(NSURLSessionDataTask *task, id responseObject) {
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
             
             NSLog(@"success: %@",responseObject);
             id result = [responseObject objectForKeyedSubscript:claimLstResultMW];
             id op_result= [result objectForKeyedSubscript:ObjResultMW];
             BOOL operationStatus=[[op_result objectForKeyedSubscript:operationStatusMW] boolValue];
        
             if (operationStatus) {
                 NSArray* objPay =(NSArray*) [result objectForKeyedSubscript:ObjPayMW]  ;
            
                 NSMutableArray *claimLst= [[NSMutableArray alloc] init];
                if(objPay && objPay!=(NSArray*)[NSNull null]){
                    for(int i=0; i<[objPay count];i++){
                        ClaimObj *obj=[[ClaimObj alloc] init];
                        obj.claimDescp=[[objPay objectAtIndex:i] objectForKeyedSubscript:claimLstDescrpMW];
                        obj.ticketNo=[[objPay objectAtIndex:i] objectForKeyedSubscript:claimLstTicketNoMW];
                        obj.createDate=[[objPay objectAtIndex:i] objectForKeyedSubscript:claimLstDateMW];
                        [claimLst addObject:obj];
                    }
                }
                 [dataTransfer dataLoaded:claimLst error:nil withService:serv];
             }else{
                 CustomError *customError = [CustomError initWithError:op_result];
                 [dataTransfer dataLoaded:nil error:customError withService:serv];
            
             }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        // Handle failure
        NSLog(@"failed: %@",error);
        CustomError * customError = [[CustomError alloc] init];
        customError.errorMessage=ServerErrorMsg;
        [dataTransfer dataLoaded:nil error:customError withService:serv];
    }];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];

}


-(void)getCustodyInfo:(id)delegate forEmpNo:(NSString*)Empno{
    Service serv= GetCustodyList_WS;
    //Empno=@"14796";
    NSString * urlString = [NSString stringWithFormat:@"%@%@%@",[self getFullServiceString:serv],EmployeeNumParam,Empno] ;
    urlString=[RequestManager addLanguageURL:urlString];
    urlString=[RequestManager addSecretKeyURL:urlString];
    
    NSLog(@"custody list url=%@",urlString);

    NSURL *url =  [[NSURL alloc] initWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    DataTransfer *dataTransfer= [[DataTransfer alloc] init];
    dataTransfer.delegate = delegate;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    
    [manager GET:[url absoluteString]
      parameters:nil
         success:^(NSURLSessionDataTask *task, id responseObject) {
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
             
        
             NSLog(@"success: %@",responseObject);
             id result = [responseObject objectForKeyedSubscript:custodyLstResultMW];
             id op_result= [result objectForKeyedSubscript:ObjResultMW];
             BOOL operationStatus=[[op_result objectForKeyedSubscript:operationStatusMW] boolValue];
        
             if (operationStatus) {
                 NSArray* objPay =(NSArray*) [result objectForKeyedSubscript:ObjPayMW]  ;
                 
                 NSMutableArray *custodyLst= [[NSMutableArray alloc] init];
                 if(objPay && objPay!=(NSArray*)[NSNull null]){
                     for(int i=0; i<[objPay count];i++){
                         CustodyObj *obj=[[CustodyObj alloc] init];
                         obj.cust_quantity=[[objPay objectAtIndex:i] objectForKeyedSubscript:custodyQuantityMW];
                         obj.cust_desc=[[objPay objectAtIndex:i] objectForKeyedSubscript:custodyItemNameMW];
                         obj.cust_remarks=[[objPay objectAtIndex:i] objectForKeyedSubscript:custodyItemUnitNameMW];
                         [custodyLst addObject:obj];
                     }
                 }
                 [dataTransfer dataLoaded:custodyLst error:nil withService:serv];
             }else{
                 CustomError *customError = [CustomError initWithError:op_result];
                 [dataTransfer dataLoaded:nil error:customError withService:serv];
            
             }
        
         }failure:^(NSURLSessionDataTask *task, NSError *error) {
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
             
             // Handle failure
             NSLog(@"failed: %@",error);
             CustomError * customError = [[CustomError alloc] init];
             customError.errorMessage=ServerErrorMsg;
             [dataTransfer dataLoaded:nil error:customError withService:serv];
         }];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];


}


-(void)forgetPW:(id)delegate withUserName:(NSString*)username{
    Service serv= ForgetPassword_WS;
    NSString *urlString=[self getFullServiceString:serv];
    
    NSLog(@"forget password url=%@",urlString);
    
    NSURL *url =  [[NSURL alloc] initWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    DataTransfer *dataTransfer= [[DataTransfer alloc] init];
    dataTransfer.delegate = delegate;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSDictionary *parameter = @{UserNameMW_paramPost:username,
                                MW_LanguageParamPost:[NSNumber numberWithInt:(int)appDelegate.currentLang],
                                MW_ScreatKeyPostParam:MW_ScreatKeyPostParamValue};
    
    [manager POST:[url absoluteString]
       parameters:parameter
          success:^(NSURLSessionDataTask *task, id responseObject) {
              [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
              
              NSLog(@"success: %@",responseObject);
              id result = [responseObject objectForKeyedSubscript:forgetPWResultMW];
              id op_result= [result objectForKeyedSubscript:ObjResultMW];
              BOOL operationStatus=[[op_result objectForKeyedSubscript:operationStatusMW] boolValue];
        
              if (operationStatus) {
                  NSString *msg=[op_result objectForKeyedSubscript:MWErrorMessage];
                  [dataTransfer dataLoaded:msg error:nil withService:serv];
              }else{
                  CustomError *customError = [CustomError initWithError:op_result];
                  [dataTransfer dataLoaded:nil error:customError withService:serv];
            
              }
        
          }
          failure:^(NSURLSessionDataTask *task, NSError *error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        // Handle failure
        NSLog(@"failed: %@",error);
        CustomError * customError = [[CustomError alloc] init];
        customError.errorMessage=ServerErrorMsg;
        [dataTransfer dataLoaded:nil error:customError withService:serv];
    }];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];

}

-(void)GetExternalDocumentUnit:(id)delegate
{
    Service serv= GetExternalDocumentUnit_WS;
    
    NSString * urlString = [NSString stringWithFormat:@"%@",[self getFullServiceString:serv]] ;
    urlString=[RequestManager addLanguageURL:urlString];
    urlString=[RequestManager addSecretKeyURL:urlString];
    
    //urlString=[NSString stringWithFormat:@"%@&AttchFile=null",urlString];
    
    NSURL *url =  [[NSURL alloc] initWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    DataTransfer *dataTransfer= [[DataTransfer alloc] init];
    dataTransfer.delegate = delegate;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager GET:[url absoluteString]
      parameters:nil
         success:^(NSURLSessionDataTask *task, id responseObject) {
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
             
             
             NSLog(@"success: %@",responseObject);
             id result = [responseObject objectForKeyedSubscript:ExternalDocumentUnitResult_MW];
             id op_result= [result objectForKeyedSubscript:ObjResultMW];
             BOOL operationStatus=[[op_result objectForKeyedSubscript:operationStatusMW] boolValue];
             
             if (operationStatus) {
                 
                 NSArray* objData =(NSArray*) [result objectForKeyedSubscript:ExternalDocumentUnitObjData_MW]  ;
                 
                 NSMutableArray *DocumentExternalUnit= [[NSMutableArray alloc] init];
                 if(objData && objData!=(NSArray*)[NSNull null]){
                     
                     for(int i=0; i<[objData count];i++){
                         ExternalDocumentUnitObj *obj=[[ExternalDocumentUnitObj alloc] init];
                         
                         obj.ExternalUnitCode=[[objData objectAtIndex:i] objectForKeyedSubscript:ExternalUnitCodeMW];
                         obj.ExternalUnitID=[[objData objectAtIndex:i] objectForKeyedSubscript:ExternalUnitIDMW];
                         obj.ExternalUnitName=[[objData objectAtIndex:i] objectForKeyedSubscript:ExternalUnitNameMW];
                         [DocumentExternalUnit addObject:obj];
                     }
                 }
                 [dataTransfer dataLoaded:DocumentExternalUnit error:nil withService:serv];
             }else{
                 CustomError *customError = [CustomError initWithError:result];
                 [dataTransfer dataLoaded:nil error:customError withService:serv];
                 
             }
             
         }
         failure:^(NSURLSessionDataTask *task, NSError *error) {
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
             
             // Handle failure
             NSLog(@"failed: %@",error);
             CustomError * customError = [[CustomError alloc] init];
             customError.errorMessage=ServerErrorMsg;
             [dataTransfer dataLoaded:nil error:customError withService:serv];
         }];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}
-(void)docSelfInquiry:(id)delegate withDocNumber:(NSString*)withDocNumber withDocDate:(NSString*)withDocDate withDocCode:(NSString*)withDocCode{
    Service serv= GetDocSelfInquiryDate_WS;
    
    NSString * urlString = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@",[self getFullServiceString:serv]
                            ,DocNumberMW,withDocNumber,MW_GeneralDel,DocDateMW
                            ,withDocDate,MW_GeneralDel,DocCodeMW,withDocCode] ;
    urlString=[RequestManager addLanguageURL:urlString];
    urlString=[RequestManager addSecretKeyURL:urlString];
    
    //urlString=[NSString stringWithFormat:@"%@&AttchFile=null",urlString];
    
    NSURL *url =  [[NSURL alloc] initWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    DataTransfer *dataTransfer= [[DataTransfer alloc] init];
    dataTransfer.delegate = delegate;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager GET:[url absoluteString]
      parameters:nil
         success:^(NSURLSessionDataTask *task, id responseObject) {
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
             
             
             NSLog(@"success: %@",responseObject);
             id result = [responseObject objectForKeyedSubscript:DocEnquiryResposedate_MW];
             id op_result= [result objectForKeyedSubscript:ObjResultMW];
             BOOL operationStatus=[[op_result objectForKeyedSubscript:operationStatusMW] boolValue];
             
             if (operationStatus) {
                 
                 NSDictionary* objPay =(NSDictionary*) [result objectForKeyedSubscript:DocEnquiryParentObjMW]  ;
                 
                 NSMutableArray *DocumentStatus= [[NSMutableArray alloc] init];
                 if(objPay && objPay!=(NSDictionary*)[NSNull null]){
                         DocInfoObj *obj=[[DocInfoObj alloc] init];
                         obj.ActionDescription=[objPay objectForKeyedSubscript:@"ActionDescription"];
                         obj.DocTransactionNumber=[objPay objectForKeyedSubscript:DocTransactionNumberMW];
                         obj.DocumentDate=[objPay objectForKeyedSubscript:DocumentDateMW];
                         [DocumentStatus addObject:obj];
                 }
                 [dataTransfer dataLoaded:DocumentStatus error:nil withService:serv];
             }else{
                 CustomError *customError = [CustomError initWithError:result];
                 [dataTransfer dataLoaded:nil error:customError withService:serv];
                 
             }
             
         }
         failure:^(NSURLSessionDataTask *task, NSError *error) {
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
             
             // Handle failure
             NSLog(@"failed: %@",error);
             CustomError * customError = [[CustomError alloc] init];
             customError.errorMessage=ServerErrorMsg;
             [dataTransfer dataLoaded:nil error:customError withService:serv];
         }];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

//docSelfInquiry:self withbyLogBookNumber:docIDTxt.text withbyLogBookYear:@"1337" ]{}
-(void)docSelfInquiry:(id)delegate withLogBookNumber:(NSString*)withLogBookNumber withLogBookYear:(NSString*)withLogBookYear
{
    Service serv= GetDocSelfInquiry_WS;
    
    NSString * urlString = [NSString stringWithFormat:@"%@%@%@%@%@%@",[self getFullServiceString:serv]
                            ,DocNumberMW,withLogBookNumber,MW_GeneralDel,DocLogBookEntryYearMW
                            ,withLogBookYear] ;
    urlString=[RequestManager addLanguageURL:urlString];
    urlString=[RequestManager addSecretKeyURL:urlString];

    NSURL *url =  [[NSURL alloc] initWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    DataTransfer *dataTransfer= [[DataTransfer alloc] init];
    dataTransfer.delegate = delegate;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager GET:[url absoluteString]
      parameters:nil
         success:^(NSURLSessionDataTask *task, id responseObject) {
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
             
             
             NSLog(@"success: %@",responseObject);
             id result = [responseObject objectForKeyedSubscript:DocEnquiryRespose_MW];
             id op_result= [result objectForKeyedSubscript:ObjResultMW];
             BOOL operationStatus=[[op_result objectForKeyedSubscript:operationStatusMW] boolValue];
             
             if (operationStatus) {
                 NSDictionary* objPay =(NSDictionary*) [result objectForKeyedSubscript:DocEnquiryParentObjMW];
                 NSMutableArray *DocumentStatus= [[NSMutableArray alloc] init];
                 if(objPay && objPay!=(NSDictionary*)[NSNull null]){
                     DocInfoObj *obj=[[DocInfoObj alloc] init];
                     obj.ActionDescription=[objPay objectForKeyedSubscript:DocActionDescriptionMW];
                     obj.DocTransactionNumber=[objPay objectForKeyedSubscript:DocTransactionNumberMW];
                     obj.DocumentDate=[objPay objectForKeyedSubscript:DocumentDateMW];
                     [DocumentStatus addObject:obj];
                 }
                 [dataTransfer dataLoaded:DocumentStatus error:nil withService:serv];
             }else{
                 CustomError *customError = [CustomError initWithError:result];
                 [dataTransfer dataLoaded:nil error:customError withService:serv];
                 
             }
             
         }
         failure:^(NSURLSessionDataTask *task, NSError *error) {
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
             
             // Handle failure
             NSLog(@"failed: %@",error);
             CustomError * customError = [[CustomError alloc] init];
             customError.errorMessage=ServerErrorMsg;
             [dataTransfer dataLoaded:nil error:customError withService:serv];
         }];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}


-(void)itSupport:(id)delegate withSubject:(NSString*)sub withText:(NSString*)text withImage:(UIImage *)userImg{
   Service serv= ITSupport_WS;
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSString* requestID= appDelegate.EmployeeObj.userName;
    NSLog(@"it support requester =%@",requestID);
    
    NSString * urlString = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@%@%@%@",[self getFullServiceString:serv]
                            ,ITRequesterMWParam,requestID,MW_GeneralDel
                            ,ITSubjectMWParam,sub,MW_GeneralDel
                            ,ITDescriptionMWParam,text,MW_GeneralDel
                            ,ITPriorityMWParam,MW_GeneralDel
                            ,ITUrgencyMWParam,MW_GeneralDel] ;
    urlString=[RequestManager addLanguageURL:urlString];
    urlString=[RequestManager addSecretKeyURL:urlString];
    
    //urlString=[NSString stringWithFormat:@"%@&AttchFile=null",urlString];
  
    NSLog(@"IT support url=%@",urlString);
    
    
    NSData *imageData = UIImageJPEGRepresentation(userImg, 0.0001);
    const unsigned char *bytes = [imageData bytes];
    NSUInteger length = [imageData length];
    NSMutableArray *byteArray = [NSMutableArray array];
    for (NSUInteger i = 0; i < length; i++) {
        [byteArray addObject:[NSNumber numberWithUnsignedChar:bytes[i]]];
    }
   // if(imageData)
    //    [request setHTTPBodyStream:[NSInputStream inputStreamWithData:imageData]];
    
    NSURL *url =  [[NSURL alloc] initWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    DataTransfer *dataTransfer= [[DataTransfer alloc] init];
    dataTransfer.delegate = delegate;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager POST:[url absoluteString]
       parameters:nil
          success:^(NSURLSessionDataTask *task, id responseObject) {
              [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            
              NSLog(@"success: %@",responseObject);
              //id result = [JSON valueForKeyPath:ITAddITSupportRequestResultMW];
              // id op_result= [result valueForKeyPath:ObjResultMW];
              BOOL operationStatus=[[responseObject objectForKeyedSubscript:operationStatusMW] boolValue];
        
              if (operationStatus) {
                  NSString *msg=[responseObject objectForKeyedSubscript:MWErrorMessage];
                  [dataTransfer dataLoaded:msg error:nil withService:serv];
              }else{
                  CustomError *customError = [CustomError initWithError:responseObject];
                  [dataTransfer dataLoaded:nil error:customError withService:serv];
            
              }
        
          }
          failure:^(NSURLSessionDataTask *task, NSError *error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        // Handle failure
        NSLog(@"failed: %@",error);
        CustomError * customError = [[CustomError alloc] init];
        customError.errorMessage=ServerErrorMsg;
        [dataTransfer dataLoaded:nil error:customError withService:serv];
    }];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
}

-(void)getvehicles:(id)delegate forEmpNo:(NSString*)Empno{
    Service serv= Vehicles_WS;
   // Empno=@"14796";
    
    NSString * urlString = [NSString stringWithFormat:@"%@%@%@",[self getFullServiceString:serv],EmployeeNumParam,Empno] ;
    urlString=[RequestManager addLanguageURL:urlString];
    urlString=[RequestManager addSecretKeyURL:urlString];
    
    NSLog(@"Vehicles url=%@",urlString);
    
    NSURL *url =  [[NSURL alloc] initWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    DataTransfer *dataTransfer= [[DataTransfer alloc] init];
    dataTransfer.delegate = delegate;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    
    [manager GET:[url absoluteString]
      parameters:nil
         success:^(NSURLSessionDataTask *task, id responseObject) {
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
             
        
             NSLog(@"success: %@",responseObject);
             id result = [responseObject objectForKeyedSubscript:vehiclesRespose_MW];
             id op_result= [result objectForKeyedSubscript:ObjResultMW];
             BOOL operationStatus=[[op_result objectForKeyedSubscript:operationStatusMW] boolValue];
        
             if (operationStatus) {
                 NSArray* objPay =(NSArray*) [result objectForKeyedSubscript:ObjPayMW]  ;
            
                 NSMutableArray *vehicles= [[NSMutableArray alloc] init];
                 if(objPay && objPay!=(NSArray*)[NSNull null]){
                     for(int i=0; i<[objPay count];i++){
                         VehicleObj *obj=[[VehicleObj alloc] init];
                         
                         NSTimeInterval time =[[[objPay objectAtIndex:i] objectForKeyedSubscript:vehiclesAssignDateTime_MW] doubleValue];
                         obj.assignDate=[obj getDate:time];
                    
                         obj.vehicleNo=[[objPay objectAtIndex:i] objectForKeyedSubscript:vehiclesArabicBoard_MW];
                         obj.vehicleType=[[objPay objectAtIndex:i] objectForKeyedSubscript:vehiclesModelType_MW];
                         NSTimeInterval timeD =[[[objPay objectAtIndex:i] objectForKeyedSubscript:vehiclesDeliveryDateTime_MW] doubleValue];
                         obj.deliverDate=[obj getDate:timeD];

                         [vehicles addObject:obj];
                     }
                 }
                 [dataTransfer dataLoaded:vehicles error:nil withService:serv];
             }else{
                 CustomError *customError = [CustomError initWithError:result];
                 [dataTransfer dataLoaded:nil error:customError withService:serv];
            
             }
        
         }
            failure:^(NSURLSessionDataTask *task, NSError *error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        // Handle failure
        NSLog(@"failed: %@",error);
        CustomError * customError = [[CustomError alloc] init];
        customError.errorMessage=ServerErrorMsg;
        [dataTransfer dataLoaded:nil error:customError withService:serv];
    }];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

-(void)forgetPWVerify:(id)delegate withUserName:(NSString*)username withVerificationCode:(NSString*)code{
    Service serv= VerifyForgetPW_WS;
    NSString *urlString=[self getFullServiceString:serv];
    
    NSLog(@"verify forget password url=%@",urlString);
    
    
    NSURL *url =  [[NSURL alloc] initWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    DataTransfer *dataTransfer= [[DataTransfer alloc] init];
    dataTransfer.delegate = delegate;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSDictionary *parameter = @{UserNameMW_paramPost:username,
                                FWVerificationMW:code,
                                MW_LanguageParamPost:[NSNumber numberWithInt:(int)appDelegate.currentLang],
                                MW_ScreatKeyPostParam:MW_ScreatKeyPostParamValue};
    
    [manager POST:[url absoluteString]
       parameters:parameter
          success:^(NSURLSessionDataTask *task, id responseObject) {
              [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
              
              NSLog(@"success: %@",responseObject);
              id result = [responseObject objectForKeyedSubscript:FWVerifyResultMW];
              id op_result= [result objectForKeyedSubscript:ObjResultMW];
              BOOL operationStatus=[[op_result objectForKeyedSubscript:operationStatusMW] boolValue];
        
              if (operationStatus) {
                  NSString *msg=[op_result objectForKeyedSubscript:MWErrorMessage];
                  [dataTransfer dataLoaded:msg error:nil withService:serv];
              }else{
                  CustomError *customError = [CustomError initWithError:op_result];
                  [dataTransfer dataLoaded:nil error:customError withService:serv];
            
              }
        
          }
          failure:^(NSURLSessionDataTask *task, NSError *error) {
              [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
              
              // Handle failure
              NSLog(@"failed: %@",error);
              CustomError * customError = [[CustomError alloc] init];
              customError.errorMessage=ServerErrorMsg;
              [dataTransfer dataLoaded:nil error:customError withService:serv];
          }];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

-(void)getBookBorrowed:(id)delegate forEmpNo:(NSString*)Empno{
    Service serv= BookBorrowed_WS;
     //Empno=@"18782";//@"426108654";//
    
    NSString * urlString = [NSString stringWithFormat:@"%@%@%@",[self getFullServiceString:serv],bookBorrowedStudentParam,Empno] ;
    urlString=[RequestManager addLanguageURL:urlString];
    urlString=[RequestManager addSecretKeyURL:urlString];
    
    
    NSLog(@"book borrowed url=%@",urlString);
    
    NSURL *url =  [[NSURL alloc] initWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    DataTransfer *dataTransfer= [[DataTransfer alloc] init];
    dataTransfer.delegate = delegate;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    
    [manager GET:[url absoluteString]
      parameters:nil
         success:^(NSURLSessionDataTask *task, id responseObject) {
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
             
        
             NSLog(@"success: %@",responseObject);
             id result = [responseObject objectForKeyedSubscript:bookResposeResult_MW];
             id op_result= [result objectForKeyedSubscript:ObjResultMW];
             BOOL operationStatus=[[op_result objectForKeyedSubscript:operationStatusMW] boolValue];
        
             if (operationStatus) {
                 NSArray* objPay =(NSArray*) [result objectForKeyedSubscript:ObjPayMW]  ;
            
                 NSMutableArray *books= [[NSMutableArray alloc] init];
                 if(objPay && objPay!=(NSArray*)[NSNull null]){
                     for(int i=0; i<[objPay count];i++){
                         BookObj *obj=[[BookObj alloc] init];
                    
                         obj.bookName=[[objPay objectAtIndex:i] objectForKeyedSubscript:bookNameTag_MW];
                         obj.bookName= [obj.bookName stringByReplacingOccurrencesOfString:@"|c" withString:@"\n\r"];
                         obj.bookName= [obj.bookName stringByReplacingOccurrencesOfString:@"/" withString:@" "];
                         obj.bookName= [obj.bookName stringByReplacingOccurrencesOfString:@"|b" withString:@"\n\r"];
                         obj.bookName= [obj.bookName stringByReplacingOccurrencesOfString:@"=" withString:@" "];
                         [books addObject:obj];
                     }
                 }
                 [dataTransfer dataLoaded:books error:nil withService:serv];
             }else{
                 CustomError *customError = [CustomError initWithError:op_result];
                 [dataTransfer dataLoaded:nil error:customError withService:serv];
            
             }
        
         }
         failure:^(NSURLSessionDataTask *task, NSError *error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        // Handle failure
        NSLog(@"failed: %@",error);
        CustomError * customError = [[CustomError alloc] init];
        customError.errorMessage=ServerErrorMsg;
        [dataTransfer dataLoaded:nil error:customError withService:serv];
    }];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

-(void)updateDeviceToken:(NSString *)deviceToken :(id)delegate{
    Service serv= UpdateDeviceToken_WS;

    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(!appDelegate.EmployeeObj.showNotifications)
        deviceToken=@"";

    appDelegate.isSendingDeviceToken=YES;
    NSString * urlString = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",[self getFullServiceString:serv],EmployeeNumParam,appDelegate.EmployeeObj.empNo,MW_GeneralDel,deviceTokenMWParam,deviceToken,MW_GeneralDel,deviceTypeMW_param] ;
    urlString=[RequestManager addLanguageURL:urlString];
    urlString=[RequestManager addSecretKeyURL:urlString];
    
    NSLog(@"update device token > %@",urlString);
    
    NSURL *url =  [[NSURL alloc] initWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    DataTransfer *dataTransfer= [[DataTransfer alloc] init];
    dataTransfer.delegate = delegate;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    
    [manager GET:[url absoluteString]
      parameters:nil
         success:^(NSURLSessionDataTask *task, id responseObject) {
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
             
        
             NSLog(@"success: %@",responseObject);
             id result ;
             if([responseObject objectForKeyedSubscript:deviceTokenResult_MW] != nil){
            
              result = [responseObject objectForKeyedSubscript:deviceTokenResult_MW];
             }
             // id op_result= [result valueForKeyPath:ObjResultMW];
             BOOL operationStatus=[[result objectForKeyedSubscript:operationStatusMW] boolValue];
        
             if (operationStatus) {
                 NSString *msg=[result objectForKeyedSubscript:MWErrorMessage];
                [dataTransfer dataLoaded:msg error:nil withService:serv];
             }else{
                 CustomError *customError = [CustomError initWithError:result];
                 [dataTransfer dataLoaded:nil error:customError withService:serv];
            
             }
        
         }
         failure:^(NSURLSessionDataTask *task, NSError *error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        // Handle failure
        NSLog(@"failed: %@",error);
        CustomError * customError = [[CustomError alloc] init];
        customError.errorMessage=ServerErrorMsg;
        [dataTransfer dataLoaded:nil error:customError withService:serv];
    }];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

-(void)getNotifications:(id)delegate forEmpNo:(NSString*)Empno{
   Service serv= GetNotifications_WS;
    
    NSString * urlString = [NSString stringWithFormat:@"%@%@%@%@%@",[self getFullServiceString:serv],EmployeeNumParam,Empno,MW_GeneralDel,deviceTypeMW_param] ;
    urlString=[RequestManager addSecretKeyURL:urlString];
    
    
    NSLog(@"get notification url=%@",urlString);
    
    NSURL *url =  [[NSURL alloc] initWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    DataTransfer *dataTransfer= [[DataTransfer alloc] init];
    dataTransfer.delegate = delegate;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    
    [manager GET:[url absoluteString]
      parameters:nil
         success:^(NSURLSessionDataTask *task, id responseObject) {
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
             
             NSLog(@"success: %@",responseObject);
             id result = [responseObject objectForKeyedSubscript:getPushNotifyResult_MW];
             id op_result= [result objectForKeyedSubscript:ObjResultMW];
             BOOL operationStatus=[[op_result objectForKeyedSubscript:operationStatusMW] boolValue];
        
             if (operationStatus) {
                 AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                 NSArray* objPay =(NSArray*) [result objectForKeyedSubscript:ObjPayMW]  ;
            
                 NSMutableArray *notifyLst= [[NSMutableArray alloc] init];
                 if(objPay && objPay!=(NSArray*)[NSNull null]){
                     for(int i=0; i<[objPay count];i++){
                         NotifyObj *obj=[[NotifyObj alloc] init];
                    
                         NSString * dateStr= [[objPay objectAtIndex:i] objectForKeyedSubscript:getPushNotifyMessageDate_MW];
                         NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                         [formatter setDateFormat:@"MM/dd/yyyy hh:mm:ss a"];//7\/1\/2015 11:09:57 AM
                         [formatter setLocale:[NSLocale currentLocale]];
                         NSDate *gameDateTime = [formatter dateFromString:dateStr];
                    
                         if(appDelegate.currentLang==Arabic)
                             [ formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ar"]];
                         [formatter setDateFormat:@"dd/MM/yyyy EEEE"];
                         obj.date = [formatter stringFromDate:gameDateTime];
                         BOOL found=NO;
                         for(int j=0 ;j<[notifyLst count];j++){
                             if([((NotifyObj*)[notifyLst objectAtIndex:j]).date isEqualToString:obj.date]){
                                 found=YES;
                                 obj=[notifyLst objectAtIndex:j];
                                    break;
                             }
                         }
                    
                         NotifyDetailsObj* detObj=[[NotifyDetailsObj alloc] init];
                         [formatter setDateFormat:@"hh:mm"];
                         detObj.time = [formatter stringFromDate:gameDateTime];
                         NSString *notifyText=[[objPay objectAtIndex:i] objectForKeyedSubscript:getPushNotifyMessageText_MW];

                        
                     //
                         /*
                          
                          *ntf*{notificationStr:"Outsourcing : Outsourcing Request \n Request has been approved by Committee Member \n Request Code : 3721166034"
                          ,RequestCode:"3721166034",
                          ,Date:\"03/31/16 10:48:05 AM"
                          }
                          
*ntf*{notificationStr:”نظام الإستعانة : طلبات الإستعانة \n تم إعتماد الطلب من عضو لجنة الإستعانة \n رقم الطلب : 3721166034”,RequestCode:"3721166034",,Date:”03/31/16 10:48:05 AM”}
                          
                          *del*{"id":34,"msg":"لقد تم تفويضك من وطبان عبد الرحمن صالح وطبان"}
                          
                          *del*{"id":34,"msg":"You have been delegated from وطبان عبد الرحمن صالح وطبان"}
                          
                          */
                         
                         
                         if ([notifyText rangeOfString:@"*ntf*"].location != NSNotFound) {
                             NSArray *arr = [notifyText componentsSeparatedByString:@"*ntf*{notificationStr:\""];
                             notifyText = [arr objectAtIndex:1];
                             arr = [notifyText componentsSeparatedByString:@"\" ,RequestCode:"];
                             notifyText = [arr objectAtIndex:0];
                             notifyText = [notifyText stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
                         }
                         else if ([notifyText rangeOfString:@"*del*"].location != NSNotFound) {
                             NSArray *arr = [notifyText componentsSeparatedByString:@"msg\":\""];
                             notifyText = [arr objectAtIndex:1];
                             arr = [notifyText componentsSeparatedByString:@"\""];
                             notifyText = [arr objectAtIndex:0];
                         }
                         
                         notifyText = [notifyText stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
                         
                         detObj.notifyText=notifyText;

                         if(!obj.notifyArr)
                             obj.notifyArr=[[NSMutableArray alloc] init];
                         
                         //if ([notifyText rangeOfString:@"*del"].location == NSNotFound) {
                             [obj.notifyArr addObject:detObj];
                         //}
                         if(!found)
                         {
                             if ([obj.notifyArr count] > 0) {
                                 [notifyLst addObject:obj];
                             }
                         }
                     }
                 }
                 [dataTransfer dataLoaded:notifyLst error:nil withService:serv];
             }else{
                 CustomError *customError = [CustomError initWithError:op_result];
                 [dataTransfer dataLoaded:nil error:customError withService:serv];
            
             }
        
         }
         failure:^(NSURLSessionDataTask *task, NSError *error) {
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
             
             // Handle failure
             NSLog(@"failed: %@",error);
             CustomError * customError = [[CustomError alloc] init];
             customError.errorMessage=ServerErrorMsg;
             [dataTransfer dataLoaded:nil error:customError withService:serv];
         }];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}



-(void)deleteNotifications:(id)delegate forEmpNo:(NSString*)Empno{
    Service serv= DeleteNotifications_WS;
    
    NSString * urlString = [NSString stringWithFormat:@"%@%@%@",[self getFullServiceString:serv],EmployeeNumParam,Empno] ;
    urlString=[RequestManager addSecretKeyURL:urlString];
    
    NSURL *url =  [[NSURL alloc] initWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    DataTransfer *dataTransfer= [[DataTransfer alloc] init];
    dataTransfer.delegate = delegate;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager GET:[url absoluteString]
      parameters:nil
         success:^(NSURLSessionDataTask *task, id responseObject) {
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
             
             NSLog(@"success: %@",responseObject);
             id op_result= [responseObject objectForKeyedSubscript:deletePushNotifyResult_MW];
             BOOL operationStatus=[[op_result objectForKeyedSubscript:operationStatusMW] boolValue];
             
             if (operationStatus) {
                 [dataTransfer dataLoaded:@"Delete all data" error:nil withService:serv];
             }else{
                 CustomError *customError = [CustomError initWithError:op_result];
                 [dataTransfer dataLoaded:nil error:customError withService:serv];
                 
             }   
         }
         failure:^(NSURLSessionDataTask *task, NSError *error) {
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
             
             // Handle failure
             NSLog(@"failed: %@",error);
             CustomError * customError = [[CustomError alloc] init];
             customError.errorMessage=ServerErrorMsg;
             [dataTransfer dataLoaded:nil error:customError withService:serv];
         }];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

-(void)deleteDeviceToken:(NSString *)deviceToken :(id)delegate{
    Service serv= DeleteDeviceToken_WS;
    if([deviceToken isEqualToString:@""]) return;
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSString * urlString = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",[self getFullServiceString:serv],EmployeeNumParam,appDelegate.EmployeeObj.empNo,MW_GeneralDel,deviceTokenMWParam,deviceToken,MW_GeneralDel,deviceTypeMW_param] ;
    urlString=[RequestManager addLanguageURL:urlString];
    urlString=[RequestManager addSecretKeyURL:urlString];
    
    NSLog(@"delete device token > %@",urlString);
    
    NSURL *url =  [[NSURL alloc] initWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    DataTransfer *dataTransfer= [[DataTransfer alloc] init];
    dataTransfer.delegate = delegate;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    
    [manager GET:[url absoluteString]
      parameters:nil
         success:^(NSURLSessionDataTask *task, id responseObject) {
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
             NSLog(@"success: %@",responseObject);
             id result = [responseObject objectForKeyedSubscript:DeleteDeviceResult_MW];
             // id op_result= [result valueForKeyPath:ObjResultMW];
             BOOL operationStatus=[[result objectForKeyedSubscript:operationStatusMW] boolValue];
        
             if (operationStatus) {
                 NSString *msg=[result objectForKeyedSubscript:MWErrorMessage];
                 [dataTransfer dataLoaded:msg error:nil withService:serv];
             }else{
                 CustomError *customError = [CustomError initWithError:result];
                 [dataTransfer dataLoaded:nil error:customError withService:serv];
            
             }
        
         }
         failure:^(NSURLSessionDataTask *task, NSError *error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        // Handle failure
        NSLog(@"failed: %@",error);
        CustomError * customError = [[CustomError alloc] init];
        customError.errorMessage=ServerErrorMsg;
        [dataTransfer dataLoaded:nil error:customError withService:serv];
    }];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
}

-(void)getServicesList:(id)delegate withUsername:(NSString*)user withForceGet:(BOOL)withForceGet
{
    Service serv= GetServicesList_WS;
    
    NSString *urlString=[self getFullServiceString:serv];
    
    NSLog(@"services url=%@",urlString);
    
    NSURL *url =  [[NSURL alloc] initWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    DataTransfer *dataTransfer= [[DataTransfer alloc] init];
    dataTransfer.delegate = delegate;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    
    NSDictionary *inputDic = @{userNameMW_paramPost:user,
                               forceGetMW_paramPost:[NSNumber numberWithBool:withForceGet]};
    
    NSDictionary *parameter = @{@"input":inputDic};
    
    [manager POST:[url absoluteString]
       parameters:parameter
          success:^(NSURLSessionDataTask *task, id responseObject) {
              [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
              
              
              id result = [responseObject objectForKeyedSubscript:getServiceListResults_MW];
              
              id op_status= [result objectForKeyedSubscript:status_MW];
              BOOL operationStatus=[[op_status objectForKeyedSubscript:successStatusMW] boolValue];
              
              if (operationStatus) {
              
                  id objResponse= [result objectForKeyedSubscript:response_MW];
                  BOOL cashed = [[objResponse objectForKeyedSubscript:servicesCashedMW] boolValue];
                  
                  //read list from response
                  if (!cashed) {
                      NSMutableArray *lst=[[NSMutableArray alloc] init];
                      NSArray* objPay =(NSArray*) [objResponse objectForKeyedSubscript:listMW];
                      
                      for(int i=0;i<[objPay count];i++){
                          ServicesObj *obj=[[ServicesObj alloc] init];
                          obj.serviceNameAr = [[objPay objectAtIndex:i]  objectForKeyedSubscript:serviceNameMW];
                          obj.serviceNameEn = [[objPay objectAtIndex:i]  objectForKeyedSubscript:serviceNameEnMW];
                          obj.serviceCode = [[objPay objectAtIndex:i]  objectForKeyedSubscript:serviceCodeMW];
  
                          [lst addObject:obj];
                      }
                      [dataTransfer dataLoaded:lst error:nil withService:serv];
                  }
                  //read cashed data
                  else
                  {
                      NSMutableArray *lst=[[NSMutableArray alloc] init];
                      [dataTransfer dataLoaded:lst error:nil withService:serv];
                  }
              }else{
                  CustomError * customError = [[CustomError alloc] init];
                  customError.errorMessage=ServerErrorMsg;
                  [dataTransfer dataLoaded:nil error:customError withService:serv];
              }
              
          }
          failure:^(NSURLSessionDataTask *task, NSError *error) {
              [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
              CustomError * customError = [[CustomError alloc] init];
              customError.errorMessage=ServerErrorMsg;
              [dataTransfer dataLoaded:nil error:customError withService:serv];
          }];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];

}

-(void)getDelegationsList:(id)delegate withUsername:(NSString*)user withDelegationID:(NSInteger)withDelegationID withDirection:(NSString *)withDirection
{
    Service serv= GetDelegationsList_WS;
    
    NSString *urlString=[self getFullServiceString:serv];
    
    NSLog(@"Delegations url=%@",urlString);
    
    NSURL *url =  [[NSURL alloc] initWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    DataTransfer *dataTransfer= [[DataTransfer alloc] init];
    dataTransfer.delegate = delegate;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSString * language = @"";
    if(appDelegate.currentLang == Arabic){
        language=@"ar";
    }else{
        language=@"en";
    }
    
    NSDictionary *inputDic = @{userNameMW_paramPost:user,
                               delegationIDMW_paramPost:[NSString stringWithFormat:@"%li",(long)withDelegationID],
                               MW_languageParamPost:language,
                               directionMW_paramPost:withDirection};
    
    NSDictionary *parameter = @{@"input":inputDic};
    
    [manager POST:[url absoluteString]
       parameters:parameter
          success:^(NSURLSessionDataTask *task, id responseObject) {
              [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

              id result = [responseObject objectForKeyedSubscript:getDelegationListIMadeResults_MW];
              
              id op_status= [result objectForKeyedSubscript:status_MW];
              BOOL operationStatus=[[op_status objectForKeyedSubscript:successStatusMW] boolValue];
              NSMutableDictionary *output = [[NSMutableDictionary alloc] init];
              if (operationStatus) {
                  
                  id objResponse= [result objectForKeyedSubscript:response_MW];
                  NSMutableArray *lst=[[NSMutableArray alloc] init];
                  NSArray* objPay =(NSArray*) [objResponse objectForKeyedSubscript:listOfDelegationsMW];
                  
                  for(int i=0;i<[objPay count];i++){
                      /*
                       #define delegationsCountMW                         @"delegationsCount"
                       */
                      DelegationObj *obj=[[DelegationObj alloc] init];
                      obj.delegationID = [[[objPay objectAtIndex:i]  objectForKeyedSubscript:delegationIdMW] integerValue];
                      obj.requestNo = [[objPay objectAtIndex:i]  objectForKeyedSubscript:requestCodeMW];
                      obj.serviceCode = [[objPay objectAtIndex:i]  objectForKeyedSubscript:serviceCodeMW];
                      obj.startTime = [[objPay objectAtIndex:i]  objectForKeyedSubscript:startDateMW];
                      obj.startTimeNo = [[objPay objectAtIndex:i]  objectForKeyedSubscript:startDateNoMW];
                      obj.endTime = [[objPay objectAtIndex:i]  objectForKeyedSubscript:endDateMW];
                      obj.endTimeNo = [[objPay objectAtIndex:i]  objectForKeyedSubscript:endDateNoMW];
                      obj.status = [[[objPay objectAtIndex:i]  objectForKeyedSubscript:statusMW] boolValue];
                      
                      id user= [[objPay objectAtIndex:i]  objectForKeyedSubscript:userMW];
                      UserObj *uObj=[[UserObj alloc] init];
                      
                      uObj.userName = [user  objectForKeyedSubscript:userNameMW];
                      uObj.name = [user  objectForKeyedSubscript:nameMW];
                      uObj.JobTitle = [user  objectForKeyedSubscript:jobTitleMW];
                      uObj.JobCode = [user  objectForKeyedSubscript:jobCodeMW];
                      obj.user = uObj;
                      
                      [lst addObject:obj];
                  }
                  [output setObject:[objResponse objectForKeyedSubscript:delegationsCountMW] forKeyedSubscript:delegationsCountMW];
                  [output setObject:lst forKeyedSubscript:listMW];
                  [dataTransfer dataLoaded:output error:nil withService:serv];
                
                  
                  
              }else{
                  CustomError * customError = [[CustomError alloc] init];
                  customError.errorMessage=ServerErrorMsg;
                  [dataTransfer dataLoaded:nil error:customError withService:serv];
              }
              
          }
          failure:^(NSURLSessionDataTask *task, NSError *error) {
              [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
              CustomError * customError = [[CustomError alloc] init];
              customError.errorMessage=ServerErrorMsg;
              [dataTransfer dataLoaded:nil error:customError withService:serv];
          }];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
}

-(void)addDelegation:(id)delegate withDelegationObj:(DelegationObj*)withDelegationObj
{
    Service serv= AddDelegationsList_WS;
    
    NSString *urlString=[self getFullServiceString:serv];
    
    NSLog(@"Add Delegation url=%@",urlString);
    
    NSURL *url =  [[NSURL alloc] initWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    DataTransfer *dataTransfer= [[DataTransfer alloc] init];
    dataTransfer.delegate = delegate;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSString * language = @"";
    if(appDelegate.currentLang == Arabic){
        language=@"ar";
    }else{
        language=@"en";
    }
    
    NSDictionary *inputDic = @{
                               MW_languageParamPost:language,
                               delegationrequesterUserNameMW:appDelegate.EmployeeObj.userName,
                               delegationactorUserNameMW:withDelegationObj.user.userName,
                               startDateMW:withDelegationObj.startTime,
                               endDateMW:withDelegationObj.endTime,
                               serviceCodeMW:withDelegationObj.serviceCode,
                               requestCodeMW:withDelegationObj.requestNo,
                               statusMW:[NSNumber numberWithBool:withDelegationObj.status]};
    
    NSDictionary *parameter = @{@"input":inputDic};
    
    [manager POST:[url absoluteString]
       parameters:parameter
          success:^(NSURLSessionDataTask *task, id responseObject) {
              [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
              
              id result = [responseObject objectForKeyedSubscript:addDelegationResult_MW];
              id op_status= [result objectForKeyedSubscript:status_MW];
              BOOL operationStatus=[[op_status objectForKeyedSubscript:successStatusMW] boolValue];
              
              if (operationStatus) {
                  id objResponse= [result objectForKeyedSubscript:response_MW];
                  [dataTransfer dataLoaded:objResponse error:nil withService:serv];
              }else{
                  NSString *op_error=[op_status objectForKeyedSubscript:error_message_MW];
                  CustomError * customError = [[CustomError alloc] init];
                  customError.errorMessage=op_error;
                  [dataTransfer dataLoaded:nil error:customError withService:serv];
              }
          }
          failure:^(NSURLSessionDataTask *task, NSError *error) {
              [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
              CustomError * customError = [[CustomError alloc] init];
              customError.errorMessage=ServerErrorMsg;
              [dataTransfer dataLoaded:nil error:customError withService:serv];
          }];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

-(void)GetUsersList:(id)delegate withFilterStr:(NSString*)withFilterStr{
    
    Service serv= GetUsersList_WS;
    
    NSString *urlString=[self getFullServiceString:serv];
    
    NSLog(@"Users url=%@",urlString);
    
    NSURL *url =  [[NSURL alloc] initWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    DataTransfer *dataTransfer= [[DataTransfer alloc] init];
    dataTransfer.delegate = delegate;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSString * language = @"";
    if(appDelegate.currentLang == Arabic){
        language=@"ar";
    }else{
        language=@"en";
    }
    
    NSDictionary *inputDic = @{filter_paramPost:withFilterStr,
                               MW_languageParamPost:language};
    
    NSDictionary *parameter = @{@"input":inputDic};
    
    [manager POST:[url absoluteString]
       parameters:parameter
          success:^(NSURLSessionDataTask *task, id responseObject) {
              [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
              
              id result = [responseObject objectForKeyedSubscript:getUsersListResults_MW];
              
              id op_status= [result objectForKeyedSubscript:status_MW];
              BOOL operationStatus=[[op_status objectForKeyedSubscript:successStatusMW] boolValue];
              
              if (operationStatus) {
                  
                  NSArray* objResponse= [result objectForKeyedSubscript:response_MW];
                  NSMutableArray *lst=[[NSMutableArray alloc] init];
                  
                  for(int i=0;i<[objResponse count];i++){
                      
                      UserObj *obj=[[UserObj alloc] init];
                      obj.userName = [[objResponse objectAtIndex:i]  objectForKeyedSubscript:userNameMW];
                      obj.name = [[objResponse objectAtIndex:i]  objectForKeyedSubscript:nameMW];
                      obj.JobTitle = [[objResponse objectAtIndex:i]  objectForKeyedSubscript:jobTitleMW];
                      obj.JobCode = [[objResponse objectAtIndex:i]  objectForKeyedSubscript:jobCodeMW];
                      [lst addObject:obj];
                  }
                  [dataTransfer dataLoaded:lst error:nil withService:serv];
              }else{
                  CustomError * customError = [[CustomError alloc] init];
                  customError.errorMessage=ServerErrorMsg;
                  [dataTransfer dataLoaded:nil error:customError withService:serv];
              }
              
          }
          failure:^(NSURLSessionDataTask *task, NSError *error) {
              [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
              CustomError * customError = [[CustomError alloc] init];
              customError.errorMessage=ServerErrorMsg;
              [dataTransfer dataLoaded:nil error:customError withService:serv];
          }];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

-(void)editDelegation:(id)delegate withDelegationObj:(DelegationObj*)withDelegationObj
{
    Service serv= EditDelegationsList_WS;
    
    NSString *urlString=[self getFullServiceString:serv];
    
    NSLog(@"Edit Delegation url=%@",urlString);
    
    NSURL *url =  [[NSURL alloc] initWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    DataTransfer *dataTransfer= [[DataTransfer alloc] init];
    dataTransfer.delegate = delegate;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSString * language = @"";
    if(appDelegate.currentLang == Arabic){
        language=@"ar";
    }else{
        language=@"en";
    }
    
    NSDictionary *inputDic = @{
                               MW_languageParamPost:language,
                               delegationIdMW:[NSString stringWithFormat:@"%li",(long)withDelegationObj.delegationID],
                               
                               delegationrequesterUserNameMW:appDelegate.EmployeeObj.userName,
                               delegationactorUserNameMW:withDelegationObj.user.userName,
                               startDateMW:withDelegationObj.startTime,
                               endDateMW:withDelegationObj.endTime,
                               serviceCodeMW:withDelegationObj.serviceCode,
                               requestCodeMW:withDelegationObj.requestNo,
                               statusMW:[NSNumber numberWithBool:withDelegationObj.status]};
    
    NSDictionary *parameter = @{@"input":inputDic};
    
    [manager POST:[url absoluteString]
       parameters:parameter
          success:^(NSURLSessionDataTask *task, id responseObject) {
              [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
              
              id result = [responseObject objectForKeyedSubscript:editDelegationResults_MW];
              
              id op_status= [result objectForKeyedSubscript:status_MW];
              BOOL operationStatus=[[op_status objectForKeyedSubscript:successStatusMW] boolValue];
              
              if (operationStatus)
                  [dataTransfer dataLoaded:EditDelegationConfirmationMsg error:nil withService:serv];
              else{
                  NSString *op_error=[op_status objectForKeyedSubscript:error_message_MW];
                  CustomError * customError = [[CustomError alloc] init];
                  customError.errorMessage=op_error;
                  [dataTransfer dataLoaded:nil error:customError withService:serv];
              }
          }
          failure:^(NSURLSessionDataTask *task, NSError *error) {
              [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
              CustomError * customError = [[CustomError alloc] init];
              customError.errorMessage=ServerErrorMsg;
              [dataTransfer dataLoaded:nil error:customError withService:serv];
          }];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

-(void)deleteDelegation:(id)delegate withDelegationsArr:(NSMutableArray*)withDelegationsArr
{
    Service serv= DeleteDelegationsList_WS;
    
    NSString *urlString=[self getFullServiceString:serv];
    
    NSLog(@"Delete Delegation url=%@",urlString);
    
    NSURL *url =  [[NSURL alloc] initWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    DataTransfer *dataTransfer= [[DataTransfer alloc] init];
    dataTransfer.delegate = delegate;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSDictionary *parameter = @{@"input":withDelegationsArr};
    
    [manager POST:[url absoluteString]
       parameters:parameter
          success:^(NSURLSessionDataTask *task, id responseObject) {
              [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
              
              id result = [responseObject objectForKeyedSubscript:deleteDelegationResults_MW];
              
              id op_status= [result objectForKeyedSubscript:status_MW];
              BOOL operationStatus=[[op_status objectForKeyedSubscript:successStatusMW] boolValue];
              
              if (operationStatus) {
                  [dataTransfer dataLoaded:DeleteDelegationConfirmationMsg error:nil withService:serv];
                  
              }else{
                  CustomError * customError = [[CustomError alloc] init];
                  customError.errorMessage=ServerErrorMsg;
                  [dataTransfer dataLoaded:nil error:customError withService:serv];
              }
              
          }
          failure:^(NSURLSessionDataTask *task, NSError *error) {
              [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
              CustomError * customError = [[CustomError alloc] init];
              customError.errorMessage=ServerErrorMsg;
              [dataTransfer dataLoaded:nil error:customError withService:serv];
          }];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

-(void)updateLanguage:(id)delegate{
    
    Service serv= UpdateLanguage_WS;
    
    NSString *urlString=[self getFullServiceString:serv];
    
    NSLog(@"update language url=%@",urlString);
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSURL *url = [[NSURL alloc] initWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    DataTransfer *dataTransfer= [[DataTransfer alloc] init];
    dataTransfer.delegate = delegate;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSString * language = @"";
    if(appDelegate.currentLang == Arabic){
        language=@"ar";
    }else{
        language=@"en";
    }
    
    NSDictionary *inputDic = @{userNameMW_paramPost:appDelegate.EmployeeObj.userName,
                               MW_languageParamPost:language};
    
    
    NSDictionary *parameter = @{@"input":inputDic};
    
    [manager POST:[url absoluteString]
       parameters:parameter
          success:^(NSURLSessionDataTask *task, id responseObject) {
              [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
              
              
              NSLog(@"success language : %@",responseObject);
              id result = [responseObject objectForKeyedSubscript:updateLanguageResult_MW];
              
              id op_status= [result objectForKeyedSubscript:status_MW];
              BOOL operationStatus=[[op_status objectForKeyedSubscript:successStatusMW] boolValue];
              
              if (operationStatus) {
                  [dataTransfer dataLoaded:UpdateLanguageConfirmationMsg error:nil withService:serv];
              }else{
                  CustomError * customError = [[CustomError alloc] init];
                  customError.errorMessage=ServerErrorMsg;
                  [dataTransfer dataLoaded:nil error:customError withService:serv];
              }
              
          }
          failure:^(NSURLSessionDataTask *task, NSError *error) {
              [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
              CustomError * customError = [[CustomError alloc] init];
              customError.errorMessage=ServerErrorMsg;
              [dataTransfer dataLoaded:nil error:customError withService:serv];
          }];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    
}


-(void)getPermissions:(id)delegate withUsername:(NSString*)user
{
    Service serv= GetPermissionsList_WS;
    NSString *urlString=[self getFullServiceString:serv];
    
    NSLog(@"permissions url=%@",urlString);
    
    NSURL *url =  [[NSURL alloc] initWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    DataTransfer *dataTransfer= [[DataTransfer alloc] init];
    dataTransfer.delegate = delegate;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSString * language = @"";
    if(appDelegate.currentLang == Arabic){
        language=@"ar";
    }else{
        language=@"en";
    }
    
    NSDictionary *inputDic = @{userNameMW_paramPost:user,
                               MW_languageParamPost:language};
    
    NSDictionary *parameter = @{@"input":inputDic};
    
    [manager POST:[url absoluteString]
       parameters:parameter
          success:^(NSURLSessionDataTask *task, id responseObject) {
              [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
              
              
              id result = [responseObject objectForKeyedSubscript:getPermissionsListResults_MW];
              
              id op_status= [result objectForKeyedSubscript:status_MW];
              BOOL operationStatus=[[op_status objectForKeyedSubscript:successStatusMW] boolValue];
              
              if (operationStatus) {
                  
                  NSArray *objResponse= [result objectForKeyedSubscript:response_MW];
                  
                  NSMutableArray *lst=[[NSMutableArray alloc] init];
                  
                  for(int i=0;i<[objResponse count];i++){
                      PermissionObj*obj=[[PermissionObj alloc] init];
                      obj.serviceName = [[objResponse objectAtIndex:i]  objectForKeyedSubscript:serviceNameMW];
                      obj.pages = [[NSMutableArray alloc] init];

                      NSMutableArray *pages = [[objResponse objectAtIndex:i]  objectForKeyedSubscript:pagesMW];
                      for (int j=0; j<[pages count]; j++) {
                          PageObj *pObj = [[PageObj alloc] init];
                          pObj.pageName=[[pages objectAtIndex:j]  objectForKeyedSubscript:pageNameMW];
                          pObj.actions=[[pages objectAtIndex:j]  objectForKeyedSubscript:actionsMW];
                          
                          [obj.pages addObject:pObj];
                      }
                      [lst addObject:obj];
                  }
                  [dataTransfer dataLoaded:lst error:nil withService:serv];
                  
              }else{
                  CustomError * customError = [[CustomError alloc] init];
                  customError.errorMessage=ServerErrorMsg;
                  [dataTransfer dataLoaded:nil error:customError withService:serv];
              }
              
          }
          failure:^(NSURLSessionDataTask *task, NSError *error) {
              [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
              CustomError * customError = [[CustomError alloc] init];
              customError.errorMessage=ServerErrorMsg;
              [dataTransfer dataLoaded:nil error:customError withService:serv];
          }];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
}

-(void)getRequestsList:(id)delegate withUsername:(NSString*)user withRequestCode:(NSString *)withRequestCode withDirection:(NSString *)withDirection withCategory:(NSString *)withCategory withFilteredServiceCode:(NSString *)withFilteredServiceCode withFilteredRequesterFilter:(NSString *)withFilteredRequesterFilter withFilteredFromDate:(NSString *)withFilteredFromDate withFilteredToDate:(NSString *)withFilteredToDate  withFilteredRequestCode:(NSString *)withFilteredRequestCode
{
    Service serv= GetRequestsList_WS;
    
    NSString *urlString=[self getFullServiceString:serv];
    
    NSLog(@"Requests url=%@",urlString);
    
    NSURL *url =  [[NSURL alloc] initWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    DataTransfer *dataTransfer= [[DataTransfer alloc] init];
    dataTransfer.delegate = delegate;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSString * language = @"";
    if(appDelegate.currentLang == Arabic){
        language=@"ar";
    }else{
        language=@"en";
    }
    
    NSDictionary *filterDic = @{serviceCodeMW:withFilteredServiceCode,
                                requesterFilter_paramPost:withFilteredRequesterFilter,
                                fromDate_paramPost:withFilteredFromDate,
                                toDate_paramPost:withFilteredToDate,
                                requestCodeMW:withFilteredRequestCode};
    
    NSDictionary *inputDic = @{userNameMW_paramPost:user,
                               requestCodeMW:withRequestCode,
                               directionMW_paramPost:withDirection,
                               category_paramPost:withCategory,
                               MW_languageParamPost:language,
                               filter_paramPost:filterDic};
    
    NSDictionary *parameter = @{@"input":inputDic};
    
    [manager POST:[url absoluteString]
       parameters:parameter
          success:^(NSURLSessionDataTask *task, id responseObject) {
              [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
              
              id result = [responseObject objectForKeyedSubscript:requestResultMW];
              
              id op_status= [result objectForKeyedSubscript:status_MW];
              BOOL operationStatus=[[op_status objectForKeyedSubscript:successStatusMW] boolValue];
              
              
              NSMutableDictionary *output = [[NSMutableDictionary alloc] init];
              if (operationStatus) {
                  
                  id objResponse= [result objectForKeyedSubscript:response_MW];
                  NSMutableArray *lst=[[NSMutableArray alloc] init];
                  NSArray* objPay =(NSArray*) [objResponse objectForKeyedSubscript:listMW];
                  
                  for(int i=0;i<[objPay count];i++){
                      
                      
                      RequestObj *obj=[[RequestObj alloc] init];
                      
                      obj.requestCode = [[objPay objectAtIndex:i]  objectForKeyedSubscript:requestCodeMW];
                      obj.requestDate = [[objPay objectAtIndex:i]  objectForKeyedSubscript:requestDate_MW];
                      obj.requestStatus = [[objPay objectAtIndex:i]  objectForKeyedSubscript:requestStatus_MW];
                      obj.requesterName = [[objPay objectAtIndex:i]  objectForKeyedSubscript:requesterName_MW];
                      obj.serviceCode = [[objPay objectAtIndex:i]  objectForKeyedSubscript:serviceCodeMW];
                      obj.serviceTypeName = [[objPay objectAtIndex:i]  objectForKeyedSubscript:requesterTypeName_MW];
                      obj.serviceName = [[objPay objectAtIndex:i] objectForKeyedSubscript:serviceNameMW];
                      [lst addObject:obj];
                  }
                  [output setObject:[objResponse objectForKeyedSubscript:completedCount_MW] forKeyedSubscript:completedCount_MW];
                  [output setObject:[objResponse objectForKeyedSubscript:processedCount_MW] forKeyedSubscript:processedCount_MW];
                  [output setObject:[objResponse objectForKeyedSubscript:mineCount_MW] forKeyedSubscript:mineCount_MW];
                  [output setObject:[objResponse objectForKeyedSubscript:inboxCount_MW] forKeyedSubscript:inboxCount_MW];
                  [output setObject:[objResponse objectForKeyedSubscript:searchCount_MW] forKeyedSubscript:searchCount_MW];
                  
                  [output setObject:lst forKeyedSubscript:listMW];
                  [dataTransfer dataLoaded:output error:nil withService:serv];
                  
                  
              }
              else{
                  CustomError * customError = [[CustomError alloc] init];
                  customError.errorMessage=ServerErrorMsg;
                  [dataTransfer dataLoaded:nil error:customError withService:serv];
              }
              
          }
          failure:^(NSURLSessionDataTask *task, NSError *error) {
              [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
              CustomError * customError = [[CustomError alloc] init];
              customError.errorMessage=ServerErrorMsg;
              [dataTransfer dataLoaded:nil error:customError withService:serv];
          }];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
}

-(void)getRequestActionsList:(id)delegate withRequestCode:(NSString *)withRequestCode
{
    Service serv= GetRequestActionsList_WS;
    
    NSString *urlString=[self getFullServiceString:serv];
    
    NSLog(@"Request Actions url=%@",urlString);
    
    NSURL *url =  [[NSURL alloc] initWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    DataTransfer *dataTransfer= [[DataTransfer alloc] init];
    dataTransfer.delegate = delegate;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSString * language = @"";
    if(appDelegate.currentLang == Arabic){
        language=@"ar";
    }else{
        language=@"en";
    }
    
    
    NSDictionary *inputDic = @{requestCodeMW:withRequestCode,
                               MW_languageParamPost:language};
    
    NSDictionary *parameter = @{@"input":inputDic};
    
    [manager POST:[url absoluteString]
       parameters:parameter
          success:^(NSURLSessionDataTask *task, id responseObject) {
              [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
              
              id result = [responseObject objectForKeyedSubscript:requestActionsResultMW];
              
              id op_status= [result objectForKeyedSubscript:status_MW];
              BOOL operationStatus=[[op_status objectForKeyedSubscript:successStatusMW] boolValue];
              
              if (operationStatus) {
                  
                  NSArray* objResponse= [result objectForKeyedSubscript:response_MW];
                  NSMutableArray *lst=[[NSMutableArray alloc] init];
                  NSArray* objPay =(NSArray*)objResponse;
                  
                  
                  for(int i=0;i<[objPay count];i++){
                     
                      RequestActionsObj *obj=[[RequestActionsObj alloc] init];
                      obj.action = [[objPay objectAtIndex:i]  objectForKeyedSubscript:requestActionMW];
                      obj.userName = [[objPay objectAtIndex:i]  objectForKeyedSubscript:requestActorNameMW];
                      obj.reason = [[objPay objectAtIndex:i]  objectForKeyedSubscript:requestNotesMW];
                      obj.date = [[objPay objectAtIndex:i]  objectForKeyedSubscript:requestDateMW];
                      [lst addObject:obj];
                  }
                  
                  [dataTransfer dataLoaded:lst error:nil withService:serv];
                  
                  
              }else{
                  CustomError * customError = [[CustomError alloc] init];
                  customError.errorMessage=ServerErrorMsg;
                  [dataTransfer dataLoaded:nil error:customError withService:serv];
              }
              
          }
          failure:^(NSURLSessionDataTask *task, NSError *error) {
              [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
              CustomError * customError = [[CustomError alloc] init];
              customError.errorMessage=ServerErrorMsg;
              [dataTransfer dataLoaded:nil error:customError withService:serv];
          }];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
}

- (void)readRequestDetailsFromJSONFile:(id)delegate {
    
    Service serv = GetRequestDetails_WS;
    
    DataTransfer *dataTransfer = [[DataTransfer alloc] init];
    dataTransfer.delegate = delegate;
    
    // Read JSON data into array
    NSError *error;
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"RequestDetails" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    if (jsonData == nil) {
        // handle error ...
    }
    NSDictionary *jsonArray = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    if (jsonArray == nil) {
        // handle error ...
    }
    
    // Create custom objects from JSON array
    id result = [jsonArray objectForKeyedSubscript:requestDetailsResultMW];

    id op_status= [result objectForKeyedSubscript:status_MW];
    BOOL operationStatus=[[op_status objectForKeyedSubscript:successStatusMW] boolValue];
    
    if (operationStatus) {
        id objResponse= [result objectForKeyedSubscript:response_MW];
        NSMutableArray *pagesLst=[[NSMutableArray alloc] init];
        NSArray* pages =(NSArray*) [objResponse objectForKeyedSubscript:requestPagesMW];
        NSArray* sections;
        NSArray* rows;
        
        for(int i=0;i<[pages count];i++){
            RPageObj *pObj = [[RPageObj alloc] init];
            pObj.sections = [[NSMutableArray alloc] init];
            
            sections = [[pages objectAtIndex:i] objectForKeyedSubscript:requestPageSectionsMW];
            NSMutableArray *internalArr;
            RPageSectionObj *sObj;
            RPageSectionRowObj *rObj;
            NSMutableArray *arr;
            NSMutableArray *filledArr;
            RPageSectionRowObj *internalRObj;
            
            for (int j=0; j<[sections count] ; j++){
                sObj = [[RPageSectionObj alloc] init];
                sObj.rows = [[NSMutableArray alloc] init];
                
                sObj.sectionName = [[sections objectAtIndex:j]  objectForKeyedSubscript:SectionTitleMW];
                rows = [[sections objectAtIndex:j] objectForKeyedSubscript:requestPageSectionRowsMW];
                
                for (int y=0; y<[rows count]; y++) {
                    rObj = [[RPageSectionRowObj alloc] init];
                    rObj.dataType = [[rows objectAtIndex:y]  objectForKeyedSubscript:rowDataTypeMW];
                    rObj.label = [[rows objectAtIndex:y]  objectForKeyedSubscript:rowLabelMW];
                    rObj.singleValue = [[rows objectAtIndex:y]  objectForKeyedSubscript:rowSingleValueMW];
                    
                    arr = [[rows objectAtIndex:y]  objectForKeyedSubscript:rowListValueMW];
                    
                    
                    rObj.listValue = [[NSMutableArray alloc] init];
                    
                    
                    for (int x=0; x<[arr count]; x++) {
                        
                        internalArr = [arr objectAtIndex:x];
                        filledArr = [[NSMutableArray alloc] init];
                        
                        for (int c=0; c<[internalArr count]; c++) {
                            internalRObj = [[RPageSectionRowObj alloc] init];
                            
                            
                            internalRObj.dataType = [[internalArr objectAtIndex:c]  objectForKeyedSubscript:rowDataTypeMW];
                            
                            internalRObj.label = [[internalArr objectAtIndex:c]  objectForKeyedSubscript:rowLabelMW];
                            internalRObj.singleValue = [[internalArr objectAtIndex:c]  objectForKeyedSubscript:rowSingleValueMW];
                            internalRObj.listValue = [[internalArr objectAtIndex:c]  objectForKeyedSubscript:rowListValueMW];
                            
                            [filledArr addObject:internalRObj];
                        }
                        [rObj.listValue addObject:filledArr];
                    }
                    [sObj.rows addObject:rObj];
                }
                [pObj.sections addObject:sObj];
            }
            
            [pagesLst addObject:pObj];
        }
        [dataTransfer dataLoaded:pagesLst error:nil withService:serv];
        
    }else{
        CustomError * customError = [[CustomError alloc] init];
        customError.errorMessage=ServerErrorMsg;
        [dataTransfer dataLoaded:nil error:customError withService:serv];
    }
}

-(void)getRequestDetails:(id)delegate withRequestCode:(NSString *)withRequestCode{
 
    Service serv= GetRequestDetails_WS;
    
    NSString *urlString=[self getFullServiceString:serv];
    
    NSLog(@"Request Details url=%@",urlString);
    
    NSURL *url =  [[NSURL alloc] initWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    DataTransfer *dataTransfer= [[DataTransfer alloc] init];
    dataTransfer.delegate = delegate;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSString * language = @"";
    if(appDelegate.currentLang == Arabic){
        language=@"ar";
    }else{
        language=@"en";
    }//3722166734
    
    NSDictionary *inputDic = @{requestCodeMW:withRequestCode,
                               MW_languageParamPost:language};
    
    NSDictionary *parameter = @{@"input":inputDic};
    
    [manager POST:[url absoluteString]
       parameters:parameter
          success:^(NSURLSessionDataTask *task, id responseObject) {
              [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
              
              id result = [responseObject objectForKeyedSubscript:requestDetailsResultMW];
              NSLog(@"NSString *result%@",responseObject);

              id op_status= [result objectForKeyedSubscript:status_MW];
              BOOL operationStatus=[[op_status objectForKeyedSubscript:successStatusMW] boolValue];
              
              if (operationStatus) {
                  id objResponse= [result objectForKeyedSubscript:response_MW];
                  NSMutableArray *pagesLst=[[NSMutableArray alloc] init];
                  NSArray* pages =(NSArray*) [objResponse objectForKeyedSubscript:requestPagesMW];
                  NSArray* sections;
                  NSArray* rows;
                  
                  for(int i=0;i<[pages count];i++){
                      RPageObj *pObj = [[RPageObj alloc] init];
                      pObj.sections = [[NSMutableArray alloc] init];
                      
                      sections = [[pages objectAtIndex:i] objectForKeyedSubscript:requestPageSectionsMW];
                      NSMutableArray *internalArr;
                      RPageSectionObj *sObj;
                      RPageSectionRowObj *rObj;
                      NSMutableArray *arr;
                      NSMutableArray *filledArr;
                      RPageSectionRowObj *internalRObj;
                      
                      for (int j=0; j<[sections count] ; j++){
                          sObj = [[RPageSectionObj alloc] init];
                          sObj.rows = [[NSMutableArray alloc] init];
                          
                          sObj.sectionName = [[sections objectAtIndex:j]  objectForKeyedSubscript:SectionTitleMW];
                          rows = [[sections objectAtIndex:j] objectForKeyedSubscript:requestPageSectionRowsMW];
                          
                          for (int y=0; y<[rows count]; y++) {
                              rObj = [[RPageSectionRowObj alloc] init];
                             
                              rObj.dataType = [[rows objectAtIndex:y]  objectForKeyedSubscript:rowDataTypeMW];
                              if ( ![[[rows objectAtIndex:y]  objectForKeyedSubscript:rowLabelMW] isKindOfClass:[NSNull class]]){
                              rObj.label = [[rows objectAtIndex:y]  objectForKeyedSubscript:rowLabelMW];
                              }else {
                                  rObj.label =@"";
                              }
                              if (![[[rows objectAtIndex:y]  objectForKeyedSubscript:rowSingleValueMW] isKindOfClass:[NSNull class]])
                              {
                                  rObj.singleValue = [[rows objectAtIndex:y]  objectForKeyedSubscript:rowSingleValueMW];
                              }
                              else
                              {
                                  
                                  rObj.singleValue = @"";
                              }
                              arr = [[rows objectAtIndex:y]  objectForKeyedSubscript:rowListValueMW];
                              
                              
                            //  NSLog(@"%@",[arr count]);

                              
                              
                                  rObj.listValue = [[NSMutableArray alloc] init];
                  
                              if ([arr isKindOfClass:[NSArray class]] &&arr.count > 0){
                              for (int x=0; x<[arr count]; x++) {

                                  internalArr = [arr objectAtIndex:x];
                                  filledArr = [[NSMutableArray alloc] init];

                                  for (int c=0; c<[internalArr count]; c++) {
                                      internalRObj = [[RPageSectionRowObj alloc] init];


                                      internalRObj.dataType = [[internalArr objectAtIndex:c]  objectForKeyedSubscript:rowDataTypeMW];

                                      internalRObj.label = [[internalArr objectAtIndex:c]  objectForKeyedSubscript:rowLabelMW];
                                      internalRObj.singleValue = [[internalArr objectAtIndex:c]  objectForKeyedSubscript:rowSingleValueMW];
                                      internalRObj.listValue = [[internalArr objectAtIndex:c]  objectForKeyedSubscript:rowListValueMW];

                                      [filledArr addObject:internalRObj];
                                  }
                                  [rObj.listValue addObject:filledArr];
                              }
                              
                              }
                              [sObj.rows addObject:rObj];
                          }
                          [pObj.sections addObject:sObj];
                      }
                      /*
                      //to be changed
                      for (int j=0; j<[sections count] * 2 ; j++){
                          sObj = [[RPageSectionObj alloc] init];
                          sObj.rows = [[NSMutableArray alloc] init];
                          
                          sObj.sectionName = [[sections objectAtIndex:0]  objectForKeyedSubscript:SectionTitleMW];
                          rows = [[sections objectAtIndex:0] objectForKeyedSubscript:requestPageSectionRowsMW];
                          
                          for (int y=0; y<[rows count]; y++) {
                              rObj = [[RPageSectionRowObj alloc] init];
                              rObj.dataType = [[rows objectAtIndex:y]  objectForKeyedSubscript:rowDataTypeMW];
                              rObj.label = [[rows objectAtIndex:y]  objectForKeyedSubscript:rowLabelMW];
                              rObj.singleValue = [[rows objectAtIndex:y]  objectForKeyedSubscript:rowSingleValueMW];
                              
                              arr = [[rows objectAtIndex:y]  objectForKeyedSubscript:rowListValueMW];
                              
                              
                              rObj.listValue = [[NSMutableArray alloc] init];
                              
                              
                              for (int x=0; x<[arr count]; x++) {
                              
                                  internalArr = [arr objectAtIndex:x];
                                  filledArr = [[NSMutableArray alloc] init];
                                  
                                  for (int c=0; c<[internalArr count]; c++) {
                                      internalRObj = [[RPageSectionRowObj alloc] init];
                                      
                                      
                                      internalRObj.dataType = [[internalArr objectAtIndex:c]  objectForKeyedSubscript:rowDataTypeMW];
                                      
                                      internalRObj.label = [[internalArr objectAtIndex:c]  objectForKeyedSubscript:rowLabelMW];
                                      internalRObj.singleValue = [[internalArr objectAtIndex:c]  objectForKeyedSubscript:rowSingleValueMW];
                                      internalRObj.listValue = [[internalArr objectAtIndex:c]  objectForKeyedSubscript:rowListValueMW];
                                      
                                      [filledArr addObject:internalRObj];
                                  }
                                  [rObj.listValue addObject:filledArr];
                              }
                              [sObj.rows addObject:rObj];
                          }
                          [pObj.sections addObject:sObj];
                      }*/
                      
                      [pagesLst addObject:pObj];
                  }
                  [dataTransfer dataLoaded:pagesLst error:nil withService:serv];

              }else{
                  CustomError * customError = [[CustomError alloc] init];
                  customError.errorMessage=ServerErrorMsg;
                  [dataTransfer dataLoaded:nil error:customError withService:serv];
              }
              
          }
          failure:^(NSURLSessionDataTask *task, NSError *error) {
              [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
              CustomError * customError = [[CustomError alloc] init];
              customError.errorMessage=ServerErrorMsg;
              [dataTransfer dataLoaded:nil error:customError withService:serv];
          }];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
}
-(void)sendMail:(id)delegate withMailObj:(MailObj *)withMailObj forEmpNo:(NSString*)Empno{
    Service serv= SendEmail_WS;
    
    NSString * urlString = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@",
                            [self getFullServiceString:serv],
                            NameParam,withMailObj.userName,MW_GeneralDel,
                            MobileNoParam,withMailObj.mobileNum,MW_GeneralDel,
                            SenderEmailParam,withMailObj.email,MW_GeneralDel,
                            MessageTextParam,withMailObj.message,MW_GeneralDel,
                            EmployeeNumParam,Empno];
    
    urlString=[RequestManager addLanguageURL:urlString];
    urlString=[self stringParam:urlString value:MW_GeneralDel];
    urlString=[RequestManager addSecretKeyURL:urlString];
    
    NSLog(@"Send Mail url=%@",urlString);
    
    NSURL *url =  [[NSURL alloc] initWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    DataTransfer *dataTransfer= [[DataTransfer alloc] init];
    dataTransfer.delegate = delegate;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    
    
    
    [manager GET:[url absoluteString]
      parameters:nil
         success:^(NSURLSessionDataTask *task, id responseObject) {
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
             
             NSLog(@"success: %@",responseObject);
             id result = [responseObject objectForKeyedSubscript:SendEmailMobileMW];
             BOOL operationStatus=[[result objectForKeyedSubscript:operationStatusMW] boolValue];
             
             if (operationStatus) {
                 NSString *msg=[result objectForKeyedSubscript:MWErrorMessage];
                 [dataTransfer dataLoaded:msg error:nil withService:serv];
             }else{
                 CustomError *customError = [CustomError initWithError:result];
                 [dataTransfer dataLoaded:nil error:customError withService:serv];
                 
             }
             
             
             
         } failure:^(NSURLSessionDataTask *task, NSError *error) {
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
             
             // Handle failure
             NSLog(@"failed: %@",error);
             CustomError * customError = [[CustomError alloc] init];
             customError.errorMessage=ServerErrorMsg;
             [dataTransfer dataLoaded:nil error:customError withService:serv];
         }];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
}

@end
