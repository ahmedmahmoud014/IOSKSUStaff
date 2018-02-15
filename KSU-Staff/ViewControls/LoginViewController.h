//
//  LoginViewController.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 9/18/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import "BaseViewController.h"
#import "DataTransfer.h"

@interface LoginViewController : BaseViewController<UITextFieldDelegate,DataTransferDelegate,UIAlertViewDelegate>{
  
    UITextField *userNameTxt;
    UITextField *passwordTxt;
    
    UIImageView *userNameImg;
    UIImageView *passwordImg;
    
    UIButton *loginBtn;
    UIButton *forgetPWBtn;
    
    UIButton *langBtn;
    UIView *controlsView;
    UIView *docInfoView;
    
    UIButton *tochIDCheckBoxBtn;
    UIButton *tochIDBtn;
    BOOL useTouchID;
    
    NSString *userName;
    NSString *password;
    
    UIButton *docInfoImgBtn;
    UIButton *docInfoBtn;
    UINavigationController * TESTNAV;
    UIStoryboard * TESTStory;

}

@property (nonatomic,retain) IBOutlet UITextField *userNameTxt;
@property (nonatomic,retain) IBOutlet UITextField *passwordTxt;

@property (nonatomic,retain) IBOutlet UIImageView *userNameImg;
@property (nonatomic,retain) IBOutlet UIImageView *passwordImg;

@property (nonatomic,retain) IBOutlet UIButton *loginBtn;
@property (nonatomic,retain) IBOutlet UIButton *forgetPWBtn;

@property (nonatomic,retain) IBOutlet UIButton *langBtn;

@property (nonatomic,retain) IBOutlet UIView *controlsView;
@property (nonatomic, retain) IBOutlet UIView *docInfoView;

@property (nonatomic,retain) IBOutlet UIButton *tochIDCheckBoxBtn;
@property (nonatomic,retain) IBOutlet UIButton *tochIDBtn;
@property (nonatomic) BOOL useTouchID;
@property (nonatomic)  UINavigationController * TESTNAV;
@property (nonatomic)  UIStoryboard * TESTStory;


@property (nonatomic,retain) NSString *userName;
@property (nonatomic,retain) NSString *password;

@property (nonatomic,retain) IBOutlet UIButton *docInfoImgBtn;
@property (nonatomic,retain) IBOutlet UIButton *docInfoBtn;


-(IBAction)onFingerPrintPressed:(id)sender;
-(IBAction)onLoginPressed:(id)sender;
-(IBAction)onForgetPWPressed:(id)sender;

-(IBAction)onLanguagePressed:(id)sender;
@end
