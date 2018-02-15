//
//  BlueHeaderTableViewCell.h
//  KSU-Staff
//
//  Created by Eman Kassem on 12/3/16.
//  Copyright © 2016 E-Jawdah. All rights reserved.
//

#import <UIKit/UIKit.h>

// BlueHeaderTableViewCell for sectioned Cells "Show/Hide" embedded rows
/*
 
 HEADER          (^)
 
 */

@interface BlueHeaderTableViewCell : UITableViewCell

#pragma mark - IBOutlets -

@property (weak, nonatomic) IBOutlet UILabel *headerTitle;
@property (weak, nonatomic) IBOutlet UIImageView *togglingImageView;
@property (weak, nonatomic) IBOutlet UIButton *togglingButton;


@end
