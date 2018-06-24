//
//  ITSupportViewController.m
//  KSU-Staff
//
//  Created by EJ-Mac book on 11/24/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import "ITSupportViewController.h"
#import "LocalizedMessages.h"
#import <QuartzCore/QuartzCore.h>
#import "StaticFuntions.h"
#import "RequestManager.h"
#import "AppDelegate.h"


@interface ITSupportViewController ()

@end

@implementation ITSupportViewController
@synthesize titleLbl,messageTxt,sendBtn,messageLbl;
@synthesize subjectTxt,subjectView;
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
    [self initTextview];
}

-(void)locatizeLables{
    titleLbl.text=MenuItemSupportText;
    messageLbl.text= ItSupportMsgText;
    
    [sendBtn setTitle:SendButtonText forState:UIControlStateNormal];
    //[subjectTxt setPlaceholder:ItSupportSubjText];
    
    UIColor *color = [UIColor colorWithRed:130.0/255.0 green:139.0/255.0 blue:147.0/255.0 alpha:1];
    subjectTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:ItSupportSubjText attributes:@{NSForegroundColorAttributeName:color}];
}

-(void)switchToLeftLayout{
    NSTextAlignment align=NSTextAlignmentLeft;
    titleLbl.textAlignment=align;
    messageTxt.textAlignment=align;
    messageLbl.textAlignment=align;
    subjectTxt.textAlignment=align;
}

-(void)switchToRightLayout{
    NSTextAlignment align=NSTextAlignmentRight;
    titleLbl.textAlignment=align;
    messageTxt.textAlignment=align;
    messageLbl.textAlignment=align;
    subjectTxt.textAlignment=align;

}



#pragma mark - touch delegate
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    if ([messageTxt isFirstResponder] && [touch view] != messageTxt) {
      //  [messageTxt resignFirstResponder];
        [self hideKeyboard];
    }if ([subjectTxt isFirstResponder] && [touch view] != subjectTxt) {
        [subjectTxt resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}

#pragma mark - events

-(IBAction)onSendPressed:(id)sender{
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

#pragma mark - methods

-(void)initTextview{
    int radiusVal=5;
    messageTxt.layer.cornerRadius=radiusVal;
    messageTxt.layer.borderWidth=0.5;
    messageTxt.layer.borderColor=[[UIColor grayColor] CGColor];
    
    
    subjectView.layer.cornerRadius=radiusVal;
    subjectView.layer.borderWidth=0.5;
    subjectView.layer.borderColor=[[UIColor grayColor] CGColor];

}

-(void)hideKeyboard{
    BOOL flag=[messageTxt resignFirstResponder];
    [subjectTxt resignFirstResponder];
    if(!flag)return;
    if(IS_IPAD)return;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationBeginsFromCurrentState:YES];
    if(SYSTEM_VERSION_LESS_THAN(@"7.0")){
        [self.messageTxt setFrame:CGRectMake(self.messageTxt.frame.origin.x, 75.0f/*135.0f*/, self.messageTxt.frame.size.width, self.messageTxt.frame.size.height)];
    }else{
        [self.messageTxt setFrame:CGRectMake(self.messageTxt.frame.origin.x, 75.0f/*135.0f*/, self.messageTxt.frame.size.width, self.messageTxt.frame.size.height)];
    }
    [UIView commitAnimations];
}

-(BOOL)validate{
    if([StaticFuntions isStringEmpty:subjectTxt.text]){
        [StaticFuntions showAlertWithTitle:@"" Message:ItSupportSubMandMSG];
        return NO;
    }
    if([StaticFuntions isStringEmpty:messageTxt.text]){
        [StaticFuntions showAlertWithTitle:@"" Message:ItSupportTextMandMSG];
        return NO;
    }
    return YES;
}

-(void) connect{
    [[RequestManager sharedInstance] itSupport:self withSubject:subjectTxt.text withText:messageTxt.text withImage:nil];
    [self showActivityViewer];
}
#pragma mark - connection

- (void)processCompleted:(id)data error:(CustomError *)error withService:(NSNumber *)service{
    [self hideActivityViewer];
    if(data!=nil){
        [StaticFuntions showAlertWithTitle:ApplicationTitleText Message:ITSupportSuccMsgText];
        UIViewController * viewController = [self.storyboard instantiateViewControllerWithIdentifier:SeagueDashBoardScreen];
        [self.navigationController pushViewController:viewController animated:NO];
    }else{
        [StaticFuntions showAlertWithTitle:@""
                                Message:error.errorMessage];
    }
}

#pragma mark - text view delegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSUInteger newLength = [textView.text length] + [text length] - range.length;
    return (newLength > maxITSupportDescText) ? NO : YES;
    //return YES;
}


-(void) textViewDidBeginEditing:(UITextView *)textView{
    if(IS_IPAD)return;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationBeginsFromCurrentState:YES];
    if(SYSTEM_VERSION_LESS_THAN(@"7.0")){
        [self.messageTxt setFrame:CGRectMake(self.messageTxt.frame.origin.x, 5.0f /*65.0f*/, self.messageTxt.frame.size.width, self.messageTxt.frame.size.height)];
    }else{
        [self.messageTxt setFrame:CGRectMake(self.messageTxt.frame.origin.x,  5.0f /*65.0f*/, self.messageTxt.frame.size.width, self.messageTxt.frame.size.height)];
    }
    [UIView commitAnimations];
}

#pragma mark text field delegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return (newLength > maxITSupportSubjectText) ? NO : YES;
}
@end
