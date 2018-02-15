//
//  TitleValueTableViewCell.h
//  KSU-Staff
//
//  Created by iOSAccount on 12/4/16.
//  Copyright © 2016 E-Jawdah. All rights reserved.
//

#import <UIKit/UIKit.h>

// BlueHeaderTableViewCell:
/*
 
 TITLE          Value
 
 */

@interface TitleValueTableViewCell : UITableViewCell

#pragma mark - IBOutlets -

@property (weak, nonatomic) IBOutlet UILabel *cellTitle;
@property (weak, nonatomic) IBOutlet UILabel *cellValue;

@end
