//
//  CategoryCollectionCell.m
//  KSU-Staff
//
//  Created by iOSAccount on 11/2/17.
//  Copyright © 2017 E-Jawdah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CategoryCollectionCell.h"
@implementation CategoryCollectionCell
@synthesize titleLabel;
@synthesize imageView;

-(void)isAnimated{
    self.contentView.alpha = 0.0;
    [UIView animateWithDuration:0.5 delay:0.2 options:UIViewAnimationOptionTransitionFlipFromLeft /*UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveEaseInOut*/ animations:^{
        self.contentView.alpha = 1.0;
    } completion:nil];
}
@end
