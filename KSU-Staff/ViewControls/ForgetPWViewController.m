//
//  ForgetPWViewController.m
//  KSU-Staff
//
//  Created by EJ-Mac book on 11/26/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import "ForgetPWViewController.h"
#import "LocalizedMessages.h"
#import <QuartzCore/QuartzCore.h>
#import "StaticFuntions.h"
#import "RequestManager.h"


@interface ForgetPWViewController ()

@end

@implementation ForgetPWViewController

@synthesize usernameLbl,usernameTxt,usernameView;
@synthesize emailLbl,emailTxt,emailView;
@synthesize titleLbl;
@synthesize doneBtn,cancelBtn;

@synthesize controlsView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self customizeNavigationBar:NO WithMenu:NO];
 
    if(IS_IPAD){
        int x= (self.view.frame.size.width- controlsView.frame.size.width)/2;
        controlsView.frame=CGRectMake(x, controlsView.frame.origin.y, controlsView.frame.size.width, controlsView.frame.size.height);
    }
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
    /*AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
     if(appDelegate.currentLang==Arabic){
     
     }*/
    /// testing
   // [self dummyData];
    
    [self initBGViews];
}

-(void)locatizeLables{
    titleLbl.text=forgetPWLblText;
   /* usernameLbl.text= usernameLblText;
    emailLbl.text=AlterEmailText;*/
    
    UIColor *color = [UIColor colorWithRed:130.0/255.0 green:139.0/255.0 blue:147.0/255.0 alpha:1];

    if(isActiveCode){
        //[usernameTxt setPlaceholder:forgetPWVerifyText];
        usernameTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:forgetPWVerifyText attributes:@{NSForegroundColorAttributeName:color}];
        [doneBtn setTitle:VerifyButtonText forState:UIControlStateNormal];
    }else{
       // [usernameTxt setPlaceholder:usernameLblText];
         usernameTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:usernameLblText attributes:@{NSForegroundColorAttributeName:color}];
        [doneBtn setTitle:SendButtonText forState:UIControlStateNormal];
    }
    [cancelBtn setTitle:CancelButtonText forState:UIControlStateNormal];
    
    
}

-(void)switchToLeftLayout{
    
    NSTextAlignment align=NSTextAlignmentLeft;
    titleLbl.textAlignment=align;
    
    usernameLbl.textAlignment=align;
    emailLbl.textAlignment=align;
    
    usernameTxt.textAlignment=align;
    emailTxt.textAlignment=align;
    
    /*CGRect frame=usernameLbl.frame;
    frame.origin.x=5;
    usernameLbl.frame=frame;
    
    frame=emailLbl.frame;
    frame.origin.x=5;
    emailLbl.frame=frame;
    
    frame=usernameTxt.frame;
    frame.origin.x=111;
    usernameTxt.frame=frame;
    
    frame=emailTxt.frame;
    frame.origin.x=111;
    emailTxt.frame=frame;*/
}

-(void)switchToRightLayout{
    NSTextAlignment align=NSTextAlignmentRight;
    titleLbl.textAlignment=align;
    
    usernameLbl.textAlignment=align;
    emailLbl.textAlignment=align;
    
    usernameTxt.textAlignment=align;
    emailTxt.textAlignment=align;
    
   /* CGRect frame=usernameLbl.frame;
    frame.origin.x=180;
    usernameLbl.frame=frame;
    
    frame=emailLbl.frame;
    frame.origin.x=180;
    emailLbl.frame=frame;
    
    frame=usernameTxt.frame;
    frame.origin.x=5;
    usernameTxt.frame=frame;

    frame=emailTxt.frame;
    frame.origin.x=5;
    emailTxt.frame=frame;*/
}



#pragma mark - touch delegate
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    if ([emailTxt isFirstResponder] && [touch view] != emailTxt) {
        [emailTxt resignFirstResponder];
    }
    if ([usernameTxt isFirstResponder] && [touch view] != usernameTxt) {
        [usernameTxt resignFirstResponder];
    }
    
    [super touchesBegan:touches withEvent:event];
}

#pragma mark - events

-(IBAction)onDonePressed:(id)sender{
    [self hideKeyboard];
    if([self isNetworkAvailable] ==YES)
    {
        NSLog(@"Network Connection available");
        if(![self validate])return;
        
        [self connect];
    }
    
    else{
        [StaticFuntions showAlertWithTitle:NetWorkTitle Message:NetWorkBody];
        
    }
}
-(IBAction)onCancelPressed:(id)sender{
    [self hideKeyboard];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - methods

-(BOOL)validate{
    if([StaticFuntions isStringEmpty:usernameTxt.text]){
        if(isActiveCode)
            [StaticFuntions showAlertWithTitle:ErrorGeneralTitle Message:verifyCodeMandatoryFPMsg];
        else
            [StaticFuntions showAlertWithTitle:ErrorGeneralTitle Message:userNameMandatoryFPMsg];
        return NO;
    }/*else if([StaticFuntions isStringEmpty:emailTxt.text]){
        [StaticFuntions showAlertWithTitle:ErrorGeneralTitle Message:AlterEmailMandtoryMsg];
        return NO;
    }else if([StaticFuntions isValidMailAddress:emailTxt.text]){
        [StaticFuntions showAlertWithTitle:ErrorGeneralTitle Message:WrongMailFormatMessage];
        return NO;
    }*/
    return YES;
}
-(void)dummyData{
    
}

-(void)initBGViews{
    int radiusVal=5;
    emailView.layer.cornerRadius=radiusVal;
    usernameView.layer.cornerRadius=radiusVal;
    
    emailView.layer.borderWidth=0.5;
    usernameView.layer.borderWidth=0.5;
    
    emailView.layer.borderColor=[[UIColor grayColor] CGColor];
    usernameView.layer.borderColor=[[UIColor grayColor] CGColor];
}

-(void)hideKeyboard{
    [emailTxt resignFirstResponder];
    [usernameTxt resignFirstResponder];
    
}

-(void)connect{
    if(isActiveCode){
        [[RequestManager sharedInstance] forgetPWVerify:self withUserName:enteredUserName withVerificationCode:usernameTxt.text];
    }else
        [[RequestManager sharedInstance] forgetPW:self withUserName:usernameTxt.text];
    [self showActivityViewer];
}

#pragma mark - connection

- (void)processCompleted:(id)data error:(CustomError *)error withService:(NSNumber *)service{
    [self hideActivityViewer];
    if(data!=nil){
        if([service intValue]==(int)ForgetPassword_WS){
            [StaticFuntions showAlertWithTitle:ApplicationTitleText Message:verificationSendingMsg];
            isActiveCode=YES;
            enteredUserName=usernameTxt.text;
            usernameTxt.text=@"";
            [self locatizeLables];
            
        }else{
            [StaticFuntions showAlertWithTitle:ApplicationTitleText Message:forgetPWDoneMsg];
            [self onCancelPressed:nil];
        }
    }else{
        [StaticFuntions showAlertWithTitle:ErrorGeneralTitle Message:error.errorMessage];
    }
}

@end
