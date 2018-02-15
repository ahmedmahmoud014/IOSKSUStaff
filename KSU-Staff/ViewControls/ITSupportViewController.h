//
//  ITSupportViewController.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 11/24/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import "BaseViewController.h"
#import "ITSupportObj.h"
#import "DataTransfer.h"

@interface ITSupportViewController : BaseViewController <UITextViewDelegate,DataTransferDelegate,UITextFieldDelegate>{
    UITextView *messageTxt;
    ITSupportObj *itSubObj;
    UILabel *titleLbl;
    UIButton *sendBtn;
    UILabel *messageLbl;
    UITextField *subjectTxt;
    UIView *subjectView;
    UIView *controlsView;
}

@property(nonatomic,retain)IBOutlet UITextView *messageTxt;
@property(nonatomic,retain)IBOutlet UILabel *titleLbl;
@property(nonatomic,retain)IBOutlet UIButton *sendBtn;
@property(nonatomic,retain)IBOutlet UILabel *messageLbl;
@property(nonatomic,retain)IBOutlet UITextField *subjectTxt;
@property(nonatomic,retain)IBOutlet UIView *subjectView;

@property(nonatomic,retain) IBOutlet UIView *controlsView;

-(IBAction)onSendPressed:(id)sender;
@end
