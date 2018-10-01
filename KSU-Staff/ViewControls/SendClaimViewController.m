//
//  SendClaimViewController.m
//  KSU-Staff
//
//  Created by EJ-Mac book on 1/28/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "SendClaimViewController.h"
#import "AppDelegate.h"
#import "StaticFuntions.h"
#import "LocalizedMessages.h"
#import "RequestManager.h"
#import "AppDelegate.h"


@interface SendClaimViewController ()

@end

@implementation SendClaimViewController
@synthesize titleLbl,cancelBtn,claimLbl,claimTxt,sendBtn;
@synthesize controlsView;
UILabel * lbl;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self customizeNavigationBar:YES WithMenu:YES];
    
    // navigation  button  replace
    [self replaceHomeAndMenu:_homeBtn :_menuBtn];
    if(IS_IPAD){
        int x= (self.view.frame.size.width- controlsView.frame.size.width)/2;
        controlsView.frame=CGRectMake(x, controlsView.frame.origin.y, controlsView.frame.size.width, controlsView.frame.size.height);
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:true animated:animated];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
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
    
   
}
    


-(void)locatizeLables{
    titleLbl.text=sendClaimTitleTxt;
    claimLbl.text=sendClaimLblTxt;
   // claimTxt.text = salaryClaim;
    
    
 lbl = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 0.0,claimTxt.frame.size.width - 10.0, 34.0)];
    [lbl setText:salaryClaim];
    [lbl setBackgroundColor:[UIColor clearColor]];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(appDelegate.currentLang==English ){
        lbl.textAlignment = NSTextAlignmentLeft;

    }
    else {
        lbl.textAlignment = NSTextAlignmentRight;
    }
    [lbl setTextColor:[UIColor lightGrayColor]];
    lbl.numberOfLines = 0;
    [lbl sizeToFit];
    claimTxt.delegate = self;
    [claimTxt addSubview:lbl];

    [sendBtn setTitle:SendButtonText forState:UIControlStateNormal];
    [cancelBtn setTitle:CancelButtonText forState:UIControlStateNormal];
    
}

- (void)textViewDidEndEditing:(UITextView *) textView
{
    if (![textView hasText]) {
        lbl.hidden = NO;
    }
}

- (void) textViewDidChange:(UITextView *)textView
{
    if(![textView hasText]) {
        lbl.hidden = NO;
    }
    else{
        lbl.hidden = YES;
    }
}

-(void)switchToLeftLayout{
    
    titleLbl.textAlignment=NSTextAlignmentLeft;
    claimLbl.textAlignment=NSTextAlignmentLeft;
    claimTxt.textAlignment=NSTextAlignmentLeft;
    
}

-(void)switchToRightLayout{
    
    titleLbl.textAlignment=NSTextAlignmentRight;
    claimLbl.textAlignment=NSTextAlignmentRight;
    claimTxt.textAlignment=NSTextAlignmentRight;
}

#pragma mark - methods

-(void)connect{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
     [[RequestManager sharedInstance] sendClaim:self forEmpNo:appDelegate.EmployeeObj.empNo withText:claimTxt.text];
     [self showActivityViewer];
}

-(BOOL)validate{
    if([StaticFuntions isStringEmpty:claimTxt.text]){
        [StaticFuntions showAlertWithTitle:@"" Message:sendClaimValidateMsgTxt];
        return NO;
    }
    return YES;
}

#pragma mark - connection

- (void)processCompleted:(id)data error:(CustomError *)error withService:(NSNumber *)service{
    [self hideActivityViewer];
    if(error==nil){
        [StaticFuntions showAlertWithTitle:ApplicationTitleText Message:sendClaimDoneMsgTxt];
        [self onCancelPressed:nil];
    }else{
        [StaticFuntions showAlertWithTitle:ErrorGeneralTitle Message:error.errorMessage];
    }
}

#pragma mark - events

-(IBAction)onSendPressed:(id)sender{
    [claimTxt resignFirstResponder];
    
    
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
    [claimTxt resignFirstResponder];
    
//    UIViewController * viewController = [self.storyboard instantiateViewControllerWithIdentifier:SeagueSalaryScreen];
//    [self moveToNext:viewController];
}


#pragma mark - touch delegate
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    
//    UITouch *touch = [[event allTouches] anyObject];
//    if ([claimTxt isFirstResponder] && [touch view] != claimTxt) {
//        [claimTxt resignFirstResponder];
//    }
//    [super touchesBegan:touches withEvent:event];
//}

#pragma mark - text view delegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSUInteger newLength = [textView.text length] + [text length] - range.length;
    return (newLength > maxClaimMsgText) ? NO : YES;
    //return YES;
}


//navigation bar

- (IBAction)btnHomeOrMenuPress:(UIButton *)sender {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UIButton *button = (UIButton *)sender;
    NSInteger *tag  =  [button tag];
    // menu button
    if (tag ==  0 )  {
        
        if(appDelegate.currentLang==Arabic)
        {
            [self showMenu];
        }else{
            [self  backHome];
        }
        
        
        
    }
    // home button
    else {
        if(appDelegate.currentLang==Arabic)
        {
            [self  backHome];
        }else{
            [self showMenu];
        }
        
    }
}
@end
