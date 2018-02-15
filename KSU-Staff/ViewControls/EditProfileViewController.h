//
//  EditProfileViewController.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 11/19/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import "BaseViewController.h"
#import "EditProfileObj.h"

@interface EditProfileViewController : BaseViewController <UITextFieldDelegate>{
    UILabel *mobileLbl;
    UITextField *mobileTxt;
    UIView *mobileView;
    
    UILabel *telLbl;
    UITextField *telTxt;
    UIView *telView;
    
    UILabel *emailLbl;
    UITextField *emailTxt;
    UIView *emailView;
    
    UILabel *websiteLbl;
    UITextField *websiteTxt;
    UIView *websiteView;
    
    UILabel *titleLbl;
    
    UIButton *doneBtn;
    UIButton *cancelBtn;
    EditProfileObj *edObj;
}

@property(nonatomic,retain) IBOutlet UILabel *mobileLbl;
@property(nonatomic,retain) IBOutlet UITextField *mobileTxt;
@property(nonatomic,retain) IBOutlet UIView *mobileView;

@property(nonatomic,retain) IBOutlet UILabel *telLbl;
@property(nonatomic,retain) IBOutlet UITextField *telTxt;
@property(nonatomic,retain) IBOutlet UIView *telView;

@property(nonatomic,retain) IBOutlet UILabel *emailLbl;
@property(nonatomic,retain) IBOutlet UITextField *emailTxt;
@property(nonatomic,retain) IBOutlet UIView *emailView;

@property(nonatomic,retain) IBOutlet UILabel *websiteLbl;
@property(nonatomic,retain) IBOutlet UITextField *websiteTxt;
@property(nonatomic,retain) IBOutlet UIView *websiteView;

@property(nonatomic,retain) IBOutlet UILabel *titleLbl;

@property(nonatomic,retain) IBOutlet UIButton *doneBtn;
@property(nonatomic,retain) IBOutlet UIButton *cancelBtn;

-(IBAction)onDonePressed:(id)sender;
-(IBAction)onCancelPressed:(id)sender;

@end
