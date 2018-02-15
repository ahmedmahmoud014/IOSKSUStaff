//
//  PageContentViewController.h
//  PageViewDemo
//
//  Created by Simon on 24/11/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestPageDetailsTableViewCell.h"

@protocol RequestPageDetailsViewControllerDelegate <NSObject>
@required
- (void)loadRowDetailsView:(NSMutableArray *)list;
@end

@interface RequestPageDetailsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,RequestPageDetailsTableViewCellDelegate>{

    UITableView *requestsTableView;
    NSMutableArray *listOfPageSections;
    NSMutableArray *rowsSectionArray;
    
    
}
@property(nonatomic,retain) IBOutlet UITableView *requestsTableView;
@property(nonatomic,retain) IBOutlet NSMutableArray *listOfPageSections;
@property(nonatomic,retain) IBOutlet NSMutableArray *rowsSectionArray;

@property NSUInteger pageIndex;
@property (assign) id<RequestPageDetailsViewControllerDelegate> delegation;

@end
