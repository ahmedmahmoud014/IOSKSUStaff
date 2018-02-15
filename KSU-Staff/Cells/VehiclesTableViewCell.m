//
//  VehiclesTableViewCell.m
//  KSU-Staff
//
//  Created by EJ-Mac book on 3/1/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "VehiclesTableViewCell.h"
#import "LocalizedMessages.h"

@implementation VehiclesTableViewCell

@synthesize vehicleNoLbl,vehicleTypeLbl,assignDateLbl,deliverDateLbl,bgImg;
@synthesize vehicleNoTitleLbl,vehicleTypeTitleLbl,assignDateTitleLbl,deliverDateTitleLbl;

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)initWithVehiclesObj:(VehicleObj*)obj withIndex:(int)rowId{
    vObj=obj;
    vehicleTypeLbl.text=vObj.vehicleType;
    vehicleNoLbl.text=vObj.vehicleNo;
    assignDateLbl.text=vObj.assignDate;
    deliverDateLbl.text=vObj.deliverDate;
    
    int mod= rowId%5;
    switch (mod) {
        case VehicleBlue:
            bgImg.image=[UIImage imageNamed:@"blue_v.png"];
            break;
        case VehiclePurple:
            bgImg.image=[UIImage imageNamed:@"purple_v.png"];
            break;
        case VehicleOrange:
            bgImg.image=[UIImage imageNamed:@"orange_v.png"];
            break;
        case VehicleGreen:
            bgImg.image=[UIImage imageNamed:@"green_v.png"];
            break;
        case VehicleRed:
            bgImg.image=[UIImage imageNamed:@"red_v.png"];
            break;
        default:
            break;
    }
    
    vehicleTypeTitleLbl.text=vehicleTypeText;
    vehicleNoTitleLbl.text=vehicleNoText;
    assignDateTitleLbl.text=vehicleAssignText;
    deliverDateTitleLbl.text=vehicleDeliveryText;
    
}

@end
