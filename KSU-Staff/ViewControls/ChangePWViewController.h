//
//  ChangePWViewController.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 11/24/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import "BaseViewController.h"
#import "ChangePW-Obj.h"
#import "DataTransfer.h"

@interface ChangePWViewController : BaseViewController<UITextFieldDelegate,DataTransferDelegate>{
    UILabel *oldPassLbl;
    UITextField *oldPassTxt;
    UIView *oldPassView;
    
    UILabel *nPassLbl;
    UITextField *nPassTxt;
    UIView *nPassView;
    
    UILabel *confirmPassLbl;
    UITextField *confirmPassTxt;
    UIView *confirmPassView;
    
    UILabel *titleLbl;
    
    UIButton *doneBtn;
    UIButton *cancelBtn;
    ChangePW_Obj *chObj;
     UIView *controlsView;
}

@property(nonatomic,retain) IBOutlet UILabel *oldPassLbl;
@property(nonatomic,retain) IBOutlet UITextField *oldPassTxt;
@property(nonatomic,retain) IBOutlet UIView *oldPassView;

@property(nonatomic,retain) IBOutlet UILabel *nPassLbl;
@property(nonatomic,retain) IBOutlet UITextField *nPassTxt;
@property(nonatomic,retain) IBOutlet UIView *nPassView;

@property(nonatomic,retain) IBOutlet UILabel *confirmPassLbl;
@property(nonatomic,retain) IBOutlet UITextField *confirmPassTxt;
@property(nonatomic,retain) IBOutlet UIView *confirmPassView;

@property(nonatomic,retain) IBOutlet UILabel *titleLbl;

@property(nonatomic,retain) IBOutlet UIButton *doneBtn;
@property(nonatomic,retain) IBOutlet UIButton *cancelBtn;

@property(nonatomic,retain) IBOutlet UIView *controlsView;

-(IBAction)onDonePressed:(id)sender;
-(IBAction)onCancelPressed:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *menuBtn;
@property (weak, nonatomic) IBOutlet UIButton *homeBtn;
- (IBAction)btnHomeOrMenuPress:(UIButton *)sender;

-(void) showMenu;
-(void) backHome;


@end
