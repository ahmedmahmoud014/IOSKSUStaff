//
//  DashBoardCollectionViewCell.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 10/13/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DashBoardCollectionViewCell : UICollectionViewCell
{
    UILabel *titleLabel;
    UIImageView *imageView;
    UIImageView *commingSoonImg;
}
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) IBOutlet UIImageView *commingSoonImg;

-(void)isAnimated;
@end
