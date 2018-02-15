//
//  VehicleObj.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 1/28/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExternalDocumentUnitObj : NSObject{
    NSString *ExternalUnitCode;
    NSString *ExternalUnitID;
    NSString *ExternalUnitName;
}

@property(nonatomic,retain) NSString *ExternalUnitCode;
@property(nonatomic,retain) NSString *ExternalUnitID;
@property(nonatomic,retain) NSString *ExternalUnitName;


@end
