//
//  MenuViewController.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 9/17/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewController : UITableViewController <UITableViewDataSource,UITableViewDelegate>{
 
    UILabel *menuTitleLbl;
    UIImageView *imageView;
}

@property(nonatomic,retain) IBOutlet UILabel *menuTitleLbl;
@property(nonatomic,retain) IBOutlet UIImageView *imageView;

- (void)setPanning:(BOOL)allow;
-(BOOL)isNetworkAvailable;

@end
