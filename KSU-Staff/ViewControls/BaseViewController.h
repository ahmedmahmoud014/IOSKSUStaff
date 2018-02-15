//
//  BaseViewController.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 9/17/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController{
    UIView *activityView;
    UIView *MenuView;
    UIImageView * _BGImage;
    UILabel *noDataLbl;
    UIRefreshControl* refreshControl;
}

@property (nonatomic, retain) IBOutlet UIImageView * BGImage;
@property (nonatomic, retain) IBOutlet UILabel *noDataLbl;

- (IBAction)onMenuButtonPressed:(id)sender;
- (void)customizeNavigationBar:(BOOL)withHome WithMenu:(BOOL)withMenu ;
- (void)initalizeViews;

-(void)showActivityViewer;
-(void)hideActivityViewer;
-(void)switchToRightLayout;
-(void)switchToLeftLayout;
-(void)locatizeLables;
-(BOOL)isNetworkAvailable;



- (IBAction)goBack:(id)sender ;
-(IBAction)onHomePressed:(id)sender;
- (void) hideMenuViewer;

-(void) refreshView;
-(void)logout;

- (void)refresh:(UIRefreshControl *)refreshControl_;
-(void)initRefreshControl:(UITableView*)tableView;

@end

