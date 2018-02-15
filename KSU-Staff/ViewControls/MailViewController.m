//
//  ScheduleViewController.m
//  KSU_Students
//
//  Created by EJ-Mac book on 8/2/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "MailViewController.h"
#import "AppDelegate.h"
#import "LocalizedMessages.h"
#import "StaticFuntions.h"
#import "RequestManager.h"

@interface MailViewController ()

@end

@implementation MailViewController

@synthesize titleLbl;
@synthesize sendBtn;
@synthesize controlsView;
@synthesize userNameLbl;
@synthesize userNameValView;
@synthesize userNameValTxt;
@synthesize mobileNumLbl;
@synthesize mobileNumValView;
@synthesize mobileNumValTxt;
@synthesize emailLbl;
@synthesize emailValView;
@synthesize emailValTxt;
@synthesize messageLbl;
@synthesize messageValView;
@synthesize messageValTxt;
@synthesize obj;



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self customizeNavigationBar:YES WithMenu:YES];

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

    noDataLbl.hidden=YES;
    
    [[userNameValView layer] setBorderColor:[[UIColor colorWithRed:(69/255.f) green:(69/255.f) blue:(69/255.f) alpha:0.5] CGColor]];
    [[userNameValView layer] setBorderWidth:0.5];
    [[userNameValView layer] setCornerRadius:2];
    
    
    [[mobileNumValView layer] setBorderColor:[[UIColor colorWithRed:(69/255.f) green:(69/255.f) blue:(69/255.f) alpha:0.5] CGColor]];
    [[mobileNumValView layer] setBorderWidth:0.5];
    [[mobileNumValView layer] setCornerRadius:2];

    [[emailValView layer] setBorderColor:[[UIColor colorWithRed:(69/255.f) green:(69/255.f) blue:(69/255.f) alpha:0.5] CGColor]];
    [[emailValView layer] setBorderWidth:0.5];
    [[emailValView layer] setCornerRadius:2];
    
    [[messageValView layer] setBorderColor:[[UIColor colorWithRed:(69/255.f) green:(69/255.f) blue:(69/255.f) alpha:0.5] CGColor]];
    [[messageValView layer] setBorderWidth:0.5];
    [[messageValView layer] setCornerRadius:2];
    
}

-(void)locatizeLables{
    
    titleLbl.text=MailTitleText;
    
    UIColor *color = [UIColor colorWithRed:130.0/255.0 green:139.0/255.0 blue:147.0/255.0 alpha:1];
    userNameValTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:EmailNameText attributes:@{NSForegroundColorAttributeName:color}];
    mobileNumValTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:MobileNumText attributes:@{NSForegroundColorAttributeName:color}];
    emailValTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:EmailText attributes:@{NSForegroundColorAttributeName:color}];
    messageValTxt.text = MessageText;
    messageValTxt.textColor = color;
    
    [userNameValTxt setReturnKeyType:UIReturnKeyNext];
    [mobileNumValTxt setReturnKeyType:UIReturnKeyNext];
    [emailValTxt setReturnKeyType:UIReturnKeyNext];
    [messageValTxt setReturnKeyType:UIReturnKeyDefault];
    
    [sendBtn setTitle:SendButtonText forState:UIControlStateNormal];
    
    titleLbl.adjustsFontSizeToFitWidth=YES;

}

-(void)switchToLeftLayout{
    
    titleLbl.textAlignment=NSTextAlignmentLeft;
    
    userNameLbl.textAlignment=NSTextAlignmentLeft;
    userNameValTxt.textAlignment=NSTextAlignmentLeft;
    
    mobileNumLbl.textAlignment=NSTextAlignmentLeft;
    mobileNumValTxt.textAlignment=NSTextAlignmentLeft;
    
    emailLbl.textAlignment=NSTextAlignmentLeft;
    emailValTxt.textAlignment=NSTextAlignmentLeft;
    
    messageLbl.textAlignment=NSTextAlignmentLeft;
    messageValTxt.textAlignment=NSTextAlignmentLeft;
    
    
    CGRect frame = titleLbl.frame;
    frame.origin.x = 8;
    titleLbl.frame = frame;
    
    frame = userNameLbl.frame;
    frame.origin.x = 8;
    userNameLbl.frame = frame;
    
    frame = userNameValView.frame;
    frame.origin.x = userNameLbl.frame.origin.x + userNameLbl.frame.size.width + 2;
    userNameValView.frame = frame;
    
    
    frame = mobileNumLbl.frame;
    frame.origin.x = 8;
    mobileNumLbl.frame = frame;
    
    frame = mobileNumValView.frame;
    frame.origin.x = mobileNumLbl.frame.origin.x + mobileNumLbl.frame.size.width + 2;
    mobileNumValView.frame = frame;
    
    frame = emailLbl.frame;
    frame.origin.x = 8;
    emailLbl.frame = frame;
    
    frame = emailValView.frame;
    frame.origin.x = emailLbl.frame.origin.x + emailLbl.frame.size.width + 2;
    emailValView.frame = frame;
    
    frame = messageLbl.frame;
    frame.origin.x = 8;
    messageLbl.frame = frame;
    
    frame = messageValView.frame;
    frame.origin.x = messageLbl.frame.origin.x + messageLbl.frame.size.width + 2;
    messageValView.frame = frame;
}

-(void)switchToRightLayout{
    
    
    sendBtn.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    sendBtn.titleLabel.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    sendBtn.imageView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    
    
    titleLbl.textAlignment=NSTextAlignmentRight;
    
    
    userNameLbl.textAlignment=NSTextAlignmentRight;
    userNameValTxt.textAlignment=NSTextAlignmentRight;
    
    mobileNumLbl.textAlignment=NSTextAlignmentRight;
    mobileNumValTxt.textAlignment=NSTextAlignmentRight;
    
    emailLbl.textAlignment=NSTextAlignmentRight;
    emailValTxt.textAlignment=NSTextAlignmentRight;
    
    messageLbl.textAlignment=NSTextAlignmentRight;
    messageValTxt.textAlignment=NSTextAlignmentRight;
    
    CGRect frame = titleLbl.frame;
    frame.origin.x = 8;
    titleLbl.frame = frame;
    
    frame = userNameValView.frame;
    frame.origin.x = 8;
    userNameValView.frame = frame;
    
    frame = userNameLbl.frame;
    frame.origin.x = userNameValView.frame.origin.x + userNameValView.frame.size.width + 2;
    userNameLbl.frame = frame;
    
    frame = mobileNumValView.frame;
    frame.origin.x = 8;
    mobileNumValView.frame = frame;
    
    frame = mobileNumLbl.frame;
    frame.origin.x = mobileNumValView.frame.origin.x + mobileNumValView.frame.size.width + 2;
    mobileNumLbl.frame = frame;
    
    
    frame = emailValView.frame;
    frame.origin.x = 8;
    emailValView.frame = frame;
    
    frame = emailLbl.frame;
    frame.origin.x = emailValView.frame.origin.x + emailValView.frame.size.width + 2;
    emailLbl.frame = frame;
    
    frame = messageValView.frame;
    frame.origin.x = 8;
    messageValView.frame = frame;
    
    frame = messageLbl.frame;
    frame.origin.x = messageValView.frame.origin.x + messageValView.frame.size.width + 2;
    messageLbl.frame = frame;
    
    
    
}

#pragma mark - touch delegate
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    if ([userNameValTxt isFirstResponder] && [touch view] != userNameValTxt) {
        [userNameValTxt resignFirstResponder];
    }
    if ([mobileNumValTxt isFirstResponder] && [touch view] != mobileNumValTxt) {
        [mobileNumValTxt resignFirstResponder];
    }
    if ([emailValTxt isFirstResponder] && [touch view] != emailValTxt) {
        [emailValTxt resignFirstResponder];
    }
    if ([messageValTxt isFirstResponder] && [touch view] != messageValTxt) {
        [messageValTxt resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}


#pragma mark - methods

-(BOOL)validate{
    
    if ([StaticFuntions isStringEmpty:userNameValTxt.text]) {
        [StaticFuntions showAlertWithTitle:@"" Message:NameMandatoryMsg];
        return NO;
    }else if ([StaticFuntions isStringEmpty:emailValTxt.text]) {
        [StaticFuntions showAlertWithTitle:@"" Message:emailMandatoryMsg];
        return NO;
    }else if (![self validateEmail]) {
        [StaticFuntions showAlertWithTitle:@"" Message:emailNotValidMsg];
        return NO;
    }
    else if ([StaticFuntions isStringEmpty:mobileNumValTxt.text]) {
        [StaticFuntions showAlertWithTitle:@"" Message:mobileNumMandatoryMsg];
        return NO;
    }else if (![self validatePhone]) {
        [StaticFuntions showAlertWithTitle:@"" Message:mobileNotValidMsg];
        return NO;
    }
    else if ([StaticFuntions isStringEmpty:messageValTxt.text] || [messageValTxt.text isEqualToString:MessageText]) {
        [StaticFuntions showAlertWithTitle:@"" Message:messageMandatoryMsg];
        return NO;
    }
    
    
    return YES;
}
-(BOOL)validateEmail
{
    BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
//    NSLog(@"Email is Valid? %d", [emailTest evaluateWithObject:emailValTxt.text]);
    return [emailTest evaluateWithObject:emailValTxt.text];
    
    
//    NSRegularExpression * regex = [NSRegularExpression regularExpressionWithPattern:
//                                   @"^[A-Z0-9a-z._%+-]+@([A-Za-z0-9.-]?)+\\.([A-Za-z]?)$" options:NSRegularExpressionCaseInsensitive error:nil];
//    if ([regex numberOfMatchesInString:emailValTxt.text options:0 range:NSMakeRange(0, [emailValTxt.text length])])
//        return YES;
//    
//    return NO;
    
}
-(BOOL)validatePhone
{
    ////NSRegularExpression * regex = [NSRegularExpression regularExpressionWithPattern:@"^(\\+)?\\d{0,15}$" options:NSRegularExpressionCaseInsensitive error:nil];
    
    if ([mobileNumValTxt.text length] < 9)
        return NO;
    NSRegularExpression * regex = [NSRegularExpression regularExpressionWithPattern:@"^([009665|9665|\\+9665|05])([0|1|3|4|5|6|7|8|9])([0-9]{0,14})$" options:NSRegularExpressionCaseInsensitive error:nil];

    if ([regex numberOfMatchesInString:mobileNumValTxt.text options:0 range:NSMakeRange(0, [mobileNumValTxt.text length])])
        return YES;
    
    return NO;
    
}

-(void)hideKeyboard{
    [userNameValTxt resignFirstResponder];
    [mobileNumValTxt resignFirstResponder];
    [emailValTxt resignFirstResponder];
    [messageValTxt resignFirstResponder];
}

-(void)connect{
    if ([self validate]) {
        obj = [[MailObj alloc] init];
        
        obj.userName = userNameValTxt.text;
        obj.mobileNum = mobileNumValTxt.text;
        obj.email = emailValTxt.text;
        obj.message = messageValTxt.text;
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [[RequestManager sharedInstance] sendMail:self withMailObj:obj forEmpNo:appDelegate.EmployeeObj.empNo];
        [self showActivityViewer];
    }
}





#pragma mark - connection

- (void)processCompleted:(id)data error:(CustomError *)error withService:(NSNumber *)service{
    [self hideActivityViewer];
    
    if(error==nil){
        [StaticFuntions showAlertWithTitle:ApplicationTitleText Message:(NSString*)data];
        UIViewController * viewController = [self.storyboard instantiateViewControllerWithIdentifier:SeagueDashBoardScreen];
        [self.navigationController pushViewController:viewController animated:NO];
    }else{
        [StaticFuntions showAlertWithTitle:ErrorGeneralTitle Message:error.errorMessage];
    }
}

#pragma mark - textview delegate

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSUInteger newLength = [textView.text length] + [text length] - range.length;
    return (newLength > maxMailMsgText) ? NO : YES;
}
-(void)textViewDidBeginEditing:(UITextView *)textView{
    
     if (textView == messageValTxt) {
         CGRect frame = userNameValView.frame;
         frame.origin.y -= 95;
         userNameValView.frame = frame;
         
         frame = mobileNumValView.frame;
         frame.origin.y -= 155;
         mobileNumValView.frame = frame;
         
         frame = emailValView.frame;
         frame.origin.y -= 115;
         emailValView.frame = frame;
         
         frame = messageValView.frame;
         frame.origin.y -= 115;
         messageValView.frame = frame;
         
     }
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    if (textView == messageValTxt) {
        CGRect frame = userNameValView.frame;
        frame.origin.y += 95;
        userNameValView.frame = frame;
        
        frame = mobileNumValView.frame;
        frame.origin.y += 155;
        mobileNumValView.frame = frame;
        
        frame = emailValView.frame;
        frame.origin.y += 115;
        emailValView.frame = frame;
        
        frame = messageValView.frame;
        frame.origin.y += 115;
        messageValView.frame = frame;
     }
}
- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:MessageText]) {
        textView.text = @"";
        messageValTxt.textColor = emailValTxt.textColor;
    }
    return YES;
}

- (BOOL) textViewShouldEndEditing:(UITextView *)textView
{
    if(textView.text.length == 0){
        textView.textColor = [UIColor colorWithRed:130.0/255.0 green:139.0/255.0 blue:147.0/255.0 alpha:1];
        textView.text = MessageText;
        [textView resignFirstResponder];
    }
    return YES;
}

#pragma mark - textfield delegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    
    if (textField == userNameValTxt)
        return (newLength > maxMailNameText) ? NO : YES;
  
    else if (textField == emailValTxt)
    {
        if (newLength <= maxMailEmailText) {
            NSRegularExpression * regex = [NSRegularExpression regularExpressionWithPattern:
                                           @"^[A-Z0-9a-z._%+-]+@?([A-Za-z0-9.-]?)+\\.?([A-Za-z]?)$" options:NSRegularExpressionCaseInsensitive error:nil];
            if ([regex numberOfMatchesInString:[NSString stringWithFormat:@"%@%@",textField.text,string] options:0 range:NSMakeRange(0, [textField.text length] + [string length])])
                return YES;
            
            return NO;
        }
        return NO;
        
    }
    else if (textField == mobileNumValTxt){
        NSRegularExpression * regex = [NSRegularExpression regularExpressionWithPattern:@"^([\\+9665]?)([0|1|3|4|5|6|7|8|9]?)([0-9]{0,14}?)$" options:NSRegularExpressionCaseInsensitive error:nil];
        if ([regex numberOfMatchesInString:[NSString stringWithFormat:@"%@%@",textField.text,string] options:0 range:NSMakeRange(0, [textField.text length] + [string length])])
            return YES;
        return NO;
    }
    else
        return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == userNameValTxt) {
        [mobileNumValTxt becomeFirstResponder];
    }else if (textField == mobileNumValTxt) {
        [emailValTxt becomeFirstResponder];
    }else if (textField == emailValTxt) {
        [messageValTxt becomeFirstResponder];
    }
    
    
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    textField.placeholder = @"";
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    UIColor *color = [UIColor colorWithRed:130.0/255.0 green:139.0/255.0 blue:147.0/255.0 alpha:1];
    userNameValTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:EmailNameText attributes:@{NSForegroundColorAttributeName:color}];
    mobileNumValTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:MobileNumText attributes:@{NSForegroundColorAttributeName:color}];
    emailValTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:EmailText attributes:@{NSForegroundColorAttributeName:color}];
}


#pragma mark - events

-(IBAction)onPressSend:(id)sender
{
    [self hideKeyboard];
    if([self isNetworkAvailable] ==YES)
    {
        NSLog(@"Network Connection available");
        [self connect];
    }
    
    else{
        [StaticFuntions showAlertWithTitle:NetWorkTitle Message:NetWorkBody];
        
    }
    
}


@end
