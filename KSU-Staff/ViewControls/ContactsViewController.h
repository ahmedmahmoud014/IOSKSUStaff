//
//  ContactsViewController.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 11/18/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import "BaseViewController.h"
#import "DataTransfer.h"

@interface ContactsViewController :  BaseViewController<UITableViewDataSource,UITableViewDelegate,DataTransferDelegate>{
    UILabel *titleLbl;
    UITableView *tableView;
    
    NSMutableArray * contactsArr;
    
}
@property(nonatomic,retain) IBOutlet UILabel *titleLbl;
@property(nonatomic,retain) IBOutlet UITableView *tableView;


@end
