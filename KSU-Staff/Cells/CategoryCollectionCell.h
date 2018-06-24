//
//  CategoryCollectionCell.h
//  KSU-Staff
//
//  Created by iOSAccount on 11/2/17.
//  Copyright © 2017 E-Jawdah. All rights reserved.
//

#ifndef CategoryCollectionCell_h
#define CategoryCollectionCell_h


#endif /* CategoryCollectionCell_h */
@interface CategoryCollectionCell : UICollectionViewCell
{
    UILabel *titleLabel;
    UIImageView *imageView;
    UIImageView *commingSoonImg;
}
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UIImageView *imageView;

-(void)isAnimated;
@end
