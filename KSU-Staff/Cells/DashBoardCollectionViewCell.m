//
//  DashBoardCollectionViewCell.m
//  KSU-Staff
//
//  Created by EJ-Mac book on 10/13/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import "DashBoardCollectionViewCell.h"

@implementation DashBoardCollectionViewCell
@synthesize titleLabel;
@synthesize imageView;
@synthesize commingSoonImg;

-(void)isAnimated{
    self.contentView.alpha = 0.0;
    [UIView animateWithDuration:0.5 delay:0.2 options:UIViewAnimationOptionTransitionFlipFromLeft /*UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveEaseInOut*/ animations:^{
        self.contentView.alpha = 1.0;
    } completion:nil];
}
@end
