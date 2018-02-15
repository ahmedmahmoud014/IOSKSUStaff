//
//  TasksTableViewCell.h
//  KSU-Staff
//
//  Created by EJ-Mac book on 11/16/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExternalDocumentUnitObj.h"

@interface ExternalDocumentUnitTableViewCell : UITableViewCell{
    UILabel *titleLbl;
    UILabel *IDLbl;
    
    ExternalDocumentUnitObj *eObj;
}

@property (nonatomic,retain) IBOutlet UILabel *titleLbl;
@property (nonatomic,retain) IBOutlet UILabel *IDLbl;


-(void) initWithExternalDocumentUnitObj:(ExternalDocumentUnitObj*)obj withRowId:(int)index;


@end
