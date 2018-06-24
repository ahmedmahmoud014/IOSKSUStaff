//
//  ShowImageFullScreenViewController.m
//  KSU-Staff
//
//  Created by iOSAccount on 11/16/17.
//  Copyright © 2017 E-Jawdah. All rights reserved.
//

#import "ShowImageFullScreenViewController.h"
#import "FLAnimatedImageView+WebCache.h"
#import "UIImageView+WebCache.h"


@interface ShowImageFullScreenViewController ()

@end

@implementation ShowImageFullScreenViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self.image  sd_setImageWithURL:[NSURL URLWithString:self.imageValue]
                  placeholderImage:[UIImage imageNamed:@"loader"]
                           options:SDWebImageRefreshCached];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];

}
@end
