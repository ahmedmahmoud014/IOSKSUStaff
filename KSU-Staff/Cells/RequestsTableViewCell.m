//
//  RequestsTableViewCell.m
//  KSU_Students
//
//  Created by EJ-Mac book on 8/2/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "RequestsTableViewCell.h"
#import "LocalizedMessages.h"

@implementation RequestsTableViewCell

@synthesize serviceImg;
@synthesize actionsBtn;
@synthesize RequestDateTitleLbl;
@synthesize RequestNoTitleLbl;
@synthesize serviceNameValLbl;
@synthesize statusValLbl;
@synthesize senderValLbl;
@synthesize RequestDateValLbl;
@synthesize RequestNoValLbl;


- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




-(void)initWithRequestObj:(RequestObj*)obj withRowId:(int)rowId{
    rObj=obj;
    
    RequestDateTitleLbl.text=RequestDateText;
    RequestNoTitleLbl.text=RequestRequestIDText;

    NSMutableString *fullName = [[NSMutableString alloc] initWithString:rObj.serviceName];
    // Trimming Pre and Post spaces
    NSString *trimmedName = [fullName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *trimmedType = [rObj.serviceTypeName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSLog(@"%@\n%@", trimmedName, trimmedType);
    // Replacing white spaces by NOTHING
    if (rObj.serviceTypeName && ![[trimmedName stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:[trimmedType stringByReplacingOccurrencesOfString:@" " withString:@""]]) {
        [fullName appendString:[NSString stringWithFormat:@" - %@", rObj.serviceTypeName]];
    }
    serviceNameValLbl.text=fullName;
    statusValLbl.text=rObj.requestStatus;
    RequestDateValLbl.text=rObj.requestDate;
    senderValLbl.text=rObj.requesterName;
    RequestNoValLbl.text=rObj.requestCode;
    
    //[actionsBtn setBackgroundImage:[UIImage imageNamed:@"Path.png"] forState:UIControlStateNormal];
    
    
    /*switch (status) {
     case AFNetworkReachabilityStatusNotReachable:
     return NSLocalizedStringFromTable(@"Not Reachable", @"AFNetworking", nil);
     case AFNetworkReachabilityStatusReachableViaWWAN:
     return NSLocalizedStringFromTable(@"Reachable via WWAN", @"AFNetworking", nil);
     case AFNetworkReachabilityStatusReachableViaWiFi:
     return NSLocalizedStringFromTable(@"Reachable via WiFi", @"AFNetworking", nil);
     case AFNetworkReachabilityStatusUnknown:
     default:
     return NSLocalizedStringFromTable(@"Unknown", @"AFNetworking", nil);
     }*/
    
    
    
    if (([rObj.serviceCode integerValue] - 1) == Portal)
        serviceImg.image=[UIImage imageNamed:@"services.png"];
    else if (([rObj.serviceCode integerValue] - 1) == Identification)
        serviceImg.image=[UIImage imageNamed:@"definitions.png"];
    else if (([rObj.serviceCode integerValue] - 1) == Conferences)
        serviceImg.image=[UIImage imageNamed:@"conference.png"];
    else if (([rObj.serviceCode integerValue] - 1) == Outsourcing)
        serviceImg.image=[UIImage imageNamed:@"help.png"];
    else if (([rObj.serviceCode integerValue] - 1) == Resignation)
        serviceImg.image=[UIImage imageNamed:@"resignation.png"];
    else if (([rObj.serviceCode integerValue] - 1) == Clearance)
        serviceImg.image=[UIImage imageNamed:@"retirement.png"];
    else if (([rObj.serviceCode integerValue] - 1) == NonSaudiConferences)
        serviceImg.image=[UIImage imageNamed:@"conference_Foreign.png"];
    else if (([rObj.serviceCode integerValue] - 1) == TrainingandWorkShop)
        serviceImg.image=[UIImage imageNamed:@"teaching_courses.png"];
    else if (([rObj.serviceCode integerValue] - 1) == TeachingLoad)
        serviceImg.image=[UIImage imageNamed:@"TLMS.png"];
    else if (([rObj.serviceCode integerValue] - 1) == Endowments)
        serviceImg.image=[UIImage imageNamed:@"awkaf.png"];
    else if (([rObj.serviceCode integerValue] - 1) == TeachingAssistantPromotion)
        serviceImg.image=[UIImage imageNamed:@"promoteinstructortolecturer.png"];
    else if (([rObj.serviceCode integerValue] - 1) == IpPhone)
        serviceImg.image=[UIImage imageNamed:@"tel.png"];
    else if (([rObj.serviceCode integerValue] - 1) == Followup)
        serviceImg.image=[UIImage imageNamed:@"academic-follow-up.png"];
    else if (([rObj.serviceCode integerValue] - 1) == KsuMail)
        serviceImg.image=[UIImage imageNamed:@"email.png"];
    else// else if (([rObj.serviceCode integerValue] - 1) == outsourcing) {
        serviceImg.image=[UIImage imageNamed:@"services.png"];
        
    serviceNameValLbl.adjustsFontSizeToFitWidth=YES;
    RequestDateValLbl.adjustsFontSizeToFitWidth=YES;
    senderValLbl.adjustsFontSizeToFitWidth=YES;
    RequestNoValLbl.adjustsFontSizeToFitWidth=YES;
    
    
}
@end
