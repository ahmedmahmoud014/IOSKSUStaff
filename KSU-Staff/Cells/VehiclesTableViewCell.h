//
//  VehiclesTableViewCell.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 3/1/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VehicleObj.h"

typedef enum VehicleColor{
    VehicleBlue=0,
    VehiclePurple,
    VehicleOrange,
    VehicleGreen,
    VehicleRed
    
}VehicleColor;

@interface VehiclesTableViewCell : UITableViewCell{
    UILabel *vehicleNoLbl;
    UILabel *vehicleTypeLbl;
    UILabel *deliverDateLbl;
    UILabel *assignDateLbl;
    VehicleObj *vObj;
    
    UILabel *vehicleNoTitleLbl;
    UILabel *vehicleTypeTitleLbl;
    UILabel *deliverDateTitleLbl;
    UILabel *assignDateTitleLbl;
    UIImageView *bgImg;
}

@property(nonatomic,retain) IBOutlet UILabel *vehicleNoLbl;
@property(nonatomic,retain) IBOutlet UILabel *vehicleTypeLbl;
@property(nonatomic,retain) IBOutlet UILabel *deliverDateLbl;
@property(nonatomic,retain) IBOutlet UILabel *assignDateLbl;
@property(nonatomic,retain) IBOutlet UIImageView *bgImg;


@property(nonatomic,retain) IBOutlet UILabel *vehicleNoTitleLbl;
@property(nonatomic,retain) IBOutlet UILabel *vehicleTypeTitleLbl;
@property(nonatomic,retain) IBOutlet UILabel *deliverDateTitleLbl;
@property(nonatomic,retain) IBOutlet UILabel *assignDateTitleLbl;

-(void)initWithVehiclesObj:(VehicleObj*)obj withIndex:(int)rowId;

@end
