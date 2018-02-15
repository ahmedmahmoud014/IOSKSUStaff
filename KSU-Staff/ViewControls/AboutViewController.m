//
//  AboutViewController.m
//  KSU-Staff
//
//  Created by EJ-Mac book on 11/19/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import "AboutViewController.h"
#import "LocalizedMessages.h"

@interface AboutViewController ()

@end

@implementation AboutViewController
@synthesize aboutLbl,abouttext;

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

#pragma mark - base class

-(void)initalizeViews{
}

-(void)locatizeLables{
    aboutLbl.text=MenuItemAboutText;
    abouttext.text=aboutTxtMsg;
}

-(void)switchToLeftLayout{
    abouttext.textAlignment=NSTextAlignmentLeft;
    aboutLbl.textAlignment=NSTextAlignmentLeft;
}

-(void)switchToRightLayout{
    abouttext.textAlignment=NSTextAlignmentRight;
     aboutLbl.textAlignment=NSTextAlignmentRight;
}
@end
