//
//  RequestManager.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 12/10/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DelegationObj.h"
#import "MailObj.h"

@interface RequestManager : NSObject

+ (RequestManager *)sharedInstance;

-(void)login:(id)delegate withUsername:(NSString*)user withPassword:(NSString*)pass;
-(void)GetExternalDocumentUnit:(id)delegate;
-(void)docSelfInquiry:(id)delegate withDocNumber:(NSString*)withDocNumber withDocDate:(NSString*)withDocDate withDocCode:(NSString*)withDocCode;
-(void)docSelfInquiry:(id)delegate withLogBookNumber:(NSString*)withLogBookNumber withLogBookYear:(NSString*)withLogBookYear;

-(void)contacts:(id)delegate;
-(void)getProfileData:(id)delegate forEmpNo:(NSString*)Empno;
-(void)getPassportInfo:(id)delegate forEmpNo:(NSString*)Empno;
-(void)getSalaryData:(id)delegate forEmpNo:(NSString*)Empno withMonth:(NSString*)month withYear:(NSString*)Year;

-(void)getPaymentData:(id)delegate forEmpNo:(NSString*)Empno withYear:(NSString*)Year;
-(void)changePassword:(id)delegate forEmpNo:(NSString*)Empno withOldPassword:(NSString*)oldPW withNewPassword:(NSString*)newPW;
-(void)getSchedule:(id)delegate forEmpNo:(NSString*)Empno;
-(void)getVacations:(id)delegate forEmpNo:(NSString*)Empno;

-(void)sendClaim:(id)delegate forEmpNo:(NSString*)Empno withText:(NSString*)text;

-(void)getClaimLst:(id)delegate forEmpNo:(NSString*)Empno;
-(void)getCustodyInfo:(id)delegate forEmpNo:(NSString*)Empno;

-(void)forgetPW:(id)delegate withUserName:(NSString*)username;
-(void)itSupport:(id)delegate withSubject:(NSString*)sub withText:(NSString*)text withImage:(UIImage*)userImg;

-(void)getvehicles:(id)delegate forEmpNo:(NSString*)Empno;

-(void)forgetPWVerify:(id)delegate withUserName:(NSString*)username withVerificationCode:(NSString*)code;

-(void)getBookBorrowed:(id)delegate forEmpNo:(NSString*)Empno;

-(void)updateDeviceToken:(NSString *)deviceToken :(id)delegate;

-(void)getNotifications:(id)delegate forEmpNo:(NSString*)Empno;
-(void)deleteNotifications:(id)delegate forEmpNo:(NSString*)Empno;

-(void)deleteDeviceToken:(NSString *)deviceToken :(id)delegate;
-(void)getServicesList:(id)delegate withUsername:(NSString*)user withForceGet:(BOOL)withForceGet;
-(void)getDelegationsList:(id)delegate withUsername:(NSString*)user withDelegationID:(NSInteger)withDelegationID withDirection:(NSString *)withDirection;
-(void)addDelegation:(id)delegate withDelegationObj:(DelegationObj*)withDelegationObj;
-(void)GetUsersList:(id)delegate withFilterStr:(NSString*)withFilterStr;
-(void)editDelegation:(id)delegate withDelegationObj:(DelegationObj*)withDelegationObj;
-(void)deleteDelegation:(id)delegate withDelegationsArr:(NSMutableArray*)withDelegationsArr;
-(void)updateLanguage:(id)delegate;
-(void)getPermissions:(id)delegate withUsername:(NSString*)user;
-(void)getRequestsList:(id)delegate withUsername:(NSString*)user withRequestCode:(NSString *)withRequestCode withDirection:(NSString *)withDirection withCategory:(NSString *)withCategory withFilteredServiceCode:(NSString *)withFilteredServiceCode withFilteredRequesterFilter:(NSString *)withFilteredRequesterFilter withFilteredFromDate:(NSString *)withFilteredFromDate withFilteredToDate:(NSString *)withFilteredToDate  withFilteredRequestCode:(NSString *)withFilteredRequestCode;
-(void)getRequestActionsList:(id)delegate withRequestCode:(NSString *)withRequestCode;
- (void)readRequestDetailsFromJSONFile:(id)delegate;
-(void)getRequestDetails:(id)delegate withRequestCode:(NSString *)withRequestCode;
-(void)sendMail:(id)delegate withMailObj:(MailObj *)withMailObj forEmpNo:(NSString*)Empno;
-(void) getOffersCategories:(id)delegate;
-(void) getCategoryItems:(id)delegate CatName:(NSString*)CatName;
-(UIImage*) generateImage : (NSString*) url;

@end
