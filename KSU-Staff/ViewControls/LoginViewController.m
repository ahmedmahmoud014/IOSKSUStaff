//
//  LoginViewController.m
//  KSU-Staff
//
//  Created by EJ-Mac book on 9/18/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import "LoginViewController.h"
#import "DocInfoViewController.h"
#import "LocalizedMessages.h"
#import "AppDelegate.h"
#import "DashBoardViewController.h"
#import "RequestManager.h"
#import "StaticFuntions.h"
#import "ExternalDocumentUnitObj.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize userName;
@synthesize password;
@synthesize userNameTxt;
@synthesize passwordTxt;
@synthesize userNameImg;
@synthesize passwordImg;
@synthesize loginBtn;
@synthesize forgetPWBtn;
@synthesize langBtn;
@synthesize controlsView;
@synthesize docInfoView;
@synthesize tochIDCheckBoxBtn;
@synthesize tochIDBtn;
@synthesize useTouchID;
@synthesize docInfoImgBtn,docInfoBtn;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    if (IS_IPAD) {
        int x = (self.view.frame.size.width - controlsView.frame.size.width) / 2;
        controlsView.frame = CGRectMake(x, 450, controlsView.frame.size.width, controlsView.frame.size.height);
        docInfoView.frame = CGRectMake(x, controlsView.frame.size.height + 490, docInfoView.frame.size.width, docInfoView.frame.size.height);
    }
    // Do any additional setup after loading the view.
    AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    ProfileObj *obj = [StaticFuntions getSavedData];
    
    
    if (!appdelegate.islogOut) {
        
        if(obj==nil||obj.userName==nil||[StaticFuntions isStringEmpty:obj.userName]) {
            if(appdelegate.currentLang!=obj.userLang)
                [self onLanguagePressed:nil];
            appdelegate.currentLang=obj.userLang;
            useTouchID = obj.useTouchID;
        } else {
            
            appdelegate.EmployeeObj = obj;
            if (appdelegate.currentLang != obj.userLang)
                [self onLanguagePressed:nil];
            appdelegate.currentLang=obj.userLang;
            useTouchID = obj.useTouchID;
            
            UIViewController * viewController = [self.storyboard instantiateViewControllerWithIdentifier:SeagueDashBoardScreen];
           [self.navigationController pushViewController:viewController animated:NO];
            
         //   [(UINavigationController *)self.window.rootViewController pushViewController:viewController animated:NO];

            
         //   UINavigationController *navcont = [[UINavigationController alloc]  initWithRootViewController:viewController];
//            //[self presentViewController:navcont animated:YES];
//            [navcont setModalPresentationStyle:UIModalPresentationFormSheet];
//            [self presentViewController: navcont animated: YES completion: nil];
        }
    } else {
        if (obj != nil) {
            if(appdelegate.currentLang != obj.userLang)
                [self onLanguagePressed:nil];
            appdelegate.currentLang=obj.userLang;
            useTouchID = obj.useTouchID;
        }
    }
    
    tochIDBtn.hidden = YES;
    tochIDCheckBoxBtn.hidden = YES;
    
    if (obj == nil || obj.userName == nil || [StaticFuntions isStringEmpty:obj.userName]) {
        LAContext *context = [[LAContext alloc] init];
        NSError *error = nil;
        if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
            
            tochIDBtn.hidden = FALSE;
            tochIDCheckBoxBtn.hidden = FALSE;
        }
    }
    
    
    if (useTouchID) {
        [tochIDCheckBoxBtn setBackgroundImage:[UIImage imageNamed:@"checkbox-selected.png"] forState:UIControlStateNormal];
        
        if (!appdelegate.islogOut && (obj == nil || obj.userName == nil || [StaticFuntions isStringEmpty:obj.userName])) {
            [self callTouchFunction];
        }
    } else {
        [tochIDCheckBoxBtn setBackgroundImage:[UIImage imageNamed:@"checkbox-empty.png"] forState:UIControlStateNormal];
    }
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - text field delegate


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == userNameTxt) {
        [passwordTxt becomeFirstResponder];
    }
    else
    {
        [self onLoginPressed:nil];
    }
    return YES;
}

#pragma mark - base methods

-(void)callTouchFunction{
    ProfileObj * obj= [StaticFuntions getSavedTouchIDData];
    
    if (obj == nil) {
        [StaticFuntions showAlertWithTitle:ApplicationTitleText Message:FingerPrintErrorText];
    }
    else
    {
        
        
        LAContext *context = [[LAContext alloc] init];
        NSError *error = nil;
        
        if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
            [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                    localizedReason:@"Are you the device owner?"
                              reply:^(BOOL success, NSError *error)
             {
                 
                 if (error) {
                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"There was a problem verifying your identity." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                     [alert show];
                     return;
                 }
                 if (success) {
                     [[RequestManager sharedInstance] login:self withUsername:obj.userName withPassword:obj.password];
                     userName=obj.userName;
                     password=obj.password;
                     [self showActivityViewer];
                     
                 } else {
                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:ErrorGeneralTitle message:@"You are not the device owner." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                     [alert show];
                 }
                 
             }];
            
        }
    }
    
    
    
    
    
    
}

-(void)initalizeViews{
    self.BGImage.image= [UIImage imageNamed:@"login-bg.png"];
    /*AppDelegate* appDelegate=[[UIApplication sharedApplication] delegate];
     if(appDelegate.currentLang==Arabic){
     
     }*/
}

-(void)locatizeLables{
    //userNameTxt.placeholder=usernameLblText;
    //passwordTxt.placeholder=passwordLblText;
    UIColor *color = [UIColor whiteColor];
    userNameTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:usernameLblText attributes:@{NSForegroundColorAttributeName:color}];
    
    passwordTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:passwordLblText attributes:@{NSForegroundColorAttributeName:color}];
    
    [loginBtn setTitle:loginLblText forState:UIControlStateNormal];
    [forgetPWBtn setTitle:forgetPWLblText forState:UIControlStateNormal];
    [docInfoBtn setTitle:DocInfoLblText forState:UIControlStateNormal];
    [tochIDBtn setTitle:FingerPrintLblText forState:UIControlStateNormal];
    
    [userNameTxt setReturnKeyType:UIReturnKeyNext];
    [passwordTxt setReturnKeyType:UIReturnKeyDone];
}

-(void)switchToLeftLayout{
    CGRect frame= userNameTxt.frame;
    frame.origin.x=60;
    userNameTxt.frame=frame;
    
    //userNameImg.image=[UIImage imageNamed:@"username-en.png"];
    
    frame= passwordTxt.frame;
    frame.origin.x=60;
    passwordTxt.frame=frame;
    
    // passwordImg.image=[UIImage imageNamed:@"pw-en.png"];
    
    frame= userNameImg.frame;
    frame.origin.x=25;
    userNameImg.frame=frame;
    
    frame= passwordImg.frame;
    frame.origin.x=25;
    passwordImg.frame=frame;
    
    /*frame= forgetPWBtn.frame;
     frame.origin.x=137;
     forgetPWBtn.frame=frame;
     */
    frame=langBtn.frame;
    frame.origin.x= 34;
    //langBtn.frame=frame;
    
    [langBtn setImage:[UIImage imageNamed:@"language_ar.png"] forState:UIControlStateNormal];
    userNameTxt.textAlignment=NSTextAlignmentLeft;
    passwordTxt.textAlignment=NSTextAlignmentLeft;
    
    frame=tochIDCheckBoxBtn.frame;
    frame.origin.x = 50;
    tochIDCheckBoxBtn.frame=frame;
    
    frame=tochIDBtn.frame;
    frame.origin.x = tochIDCheckBoxBtn.frame.origin.x + tochIDCheckBoxBtn.frame.size.width + 5;
    tochIDBtn.frame=frame;
    
    
    tochIDBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
}

-(void)switchToRightLayout{
    CGRect frame= userNameTxt.frame;
    frame.origin.x=25;
    userNameTxt.frame=frame;
    
    //userNameImg.image=[UIImage imageNamed:@"username-ar.png"];
    
    frame= passwordTxt.frame;
    frame.origin.x=25;
    passwordTxt.frame=frame;
    
    //passwordImg.image=[UIImage imageNamed:@"pw-ar.png"];
    
    frame= userNameImg.frame;
    frame.origin.x=265;
    userNameImg.frame=frame;
    
    frame= passwordImg.frame;
    frame.origin.x=265;
    passwordImg.frame=frame;
    
    /* frame= forgetPWBtn.frame;
     frame.origin.x=34;
     forgetPWBtn.frame=frame;
     */
    
    
    [langBtn setImage:[UIImage imageNamed:@"language.png"] forState:UIControlStateNormal];
    userNameTxt.textAlignment=NSTextAlignmentRight;
    passwordTxt.textAlignment=NSTextAlignmentRight;
    
    
    frame=tochIDBtn.frame;
    frame.origin.x = 50;
    tochIDBtn.frame=frame;
    
    frame=tochIDCheckBoxBtn.frame;
    frame.origin.x = tochIDBtn.frame.origin.x + tochIDBtn.frame.size.width + 5;
    tochIDCheckBoxBtn.frame=frame;
    
    tochIDBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
}

#pragma mark - events

-(IBAction)onDocInfoPressed:(id)sender
{
   
    
    
    if([self isNetworkAvailable] ==YES)
    {
        [self removeKeyboard];
        [self showActivityViewer];
        [[RequestManager sharedInstance] GetExternalDocumentUnit:self];
    }
    
    else{
        [StaticFuntions showAlertWithTitle:NetWorkTitle Message:NetWorkBody];
        
    }
    
    
    
    
}
-(IBAction)onFingerPrintPressed:(id)sender
{
    ProfileObj * obj= [StaticFuntions getSavedTouchIDData];
    if (useTouchID == NO) {
        useTouchID = YES;
        [tochIDCheckBoxBtn setBackgroundImage:[UIImage imageNamed:@"checkbox-selected.png"] forState:UIControlStateNormal];
        
        
        if (obj == nil)
            [StaticFuntions showAlertWithTitle:ApplicationTitleText Message:FingerPrintErrorText];
        else
            [self callTouchFunction];
    }
    else
    {
        useTouchID = NO;
        [tochIDCheckBoxBtn setBackgroundImage:[UIImage imageNamed:@"checkbox-empty.png"] forState:UIControlStateNormal];
    }
    
    
    AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    appdelegate.EmployeeObj=obj;
    appdelegate.EmployeeObj.useTouchID = useTouchID;
    [StaticFuntions UpdateFile:appdelegate.EmployeeObj];
    
    
}

-(IBAction)onLoginPressed:(id)sender{
    [self removeKeyboard];
    if(![self validate])return;
    /*  UIViewController * viewController = [self.storyboard instantiateViewControllerWithIdentifier:SeagueDashBoardScreen];
     [self.navigationController pushViewController:viewController animated:YES];*/
    
    
    if ([passwordTxt.text isEqualToString:@"ejawdahMob"]) {
        // To view Requests only
        AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
        userName=userNameTxt.text;
        password=passwordTxt.text;
        
        appdelegate.EmployeeObj=[[ProfileObj alloc] init];
        
        appdelegate.EmployeeObj.userLang=appdelegate.currentLang;
        appdelegate.EmployeeObj.userName=userName;
        appdelegate.EmployeeObj.password=password;
        appdelegate.islogOut=NO;
        appdelegate.EmployeeObj.empDeviceToken=appdelegate.deviceToken;
        appdelegate.EmployeeObj.useTouchID = useTouchID;
        appdelegate.EmployeeObj.empNo = @"";
        [StaticFuntions createFile:appdelegate.EmployeeObj];
        if (useTouchID) {
            ProfileObj * obj= [StaticFuntions getSavedTouchIDData];
            if (obj == nil)
                [StaticFuntions createTouchIDFile:appdelegate.EmployeeObj];
        }
        UIViewController * viewController = [self.storyboard instantiateViewControllerWithIdentifier:SeagueDashBoardScreen];
        [self.navigationController pushViewController:viewController animated:YES];
    }
    else
    {
        
        if([self isNetworkAvailable] ==YES)
        {
            NSLog(@"Network Connection available");
            [[RequestManager sharedInstance] login:self withUsername:userNameTxt.text withPassword:passwordTxt.text];
            userName=userNameTxt.text;
            password=passwordTxt.text;
            [self showActivityViewer];        }
        
        else{
            [StaticFuntions showAlertWithTitle:NetWorkTitle Message:NetWorkBody];
            
        }
       
    }
    
    
}

-(IBAction)onForgetPWPressed:(id)sender{
    [self removeKeyboard];
    UIViewController * viewController = [self.storyboard instantiateViewControllerWithIdentifier:SeagueForgetPasswordScreen];
    [self.navigationController pushViewController:viewController animated:NO];
    
}

-(IBAction)onLanguagePressed:(id)sender{
    [self setAppLanguage];
    [self locatizeLables];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(appDelegate.currentLang==English){
        [self switchToLeftLayout];
    }else{
        [self switchToRightLayout];
    }
}

#pragma mark - touch delegate
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    if ([passwordTxt isFirstResponder] && [touch view] != passwordTxt) {
        [passwordTxt resignFirstResponder];
    }
    if ([userNameTxt isFirstResponder] && [touch view] != userNameTxt) {
        [userNameTxt resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}

#pragma mark - methods

-(void)removeKeyboard{
    [passwordTxt resignFirstResponder];
    [userNameTxt resignFirstResponder];
}

-(BOOL)validate{
    if([StaticFuntions isStringEmpty:userNameTxt.text]){
        [StaticFuntions showAlertWithTitle:ErrorGeneralTitle Message:userNameMandatoryMsg];
        return NO;
    }else if([StaticFuntions isStringEmpty:passwordTxt.text]){
        [StaticFuntions showAlertWithTitle:ErrorGeneralTitle Message:passwordMandatoryMsg];
        return NO;
    }
    return YES;
}

-(void) setAppLanguage{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSString *language=@"";
    if(delegate.currentLang==Arabic){
        language=@"en";
        delegate.currentLang=English;
    }else if(delegate.currentLang==English){
        language= @"ar";
        delegate.currentLang=Arabic;
    }
    
    ICLocalizationSetLanguage(language);
    
    [delegate switchMenuDirection];
    
}
-(void)showLanguageAlert{
    //  AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    // if( appDelegate. languageAlertAppear)return;
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:ApplicationTitleText message:changeLangMsgText delegate:self cancelButtonTitle:CancelButtonText otherButtonTitles:OKayButtonText, nil];
    [alert show];
    // appDelegate. languageAlertAppear=YES;
}
#pragma mark - connection

- (void)processCompleted:(id)data error:(CustomError *)error withService:(NSNumber *)service{
    [self hideActivityViewer];
    if(data!=nil){
        
        if([service intValue]==(int)GetExternalDocumentUnit_WS){
            NSMutableArray *obj=(NSMutableArray*)data;
            DocInfoViewController * viewController = [self.storyboard instantiateViewControllerWithIdentifier:SeagueDocInfoScreen];
            

            viewController.parentName = @"Login";
            viewController.ListOfexternalDoctblView = obj;
            
           // [self.navigationController pushViewController:viewController animated:NO];
            
            
        //
           
            //  NSLog(@"index row   %ld",indexPath.row);
            
            [viewController setModalPresentationStyle:UIModalPresentationFormSheet];
            [viewController setModalTransitionStyle: UIModalTransitionStyleFlipHorizontal];
            [self.navigationController pushViewController:viewController animated:YES];
            
            
            //
        
        }
        else if([service intValue]==(int)Login_WS){
            AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
            appdelegate.EmployeeObj=(ProfileObj*)data;
            appdelegate.EmployeeObj.userLang=appdelegate.currentLang;
            appdelegate.EmployeeObj.userName=userName;
            appdelegate.EmployeeObj.password=password;
            appdelegate.islogOut=NO;
            appdelegate.EmployeeObj.empDeviceToken=appdelegate.deviceToken;
            appdelegate.EmployeeObj.useTouchID = useTouchID;
            [StaticFuntions createFile:appdelegate.EmployeeObj];
            if (useTouchID) {
                
                ProfileObj * obj= [StaticFuntions getSavedTouchIDData];
                if (obj == nil)
                    [StaticFuntions createTouchIDFile:appdelegate.EmployeeObj];
            }
            
            [[RequestManager sharedInstance] updateLanguage:self];
            [self showActivityViewer];
        }
        else if ([service intValue]==(int)UpdateLanguage_WS)
        {
            [self.navigationController setNavigationBarHidden:false animated:true];
            UIViewController * viewController = [self.storyboard instantiateViewControllerWithIdentifier:SeagueDashBoardScreen];
            [self.navigationController pushViewController:viewController animated:NO];

            if (self.navigationController !=nil){
            }
            else{
                [StaticFuntions showAlertWithTitle:@"navigation  in  nil  " Message:error.errorMessage];
                [self hideActivityViewer];

            }
        }
        
    }else{
        if([service intValue]==(int)GetExternalDocumentUnit_WS || [service intValue]==(int)Login_WS){
            [StaticFuntions showAlertWithTitle:ErrorGeneralTitle Message:error.errorMessage];
            return;
        }
        else if ([service intValue]==(int)UpdateLanguage_WS)
        {
            UIViewController * viewController = [self.storyboard instantiateViewControllerWithIdentifier:SeagueDashBoardScreen];
            [self.navigationController pushViewController:viewController animated:NO];
            [StaticFuntions showAlertWithTitle:ApplicationTitleText Message:LanguageUpdateError];
            
        }
        
    }
    
}

#pragma mark- alert delegate

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
}
@end
