//
//  ChangePWViewController.m
//  KSU-Staff
//
//  Created by EJ-Mac book on 11/24/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import "ChangePWViewController.h"
#import "LocalizedMessages.h"
#import <QuartzCore/QuartzCore.h>
#import "RequestManager.h"
#import "AppDelegate.h"
#import "StaticFuntions.h"


@interface ChangePWViewController ()

@end

@implementation ChangePWViewController

@synthesize oldPassLbl,oldPassTxt,oldPassView;
@synthesize nPassLbl,nPassTxt,nPassView;
@synthesize confirmPassLbl,confirmPassTxt,confirmPassView;
@synthesize titleLbl,cancelBtn,doneBtn;
@synthesize controlsView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self customizeNavigationBar:YES WithMenu:YES];
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
    [self initBGViews];
}

-(void)locatizeLables{
    titleLbl.text=ChPwTitleText;
  /*  oldPassLbl.text= ChPwOldPwText;
    nPassLbl.text=ChPwNewPwText;
    confirmPassLbl.text=ChPwConfirmPWText;
    */
    
  /*  [oldPassTxt setPlaceholder:ChPwOldPwText];
    [nPassTxt setPlaceholder:ChPwNewPwText];
    [confirmPassTxt setPlaceholder:ChPwConfirmPWText];*/
    
    UIColor *color = [UIColor colorWithRed:130.0/255.0 green:139.0/255.0 blue:147.0/255.0 alpha:1];
    oldPassTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:ChPwOldPwText attributes:@{NSForegroundColorAttributeName:color}];
    nPassTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:ChPwNewPwText attributes:@{NSForegroundColorAttributeName:color}];
    confirmPassTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:ChPwConfirmPWText attributes:@{NSForegroundColorAttributeName:color}];
    
    [cancelBtn setTitle:CancelButtonText forState:UIControlStateNormal];
    [doneBtn setTitle:VerifyButtonText forState:UIControlStateNormal];
    
}

-(void)switchToLeftLayout{
    
    NSTextAlignment align=NSTextAlignmentLeft;
    titleLbl.textAlignment=align;
    
    oldPassLbl.textAlignment=align;
    nPassLbl.textAlignment=align;
    confirmPassLbl.textAlignment=align;
    
    oldPassTxt.textAlignment=align;
    nPassTxt.textAlignment=align;
    confirmPassTxt.textAlignment=align;
    
   /* CGRect frame=oldPassLbl.frame;
    frame.origin.x=5;
    oldPassLbl.frame=frame;
    nPassLbl.frame=frame;
    //confirmPassLbl.frame=frame;
    
    frame=confirmPassLbl.frame;
    frame.origin.x=5;
    confirmPassLbl.frame=frame;
    
    frame=oldPassTxt.frame;
    frame.origin.x=111;
    oldPassTxt.frame=frame;
    nPassTxt.frame=frame;
   // confirmPassTxt.frame=frame;
    
    frame=confirmPassTxt.frame;
    frame.origin.x=111;
    confirmPassTxt.frame=frame;*/

    
}

-(void)switchToRightLayout{
    NSTextAlignment align=NSTextAlignmentRight;
    titleLbl.textAlignment=align;
    
    oldPassLbl.textAlignment=align;
    nPassLbl.textAlignment=align;
    confirmPassLbl.textAlignment=align;
    
    oldPassTxt.textAlignment=align;
    nPassTxt.textAlignment=align;
    confirmPassTxt.textAlignment=align;
    
    /*CGRect frame=oldPassLbl.frame;
    frame.origin.x=180;
    oldPassLbl.frame=frame;
    nPassLbl.frame=frame;
    //confirmPassLbl.frame=frame;
    
    frame=confirmPassLbl.frame;
    frame.origin.x=180;
    confirmPassLbl.frame=frame;
    
    frame=oldPassTxt.frame;
    frame.origin.x=5;
    oldPassTxt.frame=frame;
    nPassTxt.frame=frame;
    //confirmPassTxt.frame=frame;
    
    frame=confirmPassTxt.frame;
    frame.origin.x=5;
    confirmPassTxt.frame=frame;
   */
}



#pragma mark - touch delegate
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    if ([oldPassTxt isFirstResponder] && [touch view] != oldPassTxt) {
        [oldPassTxt resignFirstResponder];
    }
    if ([nPassTxt isFirstResponder] && [touch view] != nPassTxt) {
        [nPassTxt resignFirstResponder];
    }
    
    if ([confirmPassTxt isFirstResponder] && [touch view] != confirmPassTxt) {
        [confirmPassTxt resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}

#pragma mark - events

-(IBAction)onDonePressed:(id)sender{
    [self hideKeyboard];
    
    
    if([self isNetworkAvailable] ==YES)
    {
        NSLog(@"Network Connection available");
        if([self validate])
            [self connect];    }
    
    else{
        [StaticFuntions showAlertWithTitle:NetWorkTitle Message:NetWorkBody];
        
    }
    
    
}
-(IBAction)onCancelPressed:(id)sender{
    [self hideKeyboard];
}

#pragma mark - methods

-(void)initBGViews{
    int radiusVal=5;
    oldPassView.layer.cornerRadius=radiusVal;
    nPassView.layer.cornerRadius=radiusVal;
    confirmPassView.layer.cornerRadius=radiusVal;
    
    oldPassView.layer.borderWidth=0.5;
    nPassView.layer.borderWidth=0.5;
    confirmPassView.layer.borderWidth=0.5;
    
    oldPassView.layer.borderColor=[[UIColor grayColor] CGColor];
    nPassView.layer.borderColor=[[UIColor grayColor] CGColor];
    confirmPassView.layer.borderColor=[[UIColor grayColor] CGColor];
}

-(void)hideKeyboard{
    [oldPassTxt resignFirstResponder];
    [nPassTxt resignFirstResponder];
    [confirmPassTxt resignFirstResponder];
}

-(void)connect{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [[RequestManager sharedInstance] changePassword:self forEmpNo:appDelegate.EmployeeObj.empNo withOldPassword:oldPassTxt.text withNewPassword:nPassTxt.text];
    [self showActivityViewer];
}

-(BOOL)validate{
    if([StaticFuntions isStringEmpty:oldPassTxt.text]){
        [StaticFuntions showAlertWithTitle:ErrorGeneralTitle Message:passwordMandatoryChMsg];
        return NO;
    }else if([StaticFuntions isStringEmpty:nPassTxt.text]){
        [StaticFuntions showAlertWithTitle:ErrorGeneralTitle Message:newPWMandatoryMsg];
        return NO;
    }else if([StaticFuntions isStringEmpty:confirmPassTxt.text]){
        [StaticFuntions showAlertWithTitle:ErrorGeneralTitle Message:confirmPWMandatoryMsg];
        return NO;
    }else if(nPassTxt.text.length<minPWLenght){
        [StaticFuntions showAlertWithTitle:ErrorGeneralTitle Message:PWminLenghtMsgText];
        return NO;
    }else if(![nPassTxt.text isEqualToString :confirmPassTxt.text]){
        [StaticFuntions showAlertWithTitle:ErrorGeneralTitle Message:confirmPW_notMatchMsg];
        return NO;
    }else if(![nPassTxt.text isEqualToString :confirmPassTxt.text]){
        [StaticFuntions showAlertWithTitle:ErrorGeneralTitle Message:confirmPW_notMatchMsg];
        return NO;
    }else if([nPassTxt.text isEqualToString :oldPassTxt.text]){
        [StaticFuntions showAlertWithTitle:ErrorGeneralTitle Message:confirmOldPWMatchMsg];
        return NO;
    }
    return YES;
}

#pragma mark - connection

- (void)processCompleted:(id)data error:(CustomError *)error withService:(NSNumber *)service{
    [self hideActivityViewer];
    if(error==nil){
        [StaticFuntions showAlertWithTitle:ApplicationTitleText Message:ChangePWDoneMsgText];
    
        UIViewController * viewController = [self.storyboard instantiateViewControllerWithIdentifier:SeagueDashBoardScreen];
        [self.navigationController pushViewController:viewController animated:NO];
    }else{
        [StaticFuntions showAlertWithTitle:ErrorGeneralTitle Message:error.errorMessage];
    }
}
@end
