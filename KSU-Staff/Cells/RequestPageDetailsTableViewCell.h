//
//  RequestsTableViewCell.h
//  KSU_Students
//
//  Created by EJ-Mac book on 8/2/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RPageSectionRowObj.h"


@protocol RequestPageDetailsTableViewCellDelegate <NSObject>
@required
- (void)reloadOuterTable:(NSInteger)count withRowId:(NSInteger)withRowId;
- (void)loadRowItemsView:(NSMutableArray *)list;
@end

@interface RequestPageDetailsTableViewCell : UITableViewCell<UITableViewDataSource,UITableViewDelegate>{
    RPageSectionRowObj * rObj;
    UITableView *InnerTableView;
    NSMutableArray *rowItemsArray;
   // id<RequestPageDetailsTableViewCellDelegate> delegation;
    
    
}
@property(nonatomic,retain) IBOutlet UITableView *InnerTableView;
@property(nonatomic,retain) NSMutableArray *rowItemsArray;
@property (nonatomic,retain) IBOutlet UILabel * titleLbl;
@property (nonatomic,retain) IBOutlet UILabel * valueLbl;
@property (nonatomic,retain) IBOutlet UIView * separatorView;
@property (assign) id<RequestPageDetailsTableViewCellDelegate> delegation;



-(void)initWithRequestSectionRowObj:(RPageSectionRowObj*)obj withRowId:(int)rowId withHeight:(int)height;
@end
