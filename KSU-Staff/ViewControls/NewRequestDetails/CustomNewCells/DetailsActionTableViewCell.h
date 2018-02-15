//
//  DetailsActionTableViewCell.h
//  KSU-Staff
//
//  Created by iOSAccount on 12/4/16.
//  Copyright © 2016 E-Jawdah. All rights reserved.
//

#import <UIKit/UIKit.h>

// DetailsActionTableViewCell for List Cells show more details
/*
 
 TITLE #1          VALUE #1
                                    (...)
 TITLE #2          VALUE #2
 
 */

@interface DetailsActionTableViewCell : UITableViewCell

#pragma mark - IBOutlets -

@property (weak, nonatomic) IBOutlet UILabel *cellTitle1;
@property (weak, nonatomic) IBOutlet UILabel *cellTitle2;
@property (weak, nonatomic) IBOutlet UILabel *cellValue1;
@property (weak, nonatomic) IBOutlet UILabel *cellValue2;
@property (weak, nonatomic) IBOutlet UIImageView *detailsImageView;
@property (weak, nonatomic) IBOutlet UIButton *showDetails;

@end
