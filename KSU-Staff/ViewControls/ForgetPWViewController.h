//
//  ForgetPWViewController.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 11/26/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import "BaseViewController.h"
#import "ForgetPWObj.h"
#import "DataTransfer.h"

@interface ForgetPWViewController : BaseViewController <UITextFieldDelegate,DataTransferDelegate>{
    UILabel *usernameLbl;
    UITextField *usernameTxt;
    UIView *usernameView;
    
    UILabel *emailLbl;
    UITextField *emailTxt;
    UIView *emailView;
    
    UILabel *titleLbl;
    
    UIButton *doneBtn;
    UIButton *cancelBtn;
    ForgetPWObj *FPWObj;
    bool isActiveCode;
    NSString *enteredUserName;
    UIView *controlsView;
}

@property(nonatomic,retain) IBOutlet UILabel *usernameLbl;
@property(nonatomic,retain) IBOutlet UITextField *usernameTxt;
@property(nonatomic,retain) IBOutlet UIView *usernameView;

@property(nonatomic,retain) IBOutlet UILabel *emailLbl;
@property(nonatomic,retain) IBOutlet UITextField *emailTxt;
@property(nonatomic,retain) IBOutlet UIView *emailView;

@property(nonatomic,retain) IBOutlet UILabel *titleLbl;

@property(nonatomic,retain) IBOutlet UIButton *doneBtn;
@property(nonatomic,retain) IBOutlet UIButton *cancelBtn;

@property(nonatomic,retain) IBOutlet UIView *controlsView;

-(IBAction)onDonePressed:(id)sender;
-(IBAction)onCancelPressed:(id)sender;


@end
