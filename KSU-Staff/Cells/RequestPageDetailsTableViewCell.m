//
//  RequestsTableViewCell.m
//  KSU_Students
//
//  Created by EJ-Mac book on 8/2/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//



#import "RequestPageDetailsTableViewCell.h"
#import "RequestRowDetailsTableViewCell.h"
#import "LoginViewController.h"
#import "LocalizedMessages.h"
#import "AppDelegate.h"
#import "CustomNavigationController.h"
#import "BaseViewController.h"


@implementation RequestPageDetailsTableViewCell

@synthesize titleLbl;
@synthesize valueLbl;
@synthesize separatorView;
@synthesize InnerTableView;
@synthesize rowItemsArray;
@synthesize delegation;

NSInteger currentRowId = 0;


- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)initWithRequestSectionRowObj:(RPageSectionRowObj*)obj withRowId:(int)rowId withHeight:(int)height{
    
    currentRowId = rowId;
    titleLbl.numberOfLines = 1000;
    valueLbl.numberOfLines = 1000;
    
    rObj=obj;
    titleLbl.text=rObj.label;
    if ([rObj.singleValue isEqualToString:@""] || rObj.singleValue == nil) {
        rObj.singleValue = NoDataFoundMsg;
    }
    
    valueLbl.text=rObj.singleValue;
    
    CGRect frame;
    if (![rObj.dataType isEqualToString:@"list"]) {
        InnerTableView.hidden = YES;
        titleLbl.hidden = FALSE;
        valueLbl.hidden = FALSE;
        
        if ([rObj.dataType isEqualToString:@"labelText"] || [rObj.dataType isEqualToString:@"labelTextarea"]) {
            titleLbl.hidden = YES;
        
            frame = valueLbl.frame;
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            if(appDelegate.currentLang==English)
                frame.origin.x = 3;
    
            frame.size.width += titleLbl.frame.size.width + 8;
            valueLbl.frame = frame;
            valueLbl.textAlignment = NSTextAlignmentCenter;

        }
        frame = valueLbl.frame;
        frame.size.height = height - 7;
        valueLbl.frame = frame;
        
        frame = titleLbl.frame;
        frame.size.height = height - 7;
        titleLbl.frame = frame;
        
        
        frame = separatorView.frame;
        frame.origin.y = height - 1;
        separatorView.frame = frame;
        
        
    }
    else if ([rObj.dataType isEqualToString:@"list"]) {
        InnerTableView.hidden = FALSE;
        titleLbl.hidden = YES;
        valueLbl.hidden = YES;
        
        InnerTableView.layoutMargins = UIEdgeInsetsZero;
        if ([InnerTableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [InnerTableView setSeparatorInset:UIEdgeInsetsZero];
        }
        InnerTableView.contentOffset = CGPointMake(0.0, 0.0);
        InnerTableView.scrollEnabled = FALSE;
        
        [self expandTableSections];
        [InnerTableView reloadData];
        
        frame = InnerTableView.frame;
        frame.origin.y = 0;
        frame.size.height = height;
        InnerTableView.frame = frame;
    }
    
}

- (void)expandTableSections {
    if (rowItemsArray == nil) {
        rowItemsArray = [[NSMutableArray alloc] init];
    } else {
        [rowItemsArray removeAllObjects];
    }
    [rowItemsArray addObject:[NSNumber numberWithInt:(int)[rObj.listValue count]]];
}


#pragma mark - UITableView Datasource -

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier=@"RequestRowDetailsTableViewCell";
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(appDelegate.currentLang==English)
        CellIdentifier=@"RequestRowDetailsTableViewCell_en";
    else
        CellIdentifier=@"RequestRowDetailsTableViewCell";
    
    RequestRowDetailsTableViewCell *cell = [self.InnerTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[RequestRowDetailsTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    RPageSectionRowObj *obj1=nil;
    RPageSectionRowObj *obj2=nil;
    
    
    
    NSMutableArray *listOfRowsItems = rObj.listValue;
    NSMutableArray *listOfRowItems = [listOfRowsItems objectAtIndex:indexPath.row];
    obj1=[listOfRowItems objectAtIndex:0];
    obj2=[listOfRowItems objectAtIndex:1];
    
    CGRect frame = [InnerTableView rectForRowAtIndexPath:indexPath];
    [cell initWithRequestRowItemsObj:obj1 obj2:obj2 withRowId:(int)indexPath.row withHeight:frame.size.height ];
    
    // Hiding Details' Button if listOfRowsItems <= 2 items
    
    cell.detailsBtn.hidden = NO;
    
    if (listOfRowItems.count <= 2) {
        cell.detailsBtn.hidden = YES;
    }
    cell.detailsBtn.tag = indexPath.row;
    [cell.detailsBtn addTarget:self action:@selector(onPressDetails:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.preservesSuperviewLayoutMargins = NO;
    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[rowItemsArray objectAtIndex:(int)section] intValue];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

#pragma mark - UITableView Delegate -

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *listOfRowsItems = rObj.listValue;
    NSMutableArray *listOfRowItems = [listOfRowsItems objectAtIndex:indexPath.row];
    
    static NSString *CellIdentifier=@"RequestRowDetailsTableViewCell";
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(appDelegate.currentLang==English)
        CellIdentifier=@"RequestRowDetailsTableViewCell_en";
    else
        CellIdentifier=@"RequestRowDetailsTableViewCell";
    
    RequestRowDetailsTableViewCell *cell = [self.InnerTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[RequestRowDetailsTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    
    cell.title1Lbl.numberOfLines = 1000;
    cell.value1Lbl.numberOfLines = 1000;
    
    NSInteger height = 0;
    
    for (int j=0; j<2; j++) {
        RPageSectionRowObj *interRObj=[listOfRowItems objectAtIndex:j];
        
        cell.title1Lbl.text=interRObj.label;
        cell.value1Lbl.text=interRObj.singleValue;
        
        CGRect frame;
        
        
        if ([interRObj.dataType isEqualToString:@"labeltext"]) {
            cell.title1Lbl.hidden = YES;
            frame = cell.value1Lbl.frame;
            frame.size.width += cell.title1Lbl.frame.size.width + 3;
            cell.value1Lbl.frame = frame;
        }
        
        CGRect newFrame = cell.title1Lbl.frame;
        CGSize newSize = [cell.title1Lbl sizeThatFits:CGSizeMake(cell.title1Lbl.frame.size.width, MAXFLOAT)];
        newFrame.size = CGSizeMake(fmaxf(newSize.width, cell.title1Lbl.frame.size.width), newSize.height);
        NSInteger difference1 = (newFrame.size.height) - cell.title1Lbl.frame.size.height;
        
        newFrame = cell.value1Lbl.frame;
        newSize = [cell.value1Lbl sizeThatFits:CGSizeMake(cell.value1Lbl.frame.size.width, MAXFLOAT)];
        newFrame.size = CGSizeMake(fmaxf(newSize.width, cell.value1Lbl.frame.size.width), newSize.height);
        NSInteger difference2 = (newFrame.size.height) - cell.value1Lbl.frame.size.height;
        
        if (difference1 > difference2)
            height += cell.value1Lbl.frame.size.height + 15 + difference1;
        else
            height += cell.value1Lbl.frame.size.height + 15 + difference2;
        
    }
    
    return height;

}

-(CGFloat)tableView:(UITableView *)tblView heightForHeaderInSection:(NSInteger)section
{
        UILabel *sectionLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 2, self.frame.size.width-48, 36)];
        sectionLbl.font=[UIFont boldSystemFontOfSize:17.0];
        sectionLbl.numberOfLines = 1000;
        sectionLbl.text=rObj.label;
        
        CGRect newFrame = sectionLbl.frame;
        CGSize newSize = [sectionLbl sizeThatFits:CGSizeMake(sectionLbl.frame.size.width, MAXFLOAT)];
        newFrame.size = CGSizeMake(fmaxf(newSize.width, sectionLbl.frame.size.width), newSize.height);
        NSInteger difference1 = (newFrame.size.height) - sectionLbl.frame.size.height;
        NSInteger height = sectionLbl.frame.size.height + 5 + difference1;
        if (height < 40)
            height = 40;
        return height;
}

-(UIView*)tableView:(UITableView *)tableView_ viewForHeaderInSection:(NSInteger)section{
    
    CGRect frame = [InnerTableView rectForHeaderInSection:section];
    
    NSInteger height = frame.size.height;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, InnerTableView.frame.size.width, height)];
    //int lable_x=0,semester_x,major_x,lbl_size;
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSTextAlignment align;
    
    int btn_x=0,title_x=0;
    
    if(appDelegate.currentLang==English){
        align=NSTextAlignmentLeft;
        btn_x=self.frame.size.width-36;
        title_x=6;
    }else{
        align=NSTextAlignmentRight;
        btn_x=6;
        title_x=42;
    }
    UILabel *sectionLbl = [[UILabel alloc] initWithFrame:CGRectMake(title_x, 2, self.frame.size.width-48, (height - 4))];
    
    
    sectionLbl.textColor= [UIColor colorWithRed:32.0/255.0 green:145.0/255.0 blue:206.0/255.0 alpha:1];
    sectionLbl.font=[UIFont boldSystemFontOfSize:17.0];
    sectionLbl.textAlignment=align;
    sectionLbl.numberOfLines = 2;
    sectionLbl.adjustsFontSizeToFitWidth=YES;
    
    [sectionLbl setText:rObj.label];
    [view addSubview:sectionLbl];
    
    UIImage *image=nil;
    if ([[rowItemsArray objectAtIndex:section] intValue] == RESET_REQUEST_ROWS)
        image=[UIImage imageNamed:@"arrow_open.png"];
    else
        image=[UIImage imageNamed:@"arrow_close.png"];
    
    
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(btn_x, (height - 30)/ 2, 30, 30)]; // your image size
    imageView.tintColor = [UIColor colorWithRed:32.0/255.0 green:145.0/255.0 blue:206.0/255.0 alpha:1];
    imageView.image = image;
    
    [view addSubview:imageView];
    
    UIButton *Backgroundbtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 320, height)];
    [Backgroundbtn addTarget:self action:@selector(sectionButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    Backgroundbtn.tag=currentRowId;
    [view addSubview:Backgroundbtn];
    
    [view setBackgroundColor:[UIColor whiteColor]];
    
    UIView *separatorView2 = [[UIView alloc] initWithFrame:CGRectMake(0, height - 1, InnerTableView.frame.size.width, 1)];
    [separatorView2 setBackgroundColor:[UIColor colorWithRed:214.0/255.0 green:214.0/255.0 blue:214.0/255.0 alpha:1]];
    [view addSubview:separatorView2];
    
    return view;
}

- (void)tableView:(UITableView *)tView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self showDetails:indexPath.row];
    [InnerTableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)sectionButtonTouchUpInside:(UIButton*)sender {
    
#pragma mark - FIXME CRASH Here ... -
    int row = (int)sender.tag;
    
    int currentRow = row;
    
    if (row >= rowItemsArray.count) {
        currentRow = 0; // Works for all added single rows above List(s)
    }
    
    if ([[rowItemsArray objectAtIndex:(int)currentRow] intValue] == RESET_REQUEST_ROWS) {
        [rowItemsArray replaceObjectAtIndex:currentRow withObject:[NSNumber numberWithInt:(int)[rObj.listValue count]]];
    } else {
        [rowItemsArray replaceObjectAtIndex:currentRow withObject:[NSNumber numberWithInt:RESET_REQUEST_ROWS]];
    }
    
    [self.InnerTableView reloadData];
    
    if (self.delegation != NULL && [self.delegation respondsToSelector:@selector(reloadOuterTable:withRowId:)])
        [delegation reloadOuterTable:[[rowItemsArray objectAtIndex:(int)currentRow] intValue] withRowId:currentRowId];
    
}

-(IBAction)onPressDetails:(id)sender
{
    UIButton *btn = sender;
    [self showDetails:btn.tag];
}

-(void)showDetails:(NSInteger)rowDetials
{
    NSMutableArray *listOfRowsItems = rObj.listValue;
    if (self.delegation != NULL && [self.delegation respondsToSelector:@selector(loadRowItemsView:)])
        [delegation loadRowItemsView:[listOfRowsItems objectAtIndex:rowDetials]];
    
}

@end
