//
//  EditProfileViewController.m
//  KSU-Staff
//
//  Created by EJ-Mac book on 11/19/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import "EditProfileViewController.h"
#import "LocalizedMessages.h"
#import <QuartzCore/QuartzCore.h>


@interface EditProfileViewController ()

@end

@implementation EditProfileViewController
@synthesize mobileLbl,mobileView,mobileTxt;
@synthesize websiteLbl,websiteTxt,websiteView;
@synthesize emailLbl,emailTxt,emailView;
@synthesize telLbl,telTxt,telView;
@synthesize titleLbl;
@synthesize doneBtn,cancelBtn;

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
    /// testing
    [self dummyData];
    [self initBGViews];
}

-(void)locatizeLables{
    titleLbl.text=MenuItemEditProfileText;
    mobileLbl.text= MobNoText;
    telLbl.text=TelNoText;
    emailLbl.text=AlterEmailText;
    websiteLbl.text=webSiteText;
    
    [cancelBtn setTitle:CancelButtonText forState:UIControlStateNormal];
    
    [doneBtn setTitle:DoneButtonText forState:UIControlStateNormal];
    
}

-(void)switchToLeftLayout{
    
    NSTextAlignment align=NSTextAlignmentLeft;
    titleLbl.textAlignment=align;
    
    telLbl.textAlignment=align;
    mobileLbl.textAlignment=align;
    emailLbl.textAlignment=align;
    websiteLbl.textAlignment=align;
    
    telTxt.textAlignment=align;
    mobileTxt.textAlignment=align;
    emailTxt.textAlignment=align;
    websiteTxt.textAlignment=align;
    
    CGRect frame=telLbl.frame;
    frame.origin.x=5;
    telLbl.frame=frame;
    mobileLbl.frame=frame;
    
    frame=emailLbl.frame;
    frame.origin.x=5;
    emailLbl.frame=frame;
   
    frame=websiteLbl.frame;
    frame.origin.x=5;
    websiteLbl.frame=frame;
    
    frame=telTxt.frame;
    frame.origin.x=111;
    telTxt.frame=frame;
    mobileTxt.frame=frame;
    
    frame=emailTxt.frame;
    frame.origin.x=111;
    emailTxt.frame=frame;

    frame=websiteTxt.frame;
    frame.origin.x=111;
    websiteTxt.frame=frame;
    
}

-(void)switchToRightLayout{
    NSTextAlignment align=NSTextAlignmentRight;
    titleLbl.textAlignment=align;
    
    telLbl.textAlignment=align;
    mobileLbl.textAlignment=align;
    emailLbl.textAlignment=align;
    websiteLbl.textAlignment=align;
    
    telTxt.textAlignment=align;
    mobileTxt.textAlignment=align;
    emailTxt.textAlignment=align;
    websiteTxt.textAlignment=align;
    
    CGRect frame=telLbl.frame;
    frame.origin.x=180;
    telLbl.frame=frame;
    mobileLbl.frame=frame;
    
    frame=websiteLbl.frame;
    frame.origin.x=180;
    websiteLbl.frame=frame;
    
    frame=emailLbl.frame;
    frame.origin.x=180;
    emailLbl.frame=frame;
    
    frame=telTxt.frame;
    frame.origin.x=5;
    telTxt.frame=frame;
    mobileTxt.frame=frame;
    websiteTxt.frame=frame;
   
    frame=emailTxt.frame;
    frame.origin.x=5;
    emailTxt.frame=frame;
    
    frame=websiteTxt.frame;
    frame.origin.x=5;
    websiteTxt.frame=frame;

}



#pragma mark - touch delegate
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    if ([emailTxt isFirstResponder] && [touch view] != emailTxt) {
        [emailTxt resignFirstResponder];
    }
    if ([mobileTxt isFirstResponder] && [touch view] != mobileTxt) {
        [mobileTxt resignFirstResponder];
    }
    
    if ([telTxt isFirstResponder] && [touch view] != telTxt) {
        [telTxt resignFirstResponder];
    }
    
    if ([websiteTxt isFirstResponder] && [touch view] != websiteTxt) {
        [websiteTxt resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}

#pragma mark - events

-(IBAction)onDonePressed:(id)sender{
    [self hideKeyboard];
}
-(IBAction)onCancelPressed:(id)sender{
    [self hideKeyboard];
}

#pragma mark - methods

-(void)dummyData{
    edObj=[[EditProfileObj alloc] init];
    edObj.email=@"test@test.com";
    edObj.website=@"www.test.com";
    edObj.telephone=@"234567";
    edObj.mobile=@"123456789";
    
    mobileTxt.text=edObj.mobile;
    emailTxt.text=edObj.email;
    websiteTxt.text=edObj.website;
    telTxt.text=edObj.telephone;

}
-(void)initBGViews{
    int radiusVal=5;
    emailView.layer.cornerRadius=radiusVal;
    mobileView.layer.cornerRadius=radiusVal;
    telView.layer.cornerRadius=radiusVal;
    websiteView.layer.cornerRadius=radiusVal;
    
    emailView.layer.borderWidth=0.5;
    mobileView.layer.borderWidth=0.5;
    telView.layer.borderWidth=0.5;
    websiteView.layer.borderWidth=0.5;
    
    emailView.layer.borderColor=[[UIColor grayColor] CGColor];
    mobileView.layer.borderColor=[[UIColor grayColor] CGColor];
    telView.layer.borderColor=[[UIColor grayColor] CGColor];
    websiteView.layer.borderColor=[[UIColor grayColor] CGColor];
}

-(void)hideKeyboard{
    [emailTxt resignFirstResponder];
    [websiteTxt resignFirstResponder];
    [telTxt resignFirstResponder];
    [mobileTxt resignFirstResponder];
}

@end
