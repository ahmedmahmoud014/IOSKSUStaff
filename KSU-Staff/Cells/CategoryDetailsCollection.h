//
//  CategoryDetailsCollection.h
//  KSU-Staff
//
//  Created by iOSAccount on 11/14/17.
//  Copyright © 2017 E-Jawdah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryDetailsCollection : UICollectionViewCell
{
    UIImageView *imageView;
}
@property (nonatomic, strong) IBOutlet UIImageView *imageView;
-(void) initalizeValues: (UIImage*) image;
-(void)isAnimated;
@end
