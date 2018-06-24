//
//  OderItemsViewController.h
//  KSU-Staff
//
//  Created by iOSAccount on 11/13/17.
//  Copyright © 2017 E-Jawdah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface OderItemsViewController :UIViewController<UITableViewDataSource,UITableViewDelegate>{
    
    UILabel *titleLbl;
    UITableView *tableView;
    NSMutableArray *dataArray;
}

@property(nonatomic,retain) IBOutlet UILabel *titleLbl;
@property (nonatomic, retain)  NSMutableArray *dataArrayOrder;
@property(nonatomic,retain) IBOutlet UITableView *tableView;
@end
