//
//  NewRequestDetailsViewController.h
//  KSU-Staff
//
//  Created by Eman Kassem on 12/3/16.
//  Copyright © 2016 E-Jawdah. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NewRequestDetailsViewControllerDelegate <NSObject>

@required
- (void)loadDetailedList:(NSMutableArray *)list;
@end

@interface NewRequestDetailsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    
    UITableView *reqTableView;
    NSMutableArray *listOfPageSections;
    NSMutableArray *rowsSectionArray;
    
    
}

@property(nonatomic, retain) IBOutlet UITableView *reqTableView;
@property(nonatomic, retain) IBOutlet NSMutableArray *listOfPageSections;
@property(nonatomic, retain) IBOutlet NSMutableArray *rowsSectionArray;

@property NSUInteger pageIndex;

@property (assign) id<NewRequestDetailsViewControllerDelegate> delegation;

@end
