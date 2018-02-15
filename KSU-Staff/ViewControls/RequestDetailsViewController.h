//
//  RequestActionsViewController.h
//  KSU_Students
//
//  Created by EJ-Mac book on 8/2/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "BaseViewController.h"
#import "DataTransfer.h"
#import "RPageObj.h"
#import "RPageSectionObj.h"
#import "RPageSectionRowObj.h"
#import "HijriDateView.h"
#import "NewRequestDetailsViewController.h"
#import "RequestPageDetailsTableViewCell.h"


@interface RequestDetailsViewController :  BaseViewController<UIPageViewControllerDataSource,UIPageViewControllerDelegate,DataTransferDelegate, NewRequestDetailsViewControllerDelegate>{
    UILabel *titleLbl;
    UIView *controlsView;
    UIButton *viewBackBtn;
    
    NSMutableArray *listOfPages;
    NSMutableArray *listOfPageSections;

    
    UIView *backgroundView;
    UIView *detailsView;
    UITableView *rowDetailsTableView;
    NSMutableArray *listOfRowDetails;
    UIButton *detaislBackBtn;
    
    NSString *selectedRequest;
    UIImageView * noDataImg;
    
    UIPageViewController *pageController;
    NSInteger pageIndex;
    
    UIView *changePageView;
    UIButton *previousPageBtn;
    UILabel *currentPageLbl;
    UIButton *nextPageBtn;
    
}
@property(nonatomic,retain) IBOutlet UILabel *titleLbl;
@property(nonatomic,retain) IBOutlet UIView *controlsView;
@property(nonatomic,retain) IBOutlet UIButton *viewBackBtn;

@property(nonatomic,retain) NSMutableArray *listOfPages;
@property(nonatomic,retain) NSMutableArray *listOfPageSections;

@property(nonatomic,retain) IBOutlet UIView *backgroundView;
@property(nonatomic,retain) IBOutlet UIView *detailsView;
@property(nonatomic,retain) IBOutlet UITableView *rowDetailsTableView;
@property(nonatomic,retain) NSMutableArray *listOfRowDetails;
@property(nonatomic,retain) IBOutlet UIButton *detaislBackBtn;

@property(nonatomic,retain) NSString *selectedRequest;
@property(nonatomic,retain) IBOutlet UIImageView * noDataImg;

@property (strong, nonatomic) UIPageViewController *pageController;
@property (assign, nonatomic) NSInteger pageIndex;

@property(nonatomic,retain) IBOutlet UIView *changePageView;
@property(nonatomic,retain) IBOutlet UIButton *previousPageBtn;
@property(nonatomic,retain) IBOutlet UILabel *currentPageLbl;
@property(nonatomic,retain) IBOutlet UIButton *nextPageBtn;

-(IBAction)onPressBack:(id)sender;
//-(IBAction)onPressDetails:(id)sender;

@end
