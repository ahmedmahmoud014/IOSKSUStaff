//
//  DashBoardViewController.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 10/12/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import "BaseViewController.h"
#import "DataTransfer.h"

@interface DashBoardViewController : BaseViewController <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,DataTransferDelegate>
{
    UICollectionView *collectionView;
    NSArray *dataArray;
    UIButton *menuBtn;
    UILabel *copyrightsLbl;
    
    BOOL isTileView;
    NSTimer *repeatingTimer;
}

@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) IBOutlet UIButton *menuBtn;
@property (nonatomic, strong) IBOutlet UILabel *copyrightsLbl;

@end
