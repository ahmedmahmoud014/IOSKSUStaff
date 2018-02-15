//
//  PageContentViewController.m
//  PageViewDemo
//
//  Created by Simon on 24/11/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "RequestPageDetailsViewController.h"
#import "RPageSectionObj.h"
#import "RPageSectionRowObj.h"
#import "RequestPageDetailsTableViewCell.h"
#import "RequestRowDetailsTableViewCell.h"
#import "AppDelegate.h"

@interface RequestPageDetailsViewController ()

@end

@implementation RequestPageDetailsViewController

@synthesize requestsTableView;
@synthesize listOfPageSections;
@synthesize rowsSectionArray;
@synthesize delegation;

NSInteger rowItemsCounter;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    requestsTableView.layoutMargins = UIEdgeInsetsZero;
    if ([requestsTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [requestsTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    //listOfPageSections = [[NSMutableArray alloc] init];
    requestsTableView.contentOffset = CGPointMake(0.0, 0.0);
    
    [self expandTableSections];
    rowItemsCounter = -1;
    [self.requestsTableView reloadData];

    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - methods



-(void)expandTableSections{
    if(rowsSectionArray==nil)
        rowsSectionArray=[[NSMutableArray alloc] init];
    else{
        [rowsSectionArray removeAllObjects];
    }
    
    /*RPageObj *pObj = [[RPageObj alloc] init];
    pObj = [listOfPages objectAtIndex:0];
    listOfPageSections = pObj.sections;*/
    for(int i=0;i< [listOfPageSections count];i++){
        if (i == 0) {
            RPageSectionObj *sObj = [[RPageSectionObj alloc] init];
            sObj = [listOfPageSections objectAtIndex:i];
            
            [rowsSectionArray addObject:[NSNumber numberWithInt:(int)[sObj.rows count]]];
        }
        else
        {
            [rowsSectionArray addObject:[NSNumber numberWithInt:0]];
        }
    }
}

#pragma mark - cell delegate
- (void)reloadOuterTable:(NSInteger)count withRowId:(NSInteger)withRowId {
    rowItemsCounter = count;
    [UIView setAnimationsEnabled:NO];
    [requestsTableView beginUpdates];
    [requestsTableView endUpdates];
    [UIView setAnimationsEnabled:YES];
}

-(void)loadRowItemsView:(NSMutableArray *)list{
    if (self.delegation != NULL && [self.delegation respondsToSelector:@selector(loadRowDetailsView:)])
        [delegation loadRowDetailsView:list];
    
}

#pragma mark - table delegate
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier=@"RequestPageDetailsTableViewCell";
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(appDelegate.currentLang==English)
        CellIdentifier=@"RequestPageDetailsTableViewCell_en";
    else
        CellIdentifier=@"RequestPageDetailsTableViewCell";
    
    RequestPageDetailsTableViewCell *cell = [self.requestsTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[RequestPageDetailsTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    RPageSectionRowObj *obj=nil;

    RPageSectionObj *sObj = [[RPageSectionObj alloc] init];
    NSMutableArray *listOfSectionRows;
    if (requestsTableView == tableView) {
        sObj = [listOfPageSections objectAtIndex:indexPath.section];
        listOfSectionRows = sObj.rows;
        obj=[listOfSectionRows objectAtIndex:(int)indexPath.row];
    }
    
    CGRect frame = [requestsTableView rectForRowAtIndexPath:indexPath];
    cell.delegation=self;
    [cell initWithRequestSectionRowObj:obj withRowId:(int)indexPath.row withHeight:frame.size.height];
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.preservesSuperviewLayoutMargins = NO;
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tblView numberOfRowsInSection:(NSInteger)section{
    
    return [[rowsSectionArray objectAtIndex:(int)section] intValue];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tblView {

    return [listOfPageSections count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    RPageSectionObj *sObj = [[RPageSectionObj alloc] init];
    NSMutableArray *listOfSectionRows;
    RPageSectionRowObj *rObj;
    
    if (requestsTableView == tableView) {
        sObj = [listOfPageSections objectAtIndex:indexPath.section];
        listOfSectionRows = sObj.rows;
        rObj=[listOfSectionRows objectAtIndex:(int)indexPath.row];
    }
   
    
    static NSString *CellIdentifier=@"RequestPageDetailsTableViewCell";
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(appDelegate.currentLang==English)
        CellIdentifier=@"RequestPageDetailsTableViewCell_en";
    else
        CellIdentifier=@"RequestPageDetailsTableViewCell";
    
    RequestPageDetailsTableViewCell *pCell = [self.requestsTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (pCell == nil) {
        pCell = [[RequestPageDetailsTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    
    pCell.titleLbl.numberOfLines = 1000;
    pCell.valueLbl.numberOfLines = 1000;
    
    pCell.titleLbl.text=rObj.label;
    pCell.valueLbl.text=rObj.singleValue;
    
    CGRect frame;
    
    if (![rObj.dataType isEqualToString:@"list"]) {

        if ([rObj.dataType isEqualToString:@"labeltext"]) {
            pCell.titleLbl.hidden = YES;
            frame = pCell.valueLbl.frame;
            frame.size.width += pCell.titleLbl.frame.size.width + 3;
            pCell.valueLbl.frame = frame;
        }
        
        CGRect newFrame = pCell.titleLbl.frame;
        CGSize newSize = [pCell.titleLbl sizeThatFits:CGSizeMake(pCell.titleLbl.frame.size.width, MAXFLOAT)];
        newFrame.size = CGSizeMake(fmaxf(newSize.width, pCell.titleLbl.frame.size.width), newSize.height);
        NSInteger difference1 = (newFrame.size.height) - pCell.titleLbl.frame.size.height;
        
        newFrame = pCell.valueLbl.frame;
        newSize = [pCell.valueLbl sizeThatFits:CGSizeMake(pCell.valueLbl.frame.size.width, MAXFLOAT)];
        newFrame.size = CGSizeMake(fmaxf(newSize.width, pCell.valueLbl.frame.size.width), newSize.height);
        NSInteger difference2 = (newFrame.size.height) - pCell.valueLbl.frame.size.height;
        
        NSInteger height = 0;
        
        if (difference1 > difference2)
            height = pCell.valueLbl.frame.size.height + 15 + difference1;
        else
            height = pCell.valueLbl.frame.size.height + 15 + difference2;
        
        
        return height;
    }
    else
    {
        
        static NSString *CellIdentifier=@"RequestRowDetailsTableViewCell";
        
        RequestRowDetailsTableViewCell *rCell = [self.requestsTableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (rCell == nil) {
            rCell = [[RequestRowDetailsTableViewCell alloc]
                     initWithStyle:UITableViewCellStyleDefault
                     reuseIdentifier:CellIdentifier];
        }
        
        rCell.title1Lbl.numberOfLines = 1000;
        rCell.value1Lbl.numberOfLines = 1000;
        
        
        CGRect newFrame = pCell.titleLbl.frame;
        CGSize newSize = [pCell.titleLbl sizeThatFits:CGSizeMake(pCell.titleLbl.frame.size.width, MAXFLOAT)];
        newFrame.size = CGSizeMake(fmaxf(newSize.width, pCell.titleLbl.frame.size.width), newSize.height);
        
        NSInteger totlaheight =newFrame.size.height;
        
        if (totlaheight < 40) {
            totlaheight = 40;
        }
        
        if (rowItemsCounter == -1 || rowItemsCounter > 0) {
            for (int i = 0; i < [rObj.listValue count]; i++) {
                
                
                NSMutableArray *internalObjItems = [rObj.listValue objectAtIndex:i];
                
                for (int j=0; j < 2; j++) {
                    RPageSectionRowObj *internalRObj=[internalObjItems objectAtIndex:j];
                    
                    
                    rCell.title1Lbl.text=internalRObj.label;
                    rCell.value1Lbl.text=internalRObj.singleValue;
                    
                    
                    CGRect newFrame = rCell.title1Lbl.frame;
                    CGSize newSize = [rCell.title1Lbl sizeThatFits:CGSizeMake(rCell.title1Lbl.frame.size.width, MAXFLOAT)];
                    newFrame.size = CGSizeMake(fmaxf(newSize.width, rCell.title1Lbl.frame.size.width), newSize.height);
                    NSInteger difference1 = (newFrame.size.height) - rCell.title1Lbl.frame.size.height;
                    
                    newFrame = rCell.value1Lbl.frame;
                    newSize = [rCell.value1Lbl sizeThatFits:CGSizeMake(rCell.value1Lbl.frame.size.width, MAXFLOAT)];
                    newFrame.size = CGSizeMake(fmaxf(newSize.width, rCell.value1Lbl.frame.size.width), newSize.height);
                    NSInteger difference2 = (newFrame.size.height) - rCell.value1Lbl.frame.size.height;
                    
                    NSInteger height = 0;
                    
                    if (difference1 > difference2)
                        height = rCell.value1Lbl.frame.size.height + 15 + difference1;
                    else
                        height = rCell.value1Lbl.frame.size.height + 15 + difference2;
                    
                    
                    totlaheight += height;
                }
                
            }
        } else return 40;
        
        
        return totlaheight;
    }
    

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[self showDetails:indexPath.row];
    [requestsTableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)sectionButtonTouchUpInside:(UIButton*)sender {
    
    // Don't Open / Close if Only one Section Exists in page
    
    if (rowsSectionArray.count > 1) {
        int section = (int)sender.tag;
        if ([[rowsSectionArray objectAtIndex:(int)section] intValue] == 0) {
            for (int i = 0; i < [listOfPageSections count]; i++) {
                if (i == section) {
                    RPageSectionObj *sObj = [[RPageSectionObj alloc] init];
                    sObj = [listOfPageSections objectAtIndex:section];
                    [rowsSectionArray replaceObjectAtIndex:section withObject:[NSNumber numberWithInt:(int)[sObj.rows count]]];
                } else {
                    [rowsSectionArray replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:0]];
                }
                
            }
        } else {
            [rowsSectionArray replaceObjectAtIndex:section withObject:[NSNumber numberWithInt:0]];
        }
        
        rowItemsCounter = -1;
        [self.requestsTableView reloadData];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (tableView == requestsTableView) {
        RPageSectionObj *obj=[listOfPageSections objectAtIndex:section];
        
        //obj.sectionName
        
        UILabel *sectionLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 2, self.view.frame.size.width-48, 36)];
        sectionLbl.numberOfLines = 5;
        sectionLbl.numberOfLines = 1000;
        sectionLbl.text=obj.sectionName;
        
        CGRect newFrame = sectionLbl.frame;
        CGSize newSize = [sectionLbl sizeThatFits:CGSizeMake(sectionLbl.frame.size.width, MAXFLOAT)];
        newFrame.size = CGSizeMake(fmaxf(newSize.width, sectionLbl.frame.size.width), newSize.height);
        NSInteger difference1 = (newFrame.size.height) - sectionLbl.frame.size.height;
        NSInteger height = sectionLbl.frame.size.height + 5 + difference1;
        if (height < 40)
            height = 40;
        return height;
    }

    return 1;
    
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (requestsTableView == tableView) {
        CGRect frame = [tableView rectForHeaderInSection:section];
        
        NSInteger height = frame.size.height;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, height)];
        //int lable_x=0,semester_x,major_x,lbl_size;
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        NSTextAlignment align;
        
        int btn_x=0,title_x=0;
        
        if(appDelegate.currentLang==English){
            align=NSTextAlignmentLeft;
            btn_x=self.view.frame.size.width-36;
            title_x=6;
        }else{
            align=NSTextAlignmentRight;
            btn_x=6;
            title_x=42;
        }
        UILabel *sectionLbl = [[UILabel alloc] initWithFrame:CGRectMake(title_x, 2, self.view.frame.size.width-48, (height - 4))];
        
        
        sectionLbl.textColor=[UIColor whiteColor];
        sectionLbl.font=[UIFont boldSystemFontOfSize:16.0];
        sectionLbl.textAlignment=align;
        sectionLbl.numberOfLines = 5;
        sectionLbl.adjustsFontSizeToFitWidth=YES;
        
        RPageSectionObj *obj=[listOfPageSections objectAtIndex:section];
        
        [sectionLbl setText:obj.sectionName];
        [view addSubview:sectionLbl];
        
        
        UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(btn_x, (height - 30)/ 2, 30, 30)];
        [btn addTarget:self action:@selector(sectionButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag=section;
        UIImage *image=nil;
        
        if ([[rowsSectionArray objectAtIndex:section] intValue] == 0)
            image=[UIImage imageNamed:@"arrow_open.png"];
        else
            image=[UIImage imageNamed:@"arrow_close.png"];
        
        
        [btn setBackgroundImage:image forState:UIControlStateNormal];
        [view addSubview:btn];
        
        /*UIImage *newImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
         UIImageView *imageView = [[UIImageView alloc] initWithFrame:btn.frame]; // your image size
         imageView.tintColor = [UIColor colorWithRed:75.0/255.0 green:193.0/255.0 blue:239.0/255.0 alpha:1];
         imageView.image = newImage;
         [view addSubview:imageView];*/
        
        UIButton *Backgroundbtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 320, height)];
        [Backgroundbtn addTarget:self action:@selector(sectionButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        Backgroundbtn.tag=section;
        [view addSubview:Backgroundbtn];
        
        [view setBackgroundColor:[UIColor colorWithRed:32.0/255.0 green:145.0/255.0 blue:206.0/255.0 alpha:1]];
        
        UIView *separatorView = [[UIView alloc] initWithFrame:CGRectMake(0, height - 1, tableView.frame.size.width, 1)];
        [separatorView setBackgroundColor:[UIColor colorWithRed:214.0/255.0 green:214.0/255.0 blue:214.0/255.0 alpha:1]];
        [view addSubview:separatorView];
        
        return view;
    }
    return nil;
    
}


@end
