//
//  CategoryDetailsCollection.m
//  KSU-Staff
//
//  Created by iOSAccount on 11/14/17.
//  Copyright © 2017 E-Jawdah. All rights reserved.
//
#import "FLAnimatedImageView+WebCache.h"
#import "UIImageView+WebCache.h"
#import "CategoryDetailsCollection.h"

@implementation CategoryDetailsCollection
@synthesize imageView;
-(void)initalizeValues:image{
    imageView.layer.borderWidth = .5f;
    imageView.layer.borderColor = [[UIColor grayColor] CGColor];
    //imageView.image = image;
    
    [imageView  sd_setImageWithURL:[NSURL URLWithString:image]
                 placeholderImage:[UIImage imageNamed:@"loader"]
                          options:SDWebImageRefreshCached];
    
    
}
-(void)isAnimated{
    self.contentView.alpha = 0.0;
    [UIView animateWithDuration:0.5 delay:0.2 options:UIViewAnimationOptionTransitionFlipFromLeft /*UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveEaseInOut*/ animations:^{
        self.contentView.alpha = 1.0;
    } completion:nil];
}
@end
