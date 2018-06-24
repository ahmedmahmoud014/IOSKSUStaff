//
//  ShowImageFullScreenViewController.h
//  KSU-Staff
//
//  Created by iOSAccount on 11/16/17.
//  Copyright © 2017 E-Jawdah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowImageFullScreenViewController : UIViewController{
    
    UIButton *close;
}

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet NSString *imageValue
;

- (IBAction)close:(id)sender;


@end
