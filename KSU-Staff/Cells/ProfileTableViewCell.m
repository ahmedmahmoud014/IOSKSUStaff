//
//  ProfileTableViewCell.m
//  KSU-Staff
//
//  Created by EJ-Mac book on 10/15/14.
//  Copyright (c) 2014 E-Jawdah. All rights reserved.
//

#import "ProfileTableViewCell.h"
#import "LocalizedMessages.h"
#import "StaticFuntions.h"
#import "AppDelegate.h"

@implementation ProfileTableViewCell
@synthesize titleLbl,valueLbl,boxBarImg;//,genderImg;
@synthesize dateBtn;

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) initWithJobInfo:(ProfileObj *)profile withIndexPath:(NSIndexPath*)indexPath{
    pObj=profile;
    titleLbl.textColor=[StaticFuntions getTableLableColor];
    valueLbl.textColor=[StaticFuntions getTableValueColor];
    
    if(((int)indexPath.row)==0){
        boxBarImg.hidden=NO;
    }else{
        boxBarImg.hidden=YES;
    }
    
    dateBtn.hidden=YES;
    [self getCellValueJobInfo:(int)indexPath.row];

}


-(void) initWithProfileObj:(ProfileObj *)profile withIndexPath:(NSIndexPath *)indexPath withpassInfo:(PassportObj *)pass languageType:(NSString*) languageType{
    
    pObj=profile;
    passObj=pass;
    titleLbl.textColor=[StaticFuntions getTableLableColor];
    valueLbl.textColor=[StaticFuntions getTableValueColor];
    
    if(((int)indexPath.row)==0){
        boxBarImg.hidden=NO;
    }else{
        boxBarImg.hidden=YES;
    }
    
    dateBtn.hidden=YES;
    if(((int)indexPath.section)==PersonalInfo_sec){//personal Info section
        [self getCellValuePersonalInfo:(int)indexPath.row languageType:languageType] ;
    }
     if(indexPath.section==PassportInfo_sec){
        printf("passobject");
        [self getCellValuePassportInfo:(int)indexPath.row];
    }
    
}

-(void)getCellValuePersonalInfo:(int)rowId languageType:(NSString*) languageType{
    switch (rowId) {
        case (int)Name_PInfo:
            titleLbl.text=FullNameText;
            valueLbl.text=pObj.fullName;
           // genderImg.hidden=NO;
            break;
        case (int)Nationality_PInfo:
            titleLbl.text=NationalityText;
            valueLbl.text=pObj.nationality;
            break;
        case (int)Birthdate_PInfo:
            titleLbl.text=BirthDateText;
            dateBtn.hidden=NO;
        if ( [languageType  isEqual: @"en"]){
            if(!isHijri)
                valueLbl.text=pObj.birthday;
            else
                valueLbl.text=pObj.hijriBirthday;
        }else {
            if(!isHijri)
            valueLbl.text=pObj.hijriBirthday;
            else
            valueLbl.text=pObj.birthday;
        }
        
            break;
        case (int)SocialNo_PInfo:
            titleLbl.text=SocialNoText;
            valueLbl.text=pObj.socialNo;
            break;
//
        /*case (int)SocialExpire_PInfo:
            titleLbl.text=SocialExpireText;
            valueLbl.text=pObj.socialExpire;
            BOOL passed= [StaticFuntions checkDatePassToday:pObj.socialExpire];
            if(passed){
                valueLbl.textColor=[StaticFuntions getNegativeValueColor];
            }
            break;
       */
        
        case (int)TelNo_PInfo:
            titleLbl.text=TelNoText;
            //valueLbl.text=pObj.telNo;
            break;
        case (int)MobNo_PInfo:
            titleLbl.text=MobNoText;
        if (pObj.mobNo !=  nil)
        {
            valueLbl.text=pObj.mobNo;
        }
        
            break;
        case (int)AlEmail_PInfo:
            titleLbl.text=AlterEmailText;
            valueLbl.text=pObj.alternativeEmail;
            break;
        case (int)webSite_PInfo:
            titleLbl.text=webSiteText;
        //NSLog(pObj.webSite);
        NSLog(@"%@", pObj.webSite);
        if(![pObj.webSite isKindOfClass:[NSNull class]]){
            valueLbl.text=pObj.webSite;
            //printf("objectValue");
        }
            break;
        
        
        default:
            break;
    }
}

-(void)getCellValuePassportInfo:(int)rowId{
    switch (rowId) {
        
        printf("passobject methods ");

        case (int)PassNo_PassInfo:
            titleLbl.text=PassportNoText;
            valueLbl.text=passObj.passportNo;
            break;
        case (int)Name_PassInfo:
            titleLbl.text=PassportNameText;
            valueLbl.text=passObj.name;
            break;
        case (int)Expiredate_PassInfo:
            titleLbl.text=PassportExDateText;
            valueLbl.text=passObj.expireDate;
            break;
        default:
            break;
    }
    
    
}


-(void)getCellValueJobInfo:(int)rowId{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSString *dateStr = @"";
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierIslamicUmmAlQura];
    df.dateStyle = NSDateFormatterLongStyle;
    df.dateFormat = @"yyyy/MM/dd";
    df.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    NSDate *date = [df dateFromString:pObj.hiringDate];

    if (pObj.hiringDate) {
        if (appDelegate.currentLang==Arabic)
            dateStr=pObj.hiringDate;
        else
            dateStr = [NSString stringWithFormat:@"%@/%@/%@",[StaticFuntions getYearForDate:date forceHijri:FALSE forceEnLocale:FALSE],[StaticFuntions getMonthNumForDate:date],[StaticFuntions getDayForDate:date forceEnLocale:FALSE]];
    }
    
    switch (rowId) {
        case (int)EmpNo_JInfo:
            titleLbl.text=EmpNoText;
            valueLbl.text=pObj.empNo;
            break;
        case (int)Rank_JInfo:
            titleLbl.text=RankText;
            valueLbl.text=pObj.rank;
            break;
        case (int)Grade_JInfo:
            titleLbl.text=GradeText;
            valueLbl.text=pObj.grade;
            break;
        case (int)HiringDate_JInfo:
            titleLbl.text=HiringDateText;
            valueLbl.text=dateStr;
            break;
        case (int)JobTitle_JInfo:
            titleLbl.text=JobTitleText;
            valueLbl.text=pObj.jobTitle;
            break;
        /*case (int)Dep_JInfo:
            titleLbl.text=DepartmentText;
            valueLbl.text=pObj.department;
            break;
        */case (int)Section_JInfo:
            titleLbl.text=SectionText;
            valueLbl.text=pObj.section;
            break;
        case (int)Status_JInfo:
            titleLbl.text=StatusText;
            valueLbl.text=pObj.status;
            break;
        case (int)StartDate_JInfo:
            titleLbl.text=StartWorkText;
            valueLbl.text=dateStr;
            break;
        case (int)BankAccNo_JInfo:
            titleLbl.text=BankAccNoText;
            valueLbl.text=pObj.bankAccNo;
            break;
        case (int)BankName_JInfo:
            titleLbl.text=BankNameText;
            valueLbl.text=pObj.bankName;
            break;
        default:
            break;
    }


}
#pragma mark - events

-(IBAction)onDatePressed:(id)sender{
    isHijri=!isHijri;
    if(!isHijri)
        valueLbl.text=pObj.birthday;
    else
        valueLbl.text=pObj.hijriBirthday;
}

@end
