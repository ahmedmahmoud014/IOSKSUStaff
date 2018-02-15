//
//  MyNavBar.m
//  KSU-Staff
//
//  Created by EJ-Mac book on 12/17/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import "MyNavBar.h"
#import "StaticVariables.h"

@implementation MyNavBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect barFrame = self.frame;
    int barHeight = 61;
    int originY = 6;
    if (SYSTEM_VERSION_LESS_THAN(@"10.0")) {
        barHeight = 53;
        originY = 9;
    }
    barFrame.size.height = barHeight;//61; // 53
    self.frame = barFrame;
    for (UIView *view in self.subviews) {
        if([NSStringFromClass([view class]) isEqualToString:@"_UINavigationBarBackground"] ){
            CGRect frame = view.frame;
            frame.origin.y = 0;
            view.frame = frame;
        }else{
            CGRect frame = view.frame;
            frame.origin.y = originY;//6; // 9
            view.frame = frame;
        }
    }
}

@end
