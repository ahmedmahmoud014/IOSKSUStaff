//
//  BookViewController.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 4/15/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "BaseViewController.h"
#import "DataTransfer.h"

@interface BookViewController : BaseViewController <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,DataTransferDelegate>
{
    UICollectionView *collectionView;
    NSMutableArray *booksArr;
    UILabel *titleLbl;
    NSArray *dataArray;
    
    UIImageView * noDataImg;
}

@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) IBOutlet UILabel *titleLbl;

@property (nonatomic, strong) IBOutlet UIImageView * noDataImg;

@end
