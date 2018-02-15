//
//  ReportProblemViewController.m
//  KSU-Staff
//
//  Created by EJ-Mac book on 11/25/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import "ReportProblemViewController.h"
#import "LocalizedMessages.h"
#import <QuartzCore/QuartzCore.h>
#import "StaticFuntions.h"
#import "StaticVariables.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "RequestManager.h"

@interface ReportProblemViewController ()

@end

@implementation ReportProblemViewController
@synthesize titleLbl,messageTxt,sendBtn,messageLbl,captureImg,attachBtn;

@synthesize subjectTxt,subjectView;
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
    self.BGImage.image= [UIImage imageNamed:@"bg.png"];
    /*AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
     if(appDelegate.currentLang==Arabic){
     
     }*/
    [self initViews];
}

-(void)locatizeLables{
    titleLbl.text=MenuItemReportProbText;
    messageLbl.text= ItSupportMsgText;
    
    [sendBtn setTitle:SendButtonText forState:UIControlStateNormal];
    
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
        [self hideKeyborad];
    }if ([subjectTxt isFirstResponder] && [touch view] != subjectTxt) {
        [subjectTxt resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}

#pragma mark - events

-(IBAction)onSendPressed:(id)sender{
    [self hideKeyborad];
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

-(IBAction)onAttachImg:(id)sender{
    [self hideKeyborad];
    
    [self openActionSheet];
}

#pragma mark - methods

-(void)initViews{
    int radiusVal=5;
    messageTxt.layer.cornerRadius=radiusVal;
    messageTxt.layer.borderWidth=0.5;
    messageTxt.layer.borderColor=[[UIColor grayColor] CGColor];
    
    captureImg.layer.cornerRadius=radiusVal;
    captureImg.layer.borderWidth=0.5;
    captureImg.layer.borderColor=[[UIColor grayColor] CGColor];
    
    subjectView.layer.cornerRadius=radiusVal;
    subjectView.layer.borderWidth=0.5;
    subjectView.layer.borderColor=[[UIColor grayColor] CGColor];
}

-(void)hideKeyborad{
    BOOL flag=[messageTxt resignFirstResponder];
    [subjectTxt resignFirstResponder];
    if(!flag)return;
    
   /* [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationBeginsFromCurrentState:YES];
    if(SYSTEM_VERSION_LESS_THAN(@"7.0")){
        [self.messageTxt setFrame:CGRectMake(self.messageTxt.frame.origin.x, 126.0f, self.messageTxt.frame.size.width, self.messageTxt.frame.size.height)];
    }else{
        [self.messageTxt setFrame:CGRectMake(self.messageTxt.frame.origin.x, 126.0f, self.messageTxt.frame.size.width, self.messageTxt.frame.size.height)];
    }
    [UIView commitAnimations];*/
}

-(BOOL)validate{
    if([StaticFuntions isStringEmpty:subjectTxt.text]){
        [StaticFuntions showAlertWithTitle:ErrorGeneralTitle Message:ItSupportSubMandMSG];
        return NO;
    }
    if([StaticFuntions isStringEmpty:messageTxt.text]){
        [StaticFuntions showAlertWithTitle:ErrorGeneralTitle Message:ItSupportTextMandMSG];
        return NO;
    }
    if(problemImg==nil){
        [StaticFuntions showAlertWithTitle:ErrorGeneralTitle Message:ImageNeededMsgText];
        return NO;
    }
    return YES;
}

-(void) connect{
    [[RequestManager sharedInstance] itSupport:self withSubject:subjectTxt.text withText:messageTxt.text withImage:problemImg];
    [self showActivityViewer];
}


-(void) openCamera{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [StaticFuntions showAlertWithTitle:ErrorGeneralTitle Message:NoCameraMessage];
    }else   {
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            void(^blk)() =  ^() {
                UIImagePickerController* picker = [[UIImagePickerController alloc] init];
                picker.delegate = self;
                picker.allowsEditing = YES;
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                picker.cameraCaptureMode=UIImagePickerControllerCameraCaptureModePhoto;
                self.imagePickerController=picker;
                [self presentViewController:self.imagePickerController animated:YES completion:^{}];
                
                
            };
            
            // Make sure we have permission, otherwise request it first
            ALAssetsLibrary* assetsLibrary = [[ALAssetsLibrary alloc] init];
            ALAuthorizationStatus authStatus;
            if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"6.0"))
                authStatus = [ALAssetsLibrary authorizationStatus];
            else
                authStatus = ALAuthorizationStatusAuthorized;
            
            if (authStatus == ALAuthorizationStatusAuthorized) {
                blk();
            } else if (authStatus == ALAuthorizationStatusDenied || authStatus == ALAuthorizationStatusRestricted) {
                [StaticFuntions showAlertWithTitle:@"Grant photos permission" Message:@"Grant permission to your photos. Go to Settings App > Privacy > Photos."] ;
            } else if (authStatus == ALAuthorizationStatusNotDetermined) {
                [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                    // Catch the final iteration, ignore the rest
                    if (group == nil)
                        dispatch_async(dispatch_get_main_queue(), ^{
                            blk();
                        });
                    *stop = YES;
                } failureBlock:^(NSError *error) {
                    // failure :(
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [StaticFuntions showAlertWithTitle:@"Grant photos permission" Message:@"Grant permission to your photos. Go to Settings App > Privacy > Photos."] ;
                    });
                }];
            }
        }
    }

}
-(void)openPhotoLibrary{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        void(^blk)() =  ^() {
            UIImagePickerController* picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = YES;
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            self.imagePickerController=picker;
            [self presentViewController:self.imagePickerController animated:YES completion:^{}];
            
            
        };
        
        // Make sure we have permission, otherwise request it first
        ALAssetsLibrary* assetsLibrary = [[ALAssetsLibrary alloc] init];
        ALAuthorizationStatus authStatus;
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"6.0"))
            authStatus = [ALAssetsLibrary authorizationStatus];
        else
            authStatus = ALAuthorizationStatusAuthorized;
        
        if (authStatus == ALAuthorizationStatusAuthorized) {
            blk();
        } else if (authStatus == ALAuthorizationStatusDenied || authStatus == ALAuthorizationStatusRestricted) {
            [StaticFuntions showAlertWithTitle:@"Grant photos permission" Message:@"Grant permission to your photos. Go to Settings App > Privacy > Photos."] ;
        } else if (authStatus == ALAuthorizationStatusNotDetermined) {
            [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                // Catch the final iteration, ignore the rest
                if (group == nil)
                    dispatch_async(dispatch_get_main_queue(), ^{
                        blk();
                    });
                *stop = YES;
            } failureBlock:^(NSError *error) {
                // failure :(
                dispatch_async(dispatch_get_main_queue(), ^{
                    [StaticFuntions showAlertWithTitle:@"Grant photos permission" Message:@"Grant permission to your photos. Go to Settings App > Privacy > Photos."] ;
                });
            }];
        }
    }
}

-(void)openActionSheet{
    
    UIActionSheet * action= [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:CancelButtonText destructiveButtonTitle:nil otherButtonTitles:OpenCameraText,OpenPhotoLibText, nil];
    [action showInView:self.view];
}
#pragma mark - Image Picker Controller delegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    problemImg=chosenImage;
    [captureImg setImage:chosenImage];
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

#pragma mark- action sheet deletage

-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if(buttonIndex==0)
        [self openCamera];
    else if(buttonIndex==1)
        [self openPhotoLibrary];
}

#pragma mark - connection

- (void)processCompleted:(id)data error:(CustomError *)error withService:(NSNumber *)service{
    [self hideActivityViewer];
    if(data!=nil){
        [StaticFuntions showAlertWithTitle:ApplicationTitleText Message:ITSupportSuccMsgText];
        UIViewController * viewController = [self.storyboard instantiateViewControllerWithIdentifier:SeagueDashBoardScreen];
        [self.navigationController pushViewController:viewController animated:NO];
    }else{
        [StaticFuntions showAlertWithTitle:ErrorGeneralTitle Message:error.errorMessage];
    }
}

#pragma mark - text view delegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSUInteger newLength = [textView.text length] + [text length] - range.length;
    return (newLength > maxITSupportDescText) ? NO : YES;
    //return YES;
}

-(void) textViewDidBeginEditing:(UITextView *)textView{
    /*[UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationBeginsFromCurrentState:YES];
    if(SYSTEM_VERSION_LESS_THAN(@"7.0")){
        [self.messageTxt setFrame:CGRectMake(self.messageTxt.frame.origin.x, 59.0f, self.messageTxt.frame.size.width, self.messageTxt.frame.size.height)];
    }else{
        [self.messageTxt setFrame:CGRectMake(self.messageTxt.frame.origin.x, 59.0f, self.messageTxt.frame.size.width, self.messageTxt.frame.size.height)];
    }
    [UIView commitAnimations];*/
}

#pragma mark text field delegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return (newLength > maxITSupportSubjectText) ? NO : YES;
}
@end
