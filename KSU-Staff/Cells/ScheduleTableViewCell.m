//
//  ScheduleTableViewCell.m
//  KSU_Students
//
//  Created by EJ-Mac book on 8/2/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "ScheduleTableViewCell.h"
#import "LocalizedMessages.h"

@implementation ScheduleTableViewCell

@synthesize classBuildingIdLbl;
@synthesize classPartitionLbl;
@synthesize classFloorLbl;
@synthesize classRoomLbl;
@synthesize courseNoLbl;
@synthesize startTimeLbl;
@synthesize endTimeLbl;
@synthesize sectionLbl;

@synthesize classBuildingIdValLbl;
@synthesize classPartitionValLbl;
@synthesize classFloorValLbl;
@synthesize classRoomValLbl;

@synthesize courseNoValLbl;
@synthesize startTimeValLbl;
@synthesize endTimeValLbl;
@synthesize sectionValLbl;

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)initWithScheduleObj:(ScheduleObj*)obj withRowId:(int)rowId{
    sObj=obj;
    classBuildingIdValLbl.text=sObj.classBuildingId;
    classPartitionValLbl.text=sObj.classpartitionId;
    classFloorValLbl.text=sObj.classFloorId;
    classRoomValLbl.text=sObj.classRoomId;
    
    courseNoValLbl.text=sObj.courseNo;
    startTimeValLbl.text=sObj.startTime;
    endTimeValLbl.text=sObj.endTime;
    sectionValLbl.text=sObj.SectionNo;
    
    classBuildingIdLbl.text = scheduleClassBuildingText;
    classPartitionLbl.text = scheduleClassPartitionText;
    classFloorLbl.text = scheduleClassFloorText;
    classRoomLbl.text = scheduleClassRoomText;
    courseNoLbl.text=scheduleCourseCodeText;
    startTimeLbl.text=scheduleStartTimeText;
    endTimeLbl.text=scheduleEndTimeText;
    sectionLbl.text=scheduleSectionIDText;
    
    
    classBuildingIdLbl.adjustsFontSizeToFitWidth = YES;
    classPartitionLbl.adjustsFontSizeToFitWidth = YES;
    classFloorLbl.adjustsFontSizeToFitWidth = YES;
    classRoomLbl.adjustsFontSizeToFitWidth = YES;
    
    classBuildingIdValLbl.adjustsFontSizeToFitWidth = YES;
    classPartitionValLbl.adjustsFontSizeToFitWidth = YES;
    classFloorValLbl.adjustsFontSizeToFitWidth = YES;
    classRoomValLbl.adjustsFontSizeToFitWidth = YES;
    
}
@end
