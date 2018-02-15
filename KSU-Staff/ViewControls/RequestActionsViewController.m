//
//  RequestActionsViewController.m
//  KSU_Students
//
//  Created by EJ-Mac book on 8/2/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "RequestActionsViewController.h"
#import "AppDelegate.h"
#import "LocalizedMessages.h"
#import "StaticFuntions.h"
#import "RequestActionsTableViewCell.h"
#import "RequestManager.h"

@interface RequestActionsViewController ()

@end

@implementation RequestActionsViewController


@synthesize titleLbl;
@synthesize tableView,controlsView,viewBackBtn;

@synthesize listOfRequestActions;

@synthesize backgroundView,detailsView,userNameLbl,userNameValView,userNameValLbl,actionLbl,actionValView,actionValLbl,reasonLbl,reasonValView,reasonValLbl,dateLbl,dateValView,dateValLbl,detaislBackBtn;

@synthesize selectedRequest;
@synthesize noDataImg;

NSInteger defaultPopupViewHeight;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self customizeNavigationBar:YES WithMenu:YES];
    /*if(IS_IPAD){
     int x= (self.view.frame.size.width- controlsView.frame.size.width)/2;
     controlsView.frame=CGRectMake(x, controlsView.frame.origin.y, controlsView.frame.size.width, controlsView.frame.size.height);
     }*/
    tableView.layoutMargins = UIEdgeInsetsZero;
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }

    
    [[userNameValView layer] setBorderColor:[[UIColor colorWithRed:(69/255.f) green:(69/255.f) blue:(69/255.f) alpha:0.5] CGColor]];
    [[userNameValView layer] setBorderWidth:0.5];
    [[userNameValView layer] setCornerRadius:2];
    
    [[actionValView layer] setBorderColor:[[UIColor colorWithRed:(69/255.f) green:(69/255.f) blue:(69/255.f) alpha:0.5] CGColor]];
    [[actionValView layer] setBorderWidth:0.5];
    [[actionValView layer] setCornerRadius:2];
    
    [[reasonValView layer] setBorderColor:[[UIColor colorWithRed:(69/255.f) green:(69/255.f) blue:(69/255.f) alpha:0.5] CGColor]];
    [[reasonValView layer] setBorderWidth:0.5];
    [[reasonValView layer] setCornerRadius:2];
    
    [[dateValView layer] setBorderColor:[[UIColor colorWithRed:(69/255.f) green:(69/255.f) blue:(69/255.f) alpha:0.5] CGColor]];
    [[dateValView layer] setBorderWidth:0.5];
    [[dateValView layer] setCornerRadius:2];
    
    userNameValLbl.adjustsFontSizeToFitWidth = YES;
    actionValLbl.adjustsFontSizeToFitWidth = YES;
    reasonValLbl.adjustsFontSizeToFitWidth = YES;
    dateValLbl.adjustsFontSizeToFitWidth = YES;
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - base methods

-(void)initalizeViews{

    noDataLbl.hidden=YES;
    noDataImg.hidden=YES;
    
    
    listOfRequestActions = [[NSMutableArray alloc] init];
    
    if([self isNetworkAvailable] ==YES)
    {
        NSLog(@"Network Connection available");
        [self connect];
    }
    
    else{
        [StaticFuntions showAlertWithTitle:NetWorkTitle Message:NetWorkBody];
        
    }
}

-(void)locatizeLables{
   
    titleLbl.text=RequestActionsTitleText;
    
    noDataLbl.text=RequestActionsNoDataFoundMsg;
    
    userNameLbl.text=UserNameText;
    actionLbl.text=RequestActionText;
    reasonLbl.text=RequestActionReasonText;
    dateLbl.text=RequestActionDateText;

    
    userNameValLbl.text = @"";
    actionValLbl.text = @"";
    reasonValLbl.text = @"";
    dateValLbl.text = @"";
    
    
    defaultPopupViewHeight = detailsView.frame.size.height;
    
    [viewBackBtn setTitle:BackButtonText forState:UIControlStateNormal];
    [detaislBackBtn setTitle:BackButtonText forState:UIControlStateNormal];
    
    
}

-(void)switchToLeftLayout{
    
    titleLbl.textAlignment=NSTextAlignmentLeft;
    
    userNameLbl.textAlignment=NSTextAlignmentLeft;
    userNameValLbl.textAlignment=NSTextAlignmentLeft;
    
    actionLbl.textAlignment=NSTextAlignmentLeft;
    actionValLbl.textAlignment=NSTextAlignmentLeft;
    
    reasonLbl.textAlignment=NSTextAlignmentLeft;
    reasonValLbl.textAlignment=NSTextAlignmentLeft;
    
    dateLbl.textAlignment=NSTextAlignmentLeft;
    dateValLbl.textAlignment=NSTextAlignmentLeft;
    
    
    
    
    CGRect frame = titleLbl.frame;
    frame.origin.x = 8;
    titleLbl.frame = frame;
    
    frame = userNameLbl.frame;
    frame.origin.x = 8;
    userNameLbl.frame = frame;
    
    frame = userNameValView.frame;
    frame.origin.x = userNameLbl.frame.origin.x + userNameLbl.frame.size.width + 3;
    userNameValView.frame = frame;
    
    
    frame = actionLbl.frame;
    frame.origin.x = 8;
    actionLbl.frame = frame;
    
    frame = actionValView.frame;
    frame.origin.x = actionLbl.frame.origin.x + actionLbl.frame.size.width + 3;
    actionValView.frame = frame;
    
    
    
    frame = reasonLbl.frame;
    frame.origin.x = 8;
    reasonLbl.frame = frame;
    
    frame = reasonValView.frame;
    frame.origin.x = reasonLbl.frame.origin.x + reasonLbl.frame.size.width + 3;
    reasonValView.frame = frame;
    
    
    
    frame = dateLbl.frame;
    frame.origin.x = 8;
    dateLbl.frame = frame;
    
    frame = dateValView.frame;
    frame.origin.x = dateLbl.frame.origin.x + dateLbl.frame.size.width + 3;
    dateValView.frame = frame;
    
}

-(void)switchToRightLayout{
    
    viewBackBtn.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    viewBackBtn.titleLabel.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    viewBackBtn.imageView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    
    detaislBackBtn.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    detaislBackBtn.titleLabel.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    detaislBackBtn.imageView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    
    titleLbl.textAlignment=NSTextAlignmentRight;
    
    userNameLbl.textAlignment=NSTextAlignmentRight;
    userNameValLbl.textAlignment=NSTextAlignmentRight;
    

    actionLbl.textAlignment=NSTextAlignmentRight;
    actionValLbl.textAlignment=NSTextAlignmentRight;
    
    reasonLbl.textAlignment=NSTextAlignmentRight;
    reasonValLbl.textAlignment=NSTextAlignmentRight;
    
    dateLbl.textAlignment=NSTextAlignmentRight;
    dateValLbl.textAlignment=NSTextAlignmentRight;
    
    
    CGRect frame = titleLbl.frame;
    frame.origin.x = 8;
    titleLbl.frame = frame;
    
    frame = userNameValView.frame;
    frame.origin.x = 8;
    userNameValView.frame = frame;
    
    frame = userNameLbl.frame;
    frame.origin.x = userNameValView.frame.origin.x + userNameValView.frame.size.width + 3;
    userNameLbl.frame = frame;
    
    
    frame = actionValView.frame;
    frame.origin.x = 8;
    actionValView.frame = frame;
    
    frame = actionLbl.frame;
    frame.origin.x = actionValView.frame.origin.x + actionValView.frame.size.width + 3;
    actionLbl.frame = frame;
    
    frame = reasonValView.frame;
    frame.origin.x = 8;
    reasonValView.frame = frame;
    
    frame = reasonLbl.frame;
    frame.origin.x = reasonValView.frame.origin.x + reasonValView.frame.size.width + 3;
    reasonLbl.frame = frame;
    
    frame = dateValView.frame;
    frame.origin.x = 8;
    dateValView.frame = frame;
    
    frame = dateLbl.frame;
    frame.origin.x = dateValView.frame.origin.x + dateValView.frame.size.width + 3;
    dateLbl.frame = frame;
}


#pragma mark - methods

-(NSString *)concatinateDateString:(NSString *)day month:(NSString *)month year:(NSString *)year
{
    NSString *dateStr = @"";
    dateStr = [NSString stringWithFormat:@"%@/%@/%@",day,month,year];
    
    return dateStr;
}

-(void)connect{
    [[RequestManager sharedInstance] getRequestActionsList:self withRequestCode:selectedRequest];
    [self showActivityViewer];
    tableView.contentOffset = CGPointMake(0.0, 0.0);
    
    /*
    RequestActionsObj *rObj=[[RequestActionsObj alloc] init];
    
    
    rObj = [self fillstaticdata:@"بكر سليمان مرجي الحربي" actionStr:@"تمت الموافقه من ممثل الكلية" requestActionDateStr:@"06/05/1437 10:27 AM" reasonStr:@""];
    [listOfRequestActions addObject:rObj];
    
    rObj = [self fillstaticdata:@"ياسر صالح إبراهيم المهنا" actionStr:@"تمت الموافقه من رئيس القسم" requestActionDateStr:@"06/05/1437 10:31 AM" reasonStr:@""];
    [listOfRequestActions addObject:rObj];
    
    rObj = [self fillstaticdata:@"وطبان عبد الرحمن صالح الوطبان" actionStr:@"تمت الموافقه من عميد الكلية" requestActionDateStr:@"06/05/1437 10:34 AM" reasonStr:@""];
    [listOfRequestActions addObject:rObj];
    
    rObj = [self fillstaticdata:@"ياسر صالح إبراهيم المهنا" actionStr:@"تمت إعادة الطلب من لجنة الاستعانة الى عميد الكلية" requestActionDateStr:@"06/05/1437 10:52 AM" reasonStr:@""];
    [listOfRequestActions addObject:rObj];
    
    rObj = [self fillstaticdata:@"وطبان عبد الرحمن صالح الوطبان" actionStr:@"تمت الموافقه من عميد الكلية" requestActionDateStr:@"06/05/1437 10:54 AM" reasonStr:@""];
    [listOfRequestActions addObject:rObj];
    
    rObj = [self fillstaticdata:@"ياسر صالح إبراهيم المهنا" actionStr:@"مرفوض من لجنه الاستعانة" requestActionDateStr:@"06/05/1437 4:40 PM" reasonStr:@"تم الرفض"];
    [listOfRequestActions addObject:rObj];
    
    rObj = [self fillstaticdata:@"بكر سليمان مرجي الحربي" actionStr:@"تمت إعادة الطلب من لجنة الاستعانة الى عميد الكلية" requestActionDateStr:@"06/05/1437 1:48 PM" reasonStr:@""];
    [listOfRequestActions addObject:rObj];
    
    rObj = [self fillstaticdata:@"وطبان عبد الرحمن صالح الوطبان" actionStr:@"تمت الموافقه من عميد الكلية" requestActionDateStr:@"06/05/1437 1:55 PM" reasonStr:@""];
    [listOfRequestActions addObject:rObj];
    [tableView reloadData];*/
    
}



-(RequestActionsObj *)fillstaticdata:(NSString *)requestActionUserStr actionStr:(NSString *)actionStr requestActionDateStr:(NSString *)requestActionDateStr reasonStr:(NSString *)reasonStr
{
    RequestActionsObj *rObj=[[RequestActionsObj alloc] init];
    rObj.userName = requestActionUserStr;
    rObj.action = actionStr;
    rObj.date = requestActionDateStr;
    rObj.reason = reasonStr;
    
    return rObj;
}



#pragma mark - connection

- (void)processCompleted:(id)data error:(CustomError *)error withService:(NSNumber *)service{
    [self hideActivityViewer];
    if(data!=nil){
        
        NSMutableArray* arr =(NSMutableArray*)data;
        for(int i=0;i<[arr count];i++){
            RequestActionsObj* obj=[arr objectAtIndex:i];
            
            if(!listOfRequestActions){
                listOfRequestActions=[[NSMutableArray alloc] init];
            }
            [listOfRequestActions addObject:obj];
        }
    }else{
        [StaticFuntions showAlertWithTitle:ErrorGeneralTitle Message:error.errorMessage];
    }
    
    tableView.contentOffset = CGPointMake(0.0, 0.0);
    [tableView reloadData];
}

#pragma mark - table delegate

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier=@"RequestActionsTableViewCell";
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(appDelegate.currentLang==English)
        CellIdentifier=@"RequestActionsTableViewCell_en";
    else
        CellIdentifier=@"RequestActionsTableViewCell";
    
    RequestActionsTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[RequestActionsTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    RequestActionsObj *obj=nil;
    
    obj=[listOfRequestActions objectAtIndex:(int)indexPath.row];
    [cell initWithRequestActionsObj:obj withRowId:(int)indexPath.row];
    cell.detailsBtn.tag = indexPath.row;
    [cell.detailsBtn addTarget:self action:@selector(onPressDetails:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.preservesSuperviewLayoutMargins = NO;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if([listOfRequestActions count]==0){
        noDataLbl.hidden=NO;
        noDataImg.hidden=NO;
        return 0;
    }
    noDataLbl.hidden=YES;
    noDataImg.hidden=YES;
    return [listOfRequestActions count];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)tableView:(UITableView *)tView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self showDetails:indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - events

-(IBAction)onPressBack:(id)sender
{
    if (sender == viewBackBtn)
    {
        [self.navigationController popViewControllerAnimated:NO];
    }
    else if (sender == detaislBackBtn)
    {
        backgroundView.hidden = YES;
        detailsView.hidden = YES;
        
    }
}

-(IBAction)onPressDetails:(id)sender
{
    UIButton *btn = sender;
    [self showDetails:btn.tag];
}

-(void)showDetails:(NSInteger)actionID
{
    userNameValLbl.text = @"";
    actionValLbl.text = @"";
    reasonValLbl.text = @"";
    dateValLbl.text = @"";
    
    backgroundView.hidden = FALSE;
    detailsView.hidden = FALSE;
    RequestActionsObj *rObj = [listOfRequestActions objectAtIndex:actionID];
    userNameValLbl.text = rObj.userName;
    actionValLbl.text = rObj.action;
    if (![rObj.reason isKindOfClass:[NSNull class]]&&rObj.reason != nil && ![rObj.reason isEqualToString:@""])
        reasonValLbl.text = rObj.reason;
    else
        reasonValLbl.text = NoDataFoundMsg;
    dateValLbl.text = rObj.date;
    
    userNameValLbl.numberOfLines = 1000;
    actionValLbl.numberOfLines = 1000;
    dateValLbl.numberOfLines = 1000;
    reasonValLbl.numberOfLines = 1000;
    
    
    CGRect frame;
    NSInteger totalHeight = 0;
    
    
    CGRect newFrame = userNameValLbl.frame;
    CGSize newSize = [userNameValLbl sizeThatFits:CGSizeMake(userNameValLbl.frame.size.width, MAXFLOAT)];
    newFrame.size = CGSizeMake(fmaxf(newSize.width, userNameValLbl.frame.size.width), newSize.height);
    newFrame.size.height += 10;
    frame = userNameValView.frame;
    frame.size.height = newFrame.size.height;
    userNameValView.frame = frame;
    frame = userNameValLbl.frame;
    frame.size.height = newFrame.size.height;
    userNameValLbl.frame = frame;
    
    totalHeight += userNameValView.frame.size.height;
    
    
    
    newFrame = actionValLbl.frame;
    newSize = [actionValLbl sizeThatFits:CGSizeMake(actionValLbl.frame.size.width, MAXFLOAT)];
    newFrame.size = CGSizeMake(fmaxf(newSize.width, actionValLbl.frame.size.width), newSize.height);
    newFrame.size.height += 10;
    frame = actionValView.frame;
    frame.origin.y = userNameValView.frame.origin.y + userNameValView.frame.size.height + 5;
    frame.size.height = newFrame.size.height;
    actionValView.frame = frame;
    frame = actionValLbl.frame;
    frame.size.height = newFrame.size.height;
    actionValLbl.frame = frame;
    
    totalHeight += 5 + actionValView.frame.size.height;
    
    
    newFrame = reasonValLbl.frame;
    newSize = [reasonValLbl sizeThatFits:CGSizeMake(reasonValLbl.frame.size.width, MAXFLOAT)];
    newFrame.size = CGSizeMake(fmaxf(newSize.width, reasonValLbl.frame.size.width), newSize.height);
    newFrame.size.height += 10;
    frame = reasonValView.frame;
    frame.origin.y = actionValView.frame.origin.y + actionValView.frame.size.height + 5;
    frame.size.height = newFrame.size.height;
    reasonValView.frame = frame;
    frame = reasonValLbl.frame;
    frame.size.height = newFrame.size.height;
    reasonValLbl.frame = frame;
    
    totalHeight += 5 + reasonValView.frame.size.height;
    
    newFrame = dateValLbl.frame;
    newSize = [dateValLbl sizeThatFits:CGSizeMake(dateValLbl.frame.size.width, MAXFLOAT)];
    newFrame.size = CGSizeMake(fmaxf(newSize.width, dateValLbl.frame.size.width), newSize.height);
    newFrame.size.height += 10;
    frame = dateValView.frame;
    frame.origin.y = reasonValView.frame.origin.y + reasonValView.frame.size.height + 5;
    frame.size.height = newFrame.size.height;
    dateValView.frame = frame;
    frame = dateValLbl.frame;
    frame.size.height = newFrame.size.height;
    dateValLbl.frame = frame;
    
    totalHeight += 5 + dateValView.frame.size.height;
    
    totalHeight += 10 + 10 + detaislBackBtn.frame.size.height + 10;
    
    if (totalHeight > (controlsView.frame.size.height - 12)) {
        NSInteger difference = totalHeight - controlsView.frame.size.height;
        difference += 12;
        frame = reasonValLbl.frame;
        frame.size.height -= difference;
        reasonValLbl.frame = frame;
        
        frame = reasonValView.frame;
        frame.size.height -= difference;
        reasonValView.frame = frame;
        
        frame = dateValView.frame;
        frame.origin.y = reasonValView.frame.origin.y + reasonValView.frame.size.height + 5;
        dateValView.frame = frame;
        
        totalHeight -= difference;
    }
    
    frame = detaislBackBtn.frame;
    frame.origin.y = dateValView.frame.origin.y + dateValView.frame.size.height + 10;
    detaislBackBtn.frame = frame;
    
    frame = userNameLbl.frame;
    frame.origin.y = userNameValView.frame.origin.y;
    frame.size.height = userNameValView.frame.size.height;
    userNameLbl.frame = frame;
    
    frame = actionLbl.frame;
    frame.origin.y = actionValView.frame.origin.y;
    frame.size.height = actionValView.frame.size.height;
    actionLbl.frame = frame;
    
    frame = reasonLbl.frame;
    frame.origin.y = reasonValView.frame.origin.y;
    frame.size.height = reasonValView.frame.size.height;
    reasonLbl.frame = frame;
    
    frame = dateLbl.frame;
    frame.origin.y = dateValView.frame.origin.y;
    frame.size.height = dateValView.frame.size.height;
    dateLbl.frame = frame;
    
    
    frame = detailsView.frame;
    frame.origin.y = controlsView.frame.origin.y + ( (controlsView.frame.size.height - totalHeight) / 2);
    frame.size.height = totalHeight;
    detailsView.frame = frame;
    
    
}

@end
