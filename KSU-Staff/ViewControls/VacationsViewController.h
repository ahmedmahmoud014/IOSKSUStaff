//
//  VacationsViewController.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 10/28/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import "BaseViewController.h"
#import "DataTransfer.h"

@interface VacationsViewController : BaseViewController<DataTransferDelegate>{
    UILabel *titleLbl;
    UILabel *normalVac_Lbl;
    UILabel *normalVac_ValueLbl;
    
    UILabel *emergencyVac_Lbl;
    UILabel *emergencyVac_ValueLbl;
    
    UIView *controlsView;
 
}
@property(nonatomic,retain) IBOutlet UILabel *titleLbl;
@property(nonatomic,retain) IBOutlet UILabel *normalVac_Lbl;
@property(nonatomic,retain) IBOutlet UILabel *normalVac_ValueLbl;


@property(nonatomic,retain) IBOutlet UILabel *emergencyVac_Lbl;
@property(nonatomic,retain) IBOutlet UILabel *emergencyVac_ValueLbl;

@property(nonatomic,retain) IBOutlet UIView *controlsView;

@end
