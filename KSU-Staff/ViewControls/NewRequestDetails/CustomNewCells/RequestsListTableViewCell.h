//
//  RequestsListTableViewCell.h
//  KSU-Staff
//
//  Created by iOSAccount on 12/4/16.
//  Copyright © 2016 E-Jawdah. All rights reserved.
//

#import <UIKit/UIKit.h>

// RequestsListTableViewCell for List Cells "Show/Hide" embedded rows
/*
 
 LIST          (^)
 
 */

@interface RequestsListTableViewCell : UITableViewCell

#pragma mark - IBOutlets -

@property (weak, nonatomic) IBOutlet UILabel *listTitle;
@property (weak, nonatomic) IBOutlet UIImageView *togglingImageView;
@property (weak, nonatomic) IBOutlet UIButton *togglingButton;

@end
