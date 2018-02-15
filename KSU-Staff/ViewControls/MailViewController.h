//
//  DelegationViewController.h
//  KSU_Students
//
//  Created by EJ-Mac book on 8/2/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "BaseViewController.h"
#import "DataTransfer.h"
#import "MailObj.h"


@interface MailViewController :  BaseViewController<UIGestureRecognizerDelegate,UITextFieldDelegate,UITextViewDelegate,DataTransferDelegate>{
    UILabel *titleLbl;
    UIButton *sendBtn;
    
    UIView *controlsView;
    
    
    UILabel *userNameLbl;
    UIView *userNameValView;
    UITextField *userNameValTxt;
    
    UILabel *mobileNumLbl;
    UIView *mobileNumValView;
    UITextField *mobileNumValTxt;
    
    UILabel *emailLbl;
    UIView *emailValView;
    UITextField *emailValTxt;
    
    UILabel *messageLbl;
    UIView *messageValView;
    UITextView *messageValTxt;
    
    MailObj *obj;
}
@property(nonatomic,retain) IBOutlet UILabel *titleLbl;
@property(nonatomic,retain) IBOutlet UIButton *sendBtn;

@property(nonatomic,retain) IBOutlet UIView *controlsView;


@property(nonatomic,retain) IBOutlet UILabel *userNameLbl;
@property(nonatomic,retain) IBOutlet UIView *userNameValView;
@property(nonatomic,retain) IBOutlet UITextField *userNameValTxt;

@property(nonatomic,retain) IBOutlet UILabel *mobileNumLbl;
@property(nonatomic,retain) IBOutlet UIView *mobileNumValView;
@property(nonatomic,retain) IBOutlet UITextField *mobileNumValTxt;

@property(nonatomic,retain) IBOutlet UILabel *emailLbl;
@property(nonatomic,retain) IBOutlet UIView *emailValView;
@property(nonatomic,retain) IBOutlet UITextField *emailValTxt;

@property(nonatomic,retain) IBOutlet UILabel *messageLbl;
@property(nonatomic,retain) IBOutlet UIView *messageValView;
@property(nonatomic,retain) IBOutlet UITextView *messageValTxt;

@property(nonatomic,retain) MailObj *obj;

-(BOOL)validate;
-(IBAction)onPressSend:(id)sender;

@end
