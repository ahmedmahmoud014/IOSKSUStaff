//
//  CustomNavigationController.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 9/17/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomNavigationController : UINavigationController

- (void)setPanning:(BOOL)allow;
-(UIViewController*)getTopView;

@end
