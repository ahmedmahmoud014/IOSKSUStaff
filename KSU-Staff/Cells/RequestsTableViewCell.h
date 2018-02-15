//
//  RequestsTableViewCell.h
//  KSU_Students
//
//  Created by EJ-Mac book on 8/2/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestObj.h"

typedef enum serviceIDVal{
    Portal=0,
    Identification,
    Conferences,
    Outsourcing,
    Resignation,
    Clearance,
    NonSaudiConferences,
    TrainingandWorkShop,
    TeachingLoad,
    Endowments,
    TeachingAssistantPromotion,
    IpPhone,
    Followup,
    KsuMail
    
}serviceIDVal;

@interface RequestsTableViewCell : UITableViewCell{
    RequestObj * rObj;
    
}

@property (nonatomic,retain) IBOutlet UIImageView * serviceImg;
@property (nonatomic,retain) IBOutlet UIButton * actionsBtn;

@property (nonatomic,retain) IBOutlet UILabel * RequestDateTitleLbl;
@property (nonatomic,retain) IBOutlet UILabel * RequestNoTitleLbl;

@property (nonatomic,retain) IBOutlet UILabel * serviceNameValLbl;
@property (nonatomic,retain) IBOutlet UILabel * statusValLbl;
@property (nonatomic,retain) IBOutlet UILabel * senderValLbl;
@property (nonatomic,retain) IBOutlet UILabel * RequestDateValLbl;
@property (nonatomic,retain) IBOutlet UILabel * RequestNoValLbl;





-(void)initWithRequestObj:(RequestObj*)obj withRowId:(int)rowId;
@end
