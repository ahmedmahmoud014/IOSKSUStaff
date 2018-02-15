//
//  SendClaimViewController.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 1/28/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "BaseViewController.h"
#import "DataTransfer.h"

@interface SendClaimViewController : BaseViewController<DataTransferDelegate,UITextViewDelegate>{
    UILabel *titleLbl;
    UITextView *claimTxt;
    UILabel *claimLbl;
    UIButton *sendBtn;
    UIButton *cancelBtn;
    UIView *controlsView;
}

@property(nonatomic,retain) IBOutlet UILabel *titleLbl;
@property(nonatomic,retain) IBOutlet UITextView *claimTxt;
@property(nonatomic,retain) IBOutlet UILabel *claimLbl;
@property(nonatomic,retain) IBOutlet UIButton *sendBtn;
@property(nonatomic,retain) IBOutlet UIButton *cancelBtn;
@property(nonatomic,retain) IBOutlet UIView *controlsView;


-(IBAction)onSendPressed:(id)sender;
-(IBAction)onCancelPressed:(id)sender;

@end
