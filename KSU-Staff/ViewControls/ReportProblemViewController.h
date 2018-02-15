//
//  ReportProblemViewController.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 11/25/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import "BaseViewController.h"
#import "ReportProblemObj.h"
#import "DataTransfer.h"

@interface ReportProblemViewController : BaseViewController <UITextViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIActionSheetDelegate,DataTransferDelegate,UITextFieldDelegate>{
    
    UITextView *messageTxt;
    ReportProblemObj *reportObj;
    UILabel *titleLbl;
    UIButton *sendBtn;
    UILabel *messageLbl;
    
    UIImageView *captureImg;
    UIButton *attachBtn;
    
    UITextField *subjectTxt;
    UIView *subjectView;
    
    UIImage *problemImg;
}

@property (nonatomic) UIImagePickerController *imagePickerController;


@property(nonatomic,retain)IBOutlet UITextView *messageTxt;
@property(nonatomic,retain)IBOutlet UILabel *titleLbl;
@property(nonatomic,retain)IBOutlet UIButton *sendBtn;
@property(nonatomic,retain)IBOutlet UILabel *messageLbl;

@property(nonatomic,retain)IBOutlet UIImageView *captureImg;
@property(nonatomic,retain)IBOutlet UIButton *attachBtn;

@property(nonatomic,retain)IBOutlet UITextField *subjectTxt;
@property(nonatomic,retain)IBOutlet UIView *subjectView;

-(IBAction)onSendPressed:(id)sender;
-(IBAction)onAttachImg:(id)sender;

@end
