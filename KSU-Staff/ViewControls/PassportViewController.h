//
//  PassportViewController.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 11/16/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import "BaseViewController.h"

@interface PassportViewController :  BaseViewController <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *collectionView;
    NSMutableArray *passortsArr;
    UILabel *titleLbl;
    NSArray *dataArray;
}

@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) IBOutlet UILabel *titleLbl;

@end
