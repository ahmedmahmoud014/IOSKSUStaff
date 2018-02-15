//
//  NewRequestDetailsViewController.m
//  KSU-Staff
//
//  Created by Eman Kassem on 12/3/16.
//  Copyright © 2016 E-Jawdah. All rights reserved.
//

#import "NewRequestDetailsViewController.h"
#import "AppDelegate.h"
#import "BlueHeaderTableViewCell.h"
#import "TitleValueTableViewCell.h"
#import "ValueOnlyTableViewCell.h"
#import "RequestsListTableViewCell.h"
//#import "DetailsActionTableViewCell.h"
#import "RPageSectionObj.h"
#import "RPageSectionRowObj.h"
#import "LocalizedMessages.h"
#import "RequestRowDetailsTableViewCell.h"

@interface NewRequestDetailsViewController () {
    int variableTableIndex;
    NSMutableArray *tempArray;
    CGPoint touchPoint;
    NSIndexPath *senderIndexPath;
    BOOL firstHeaderOnly, firstListOnly;
}

@end

@implementation NewRequestDetailsViewController

@synthesize rowsSectionArray, listOfPageSections, reqTableView, delegation;

#pragma mark - NewRequestDetailsViewController Life Cycle -

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    reqTableView.estimatedRowHeight = 40;
    reqTableView.rowHeight = UITableViewAutomaticDimension;
    
    if (rowsSectionArray == nil) {
        rowsSectionArray = [[NSMutableArray alloc] init];
    } else {
        [rowsSectionArray removeAllObjects];
    }
    
    firstHeaderOnly = YES;
    firstListOnly = YES;
    
    for (RPageSectionObj *sObj in listOfPageSections) {
        [rowsSectionArray addObject:
         [NSMutableDictionary dictionaryWithObjects:@[[NSNumber numberWithInt:(firstHeaderOnly) ? OPENED : CLOSED], sObj, [NSNumber numberWithInt:HEADER_CELL], [NSNumber numberWithInt:ADD]] forKeys:@[STATUS, ITEM, TYPE, ACTION]]];
        if (firstHeaderOnly) {
            firstHeaderOnly = NO;
            for (RPageSectionRowObj *rObj in sObj.rows) {
                NSNumber *type = [self getRequestCellType:rObj];
                NSNumber *action;
                switch ([type intValue]) {
                    case LIST_CELL: {
                        action = [NSNumber numberWithInt:ADD];
                        [rowsSectionArray addObject:
                         [NSMutableDictionary dictionaryWithObjects:@[[NSNumber numberWithInt:(firstListOnly) ? OPENED : CLOSED], rObj, type, action] forKeys:@[STATUS, ITEM, TYPE, ACTION]]];
                        if (firstListOnly) {
                            firstListOnly = NO;
                            
                            NSMutableArray *nestedList = rObj.listValue;
                            
                            for (NSMutableArray *nestedInnerList in nestedList) {
                                
                                if (nestedInnerList.count == 0) {
                                    [rowsSectionArray addObject:
                                     [NSMutableDictionary dictionaryWithObjects:@[[NSNumber numberWithInt:OPENED], rObj, [NSNumber numberWithInt:VALUE_ONLY_CELL], [NSNumber numberWithInt:NOTHING]] forKeys:@[STATUS, ITEM, TYPE, ACTION]]];
                                } else if (nestedInnerList.count == 1) {
                                    [rowsSectionArray addObject:
                                     [NSMutableDictionary dictionaryWithObjects:@[[NSNumber numberWithInt:OPENED], rObj, [NSNumber numberWithInt:TITLE_VALUE_CELL], [NSNumber numberWithInt:NOTHING]] forKeys:@[STATUS, ITEM, TYPE, ACTION]]];
                                } else {
                                    // 2 or more items
                                    [rowsSectionArray addObject:
                                     [NSMutableDictionary dictionaryWithObjects:@[[NSNumber numberWithInt:OPENED], nestedInnerList, [NSNumber numberWithInt:DETAILED_CELL], [NSNumber numberWithInt:DETAILS]] forKeys:@[STATUS, ITEM, TYPE, ACTION]]];
                                }
                            }
                        }
                    }
                        break;
                    case TITLE_VALUE_CELL: {
                        action = [NSNumber numberWithInt:NOTHING];
                        [rowsSectionArray addObject:
                         [NSMutableDictionary dictionaryWithObjects:@[[NSNumber numberWithInt:CLOSED], rObj, [NSNumber numberWithInt:TITLE_VALUE_CELL], [NSNumber numberWithInt:NOTHING]] forKeys:@[STATUS, ITEM, TYPE, ACTION]]];
                    }
                        break;
                    case DETAILED_CELL: {
                        action = [NSNumber numberWithInt:DETAILS];
                        [rowsSectionArray addObject:
                         [NSMutableDictionary dictionaryWithObjects:@[[NSNumber numberWithInt:CLOSED], rObj, type, action] forKeys:@[STATUS, ITEM, TYPE, ACTION]]];
                    }
                        break;
                    case VALUE_ONLY_CELL: {
                        action = [NSNumber numberWithInt:DETAILS];
                        [rowsSectionArray addObject:[NSMutableDictionary dictionaryWithObjects:@[[NSNumber numberWithInt:CLOSED], rObj, [NSNumber numberWithInt:VALUE_ONLY_CELL], action] forKeys:@[STATUS, ITEM, TYPE, ACTION]]];
                    }
                        break;
                    default: {
                        action = [NSNumber numberWithInt:NOTHING];
                        [rowsSectionArray addObject:
                         [NSMutableDictionary dictionaryWithObjects:@[[NSNumber numberWithInt:CLOSED], rObj, type, action] forKeys:@[STATUS, ITEM, TYPE, ACTION]]];
                    }
                        break;
                }
            }
        }
    }
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

#pragma mark - UITableViewDataSource -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return rowsSectionArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *headerCellID = @"BlueHeader_ar";
    BlueHeaderTableViewCell *blueHeader;
    
    static NSString *titleValueCellID = @"TitleValue_ar";
    TitleValueTableViewCell *titleValueCell;
    
    static NSString *valueOnlyCellID = @"ValueOnly";
    ValueOnlyTableViewCell *valueOnlyCell;
    
    static NSString *listCellID = @"List_ar";
    RequestsListTableViewCell *listCell;
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (appDelegate.currentLang == English) {
        headerCellID = @"BlueHeader_en";
        titleValueCellID = @"TitleValue_en";
        listCellID = @"List_en";
    }
    
    switch ([[[rowsSectionArray objectAtIndex:indexPath.row] objectForKey:TYPE] intValue]) {
        case HEADER_CELL: {
            blueHeader = (BlueHeaderTableViewCell *)[self.reqTableView dequeueReusableCellWithIdentifier:headerCellID];
            
            if (blueHeader == nil) {
                blueHeader = [[BlueHeaderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:headerCellID];
            }
            
            RPageSectionObj *sObj = [[RPageSectionObj alloc] init];
            sObj = [[rowsSectionArray objectAtIndex:indexPath.row] objectForKey:ITEM];
            
            blueHeader.headerTitle.text = sObj.sectionName;
            
            [blueHeader.togglingButton addTarget:self action:@selector(sectionButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
            blueHeader.togglingButton.tag = indexPath.row;
            
            UIImage *image=nil;
            
            if ([[[rowsSectionArray objectAtIndex:indexPath.row] objectForKey:STATUS] intValue] == CLOSED)
                image = [UIImage imageNamed:@"arrow_open.png"];
            else
                image = [UIImage imageNamed:@"arrow_close.png"];
            
            blueHeader.togglingImageView.image = image;
            
            [blueHeader setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            blueHeader.layoutMargins = UIEdgeInsetsZero;
            blueHeader.preservesSuperviewLayoutMargins = NO;
            
            [blueHeader setNeedsLayout];
            [blueHeader layoutIfNeeded];
            
            [blueHeader setNeedsUpdateConstraints];
            [blueHeader updateConstraintsIfNeeded];
            
            return blueHeader;
        }
            break;
        case TITLE_VALUE_CELL: {
            titleValueCell = (TitleValueTableViewCell *)[tableView dequeueReusableCellWithIdentifier:titleValueCellID];
            if (titleValueCell == nil) {
                titleValueCell = [[TitleValueTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:titleValueCellID];
            }
            RPageSectionRowObj *obj = [[rowsSectionArray objectAtIndex:indexPath.row] objectForKey:ITEM];
            
            if ([obj.singleValue isEqualToString:@""] || obj.singleValue == nil) {
                obj.singleValue = NoDataFoundMsg;
            }
            
            [titleValueCell.cellTitle setText:obj.label];
            [titleValueCell.cellValue setText:obj.singleValue];
            [titleValueCell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            titleValueCell.layoutMargins = UIEdgeInsetsZero;
            titleValueCell.preservesSuperviewLayoutMargins = NO;
            
            [titleValueCell setNeedsLayout];
            [titleValueCell layoutIfNeeded];
            
            [titleValueCell setNeedsUpdateConstraints];
            [titleValueCell updateConstraintsIfNeeded];
            
            return titleValueCell;
        }
            break;
        case VALUE_ONLY_CELL: {
            valueOnlyCell = (ValueOnlyTableViewCell *)[tableView dequeueReusableCellWithIdentifier:valueOnlyCellID];
            if (valueOnlyCell == nil) {
                valueOnlyCell = [[ValueOnlyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:valueOnlyCellID];
            }
            RPageSectionRowObj *obj = [[rowsSectionArray objectAtIndex:indexPath.row] objectForKey:ITEM];
            
            if ([obj.singleValue isEqualToString:@""] || obj.singleValue == nil) {
                obj.singleValue = NoDataFoundMsg;
            }
            [valueOnlyCell.valueOnly setText:obj.singleValue];
            [valueOnlyCell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            valueOnlyCell.layoutMargins = UIEdgeInsetsZero;
            valueOnlyCell.preservesSuperviewLayoutMargins = NO;
            
            [valueOnlyCell setNeedsLayout];
            [valueOnlyCell layoutIfNeeded];
            
            [valueOnlyCell setNeedsUpdateConstraints];
            [valueOnlyCell updateConstraintsIfNeeded];
            
            return valueOnlyCell;
        }
            break;
        case LIST_CELL: {
            listCell = (RequestsListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:listCellID];
            if (listCell == nil) {
                listCell = [[RequestsListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:listCellID];
            }
            RPageSectionRowObj *obj = [[rowsSectionArray objectAtIndex:indexPath.row] objectForKey:ITEM];
            [listCell.listTitle setText:obj.label];
            
            UIImage *image = nil;
            if ([[[rowsSectionArray objectAtIndex:indexPath.row] objectForKey:STATUS] intValue] == CLOSED)
                image = [UIImage imageNamed:@"arrow_open.png"];
            else
                image = [UIImage imageNamed:@"arrow_close.png"];
            
            
            image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            listCell.togglingImageView.tintColor = [UIColor colorWithRed:32.0/255.0 green:145.0/255.0 blue:206.0/255.0 alpha:1];
            listCell.togglingImageView.image = image;
            
            [listCell.togglingButton addTarget:self action:@selector(listButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
            listCell.togglingButton.tag = indexPath.row;
            
            [listCell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            listCell.layoutMargins = UIEdgeInsetsZero;
            listCell.preservesSuperviewLayoutMargins = NO;
            
            [listCell setNeedsLayout];
            [listCell layoutIfNeeded];
            
            [listCell setNeedsUpdateConstraints];
            [listCell updateConstraintsIfNeeded];
            
            return listCell;
        }
            break;
        case DETAILED_CELL: {
            NSMutableArray *nestedList = [[rowsSectionArray objectAtIndex:indexPath.row] objectForKey:ITEM];
            
            static NSString *CellIdentifier=@"RequestRowDetailsTableViewCell";
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            if(appDelegate.currentLang==English)
                CellIdentifier=@"RequestRowDetailsTableViewCell_en";
            else
                CellIdentifier=@"RequestRowDetailsTableViewCell";
            
            RequestRowDetailsTableViewCell *cell = [reqTableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if (cell == nil) {
                cell = [[RequestRowDetailsTableViewCell alloc]
                        initWithStyle:UITableViewCellStyleDefault
                        reuseIdentifier:CellIdentifier];
            }
            RPageSectionRowObj *obj1 = [nestedList objectAtIndex:0];
            RPageSectionRowObj *obj2 = [nestedList objectAtIndex:1];
            
            CGRect frame = [reqTableView rectForRowAtIndexPath:indexPath];
            [cell initWithRequestRowItemsObj:obj1 obj2:obj2 withRowId:(int)indexPath.row withHeight:frame.size.height ];
            
            cell.detailsBtn.tag = indexPath.row;
            [cell.detailsBtn addTarget:self action:@selector(onPressDetails:) forControlEvents:UIControlEventTouchUpInside];
            
            cell.layoutMargins = UIEdgeInsetsZero;
            cell.preservesSuperviewLayoutMargins = NO;
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            [cell setNeedsLayout];
            [cell layoutIfNeeded];
            
            [cell setNeedsUpdateConstraints];
            [cell updateConstraintsIfNeeded];
            
            return cell;
        }
            break;
        default:
            break;
            
    }
    return nil;
}

#pragma mark - UITableViewDelegate -

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([[[rowsSectionArray objectAtIndex:indexPath.row] objectForKey:TYPE] intValue] == DETAILED_CELL) {
        // Open Details
        [self loadRowItemsView:[[rowsSectionArray objectAtIndex:indexPath.row] objectForKey:ITEM]];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch ([[[rowsSectionArray objectAtIndex:indexPath.row] objectForKey:TYPE] intValue]) {
        case HEADER_CELL: {
            RPageSectionObj *obj = [[rowsSectionArray objectAtIndex:indexPath.row] objectForKey:ITEM];
            CGFloat maxWidth = tableView.frame.size.width - 55;
            UILabel *sectionLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, maxWidth, MAXFLOAT)];
            sectionLbl.numberOfLines = NUMBER_OF_LINES;
            sectionLbl.text = obj.sectionName;
            sectionLbl.font = [UIFont boldSystemFontOfSize:16];
            CGRect newFrame = sectionLbl.frame;
            CGSize newSize = [sectionLbl sizeThatFits:CGSizeMake(sectionLbl.frame.size.width, MAXFLOAT)];
            newFrame.size = CGSizeMake(fmaxf(newSize.width, sectionLbl.frame.size.width), newSize.height);
            
            NSInteger height = [self getLabelHeight:sectionLbl withMaxWidth:maxWidth];
            
            if (height < UITableViewAutomaticDimension)
                height = UITableViewAutomaticDimension;
            return height;
        }
            break;
        case TITLE_VALUE_CELL: {
//            RPageSectionRowObj *rObj = [[rowsSectionArray objectAtIndex:indexPath.row] objectForKey:ITEM];
//            
//            CGFloat titleWidth = 0.33 * (tableView.bounds.size.width - 15);
//            
//            if ([rObj.singleValue isEqualToString:@""] || rObj.singleValue == nil) {
//                rObj.singleValue = NoDataFoundMsg;
//            }
//            
//            UILabel *cellTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, titleWidth, MAXFLOAT)];
//            UILabel *cellValue = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, tableView.frame.size.width - titleWidth, MAXFLOAT)];
//            
//            cellTitle.numberOfLines = NUMBER_OF_LINES;
//            cellValue.numberOfLines = NUMBER_OF_LINES;
//
//            cellTitle.text = rObj.label;
//            cellValue.text = rObj.singleValue;
//            
//            cellTitle.font = [UIFont boldSystemFontOfSize:15];
//            cellValue.font = [UIFont systemFontOfSize:15];
//            
//            [cellTitle sizeToFit];
//            [cellValue sizeToFit];
//            
//            NSInteger titleHeight = [self getLabelHeight:cellTitle withMaxWidth:titleWidth];
//            NSInteger valueHeight = [self getLabelHeight:cellValue withMaxWidth:tableView.frame.size.width - titleWidth];
//            if (titleHeight > valueHeight)
//                return (titleHeight < UITableViewAutomaticDimension) ? UITableViewAutomaticDimension : titleHeight - 5;
//            else
//                return (valueHeight < UITableViewAutomaticDimension) ? UITableViewAutomaticDimension : valueHeight - 5;
            return  UITableViewAutomaticDimension;

        }
            break;
        case VALUE_ONLY_CELL: {
            RPageSectionRowObj *rObj = [[rowsSectionArray objectAtIndex:indexPath.row] objectForKey:ITEM];
            CGFloat maxWidth = tableView.frame.size.width - 10;
            UILabel *valueOnly = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, maxWidth, MAXFLOAT)];
            valueOnly.numberOfLines = NUMBER_OF_LINES;
            
            if ([rObj.singleValue isEqualToString:@""] || rObj.singleValue == nil) {
                rObj.singleValue = NoDataFoundMsg;
            }
            
            valueOnly.text = rObj.singleValue;
            valueOnly.font = [UIFont systemFontOfSize:16];
            
            CGRect newFrame = valueOnly.frame;
            CGSize newSize = [valueOnly sizeThatFits:CGSizeMake(valueOnly.frame.size.width, MAXFLOAT)];
            newFrame.size = CGSizeMake(fmaxf(newSize.width, valueOnly.frame.size.width), newSize.height);
            NSInteger height = [self getLabelHeight:valueOnly withMaxWidth:maxWidth];
            
            return (height < UITableViewAutomaticDimension) ? UITableViewAutomaticDimension : height;
        }
            break;
        case LIST_CELL: {
            RPageSectionRowObj *rObj = [[rowsSectionArray objectAtIndex:indexPath.row] objectForKey:ITEM];
            CGFloat maxWidth = tableView.frame.size.width - 55;
            UILabel *sectionLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, maxWidth, MAXFLOAT)];
            sectionLbl.numberOfLines = NUMBER_OF_LINES;
            sectionLbl.text = rObj.label;
            sectionLbl.font = [UIFont boldSystemFontOfSize:16];

            CGRect newFrame = sectionLbl.frame;
            CGSize newSize = [sectionLbl sizeThatFits:CGSizeMake(sectionLbl.frame.size.width, MAXFLOAT)];
            newFrame.size = CGSizeMake(fmaxf(newSize.width, sectionLbl.frame.size.width), newSize.height);
            NSInteger height = [self getLabelHeight:sectionLbl withMaxWidth:maxWidth];
            
            return (height < UITableViewAutomaticDimension) ? UITableViewAutomaticDimension : height;
//            return UITableViewAutomaticDimension;
        }
            break;
        case DETAILED_CELL: {
            NSMutableArray *nestedList = [[rowsSectionArray objectAtIndex:indexPath.row] objectForKey:ITEM];
            
            static NSString *CellIdentifier=@"RequestRowDetailsTableViewCell";
            
            RequestRowDetailsTableViewCell *rCell = [reqTableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if (rCell == nil) {
                rCell = [[RequestRowDetailsTableViewCell alloc]
                         initWithStyle:UITableViewCellStyleDefault
                         reuseIdentifier:CellIdentifier];
            }
            
            rCell.title1Lbl.numberOfLines = 1000;
            rCell.value1Lbl.numberOfLines = 1000;
            
            
            CGRect newFrame = rCell.title1Lbl.frame;
            CGSize newSize = [rCell.title1Lbl sizeThatFits:CGSizeMake(rCell.title1Lbl.frame.size.width, MAXFLOAT)];
            newFrame.size = CGSizeMake(fmaxf(newSize.width, rCell.title1Lbl.frame.size.width), newSize.height);
            
            NSInteger totlaheight = newFrame.size.height;
            
            for (int j=0; j < 2; j++) {
                RPageSectionRowObj *internalRObj = [nestedList objectAtIndex:j];
                
                
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
            
            
            return totlaheight;
        }
            break;
        default:
            return UITableViewAutomaticDimension;
            break;
            
    }
}

-(void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    // fix for separators bug in iOS 7
//    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}


-(void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    // fix for separators bug in iOS 7
//    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return UITableViewAutomaticDimension;
//}

#pragma mark - Calculate Dynamic Label's Height -

- (NSInteger)getLabelHeight:(UILabel *)label withMaxWidth:(CGFloat)maxWidth {
    CGSize constraint = CGSizeMake(maxWidth, CGFLOAT_MAX);

    NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
    CGSize boundingBox = [label.text boundingRectWithSize:constraint
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:@{NSFontAttributeName:label.font}
                                                  context:context].size;
    
    CGSize size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
    
    return size.height + 15;
}

#pragma mark - Show / Hide Embedded Rows -

- (void)onPressDetails:(UIButton *)sender {
    int index = (int)sender.tag;
    [self loadRowItemsView:[[rowsSectionArray objectAtIndex:index] objectForKey:ITEM]];
}

- (void)loadRowItemsView:(NSMutableArray *)list {
    if (self.delegation != NULL && [self.delegation respondsToSelector:@selector(loadDetailedList:)])
        [delegation loadDetailedList:list];
    
}

- (void)showHideSectionAction:(NSIndexPath *)currentIndexPath {
    tempArray = rowsSectionArray;
    
    int index = (int) currentIndexPath.row;

    if ([[[tempArray objectAtIndex:index] objectForKey:STATUS] intValue] == CLOSED) {
        
#pragma mark - TODO Close any Opened HEADER first -

        RPageSectionObj *sObj = [[rowsSectionArray objectAtIndex:index] objectForKey:ITEM];
        variableTableIndex = index;
        for (RPageSectionRowObj *rObj in sObj.rows) {
            variableTableIndex += 1;
            NSNumber *type = [self getRequestCellType:rObj];
            NSNumber *action;
            switch ([type intValue]) {
                case LIST_CELL: {
                    action = [NSNumber numberWithInt:ADD];
                    [tempArray insertObject:[NSMutableDictionary dictionaryWithObjects:@[[NSNumber numberWithInt:OPENED], rObj, type, action] forKeys:@[STATUS, ITEM, TYPE, ACTION]] atIndex:variableTableIndex];
                    
                    NSMutableArray *nestedList = rObj.listValue;
                    for (NSMutableArray *nestedInnerList in nestedList) {
                        variableTableIndex += 1;
                        if (nestedInnerList.count == 0) {
                            [tempArray insertObject:[NSMutableDictionary dictionaryWithObjects:@[[NSNumber numberWithInt:OPENED], rObj, [NSNumber numberWithInt:VALUE_ONLY_CELL], [NSNumber numberWithInt:NOTHING]] forKeys:@[STATUS, ITEM, TYPE, ACTION]] atIndex:variableTableIndex];
                        } else if (nestedInnerList.count == 1) {
                            [tempArray insertObject:[NSMutableDictionary dictionaryWithObjects:@[[NSNumber numberWithInt:OPENED], rObj, [NSNumber numberWithInt:TITLE_VALUE_CELL], [NSNumber numberWithInt:NOTHING]] forKeys:@[STATUS, ITEM, TYPE, ACTION]] atIndex:variableTableIndex];
                        } else {
                            // 2 or more items
                            [tempArray insertObject:[NSMutableDictionary dictionaryWithObjects:@[[NSNumber numberWithInt:OPENED], nestedInnerList, [NSNumber numberWithInt:DETAILED_CELL], [NSNumber numberWithInt:DETAILS]] forKeys:@[STATUS, ITEM, TYPE, ACTION]] atIndex:variableTableIndex];
                        }
                    }

                }
                    break;
                case VALUE_ONLY_CELL: {
                    action = [NSNumber numberWithInt:DETAILS];
                    [tempArray insertObject:[NSMutableDictionary dictionaryWithObjects:@[[NSNumber numberWithInt:CLOSED], rObj, [NSNumber numberWithInt:VALUE_ONLY_CELL], action] forKeys:@[STATUS, ITEM, TYPE, ACTION]] atIndex:variableTableIndex];
                }
                    break;
                case DETAILED_CELL: {
                    action = [NSNumber numberWithInt:DETAILS];
                    [tempArray insertObject:[NSMutableDictionary dictionaryWithObjects:@[[NSNumber numberWithInt:CLOSED], rObj, [NSNumber numberWithInt:DETAILED_CELL], action] forKeys:@[STATUS, ITEM, TYPE, ACTION]] atIndex:variableTableIndex];
                }
                    break;
                case TITLE_VALUE_CELL: {
                    action = [NSNumber numberWithInt:NOTHING];
                    [tempArray insertObject:[NSMutableDictionary dictionaryWithObjects:@[[NSNumber numberWithInt:CLOSED], rObj, [NSNumber numberWithInt:TITLE_VALUE_CELL], [NSNumber numberWithInt:NOTHING]] forKeys:@[STATUS, ITEM, TYPE, ACTION]] atIndex:variableTableIndex];
                }
                    break;
                default: {
                    action = [NSNumber numberWithInt:NOTHING];
                    [tempArray insertObject:[NSMutableDictionary dictionaryWithObjects:@[[NSNumber numberWithInt:CLOSED], rObj, type, action] forKeys:@[STATUS, ITEM, TYPE, ACTION]] atIndex:variableTableIndex];
                }
                    break;
            }
        }
        
        [[tempArray objectAtIndex:index] setObject:[NSNumber numberWithInt:OPENED] forKey:STATUS];
        
        [reqTableView reloadData];
        // NO NEED
//        [reqTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:index + 1 inSection:currentIndexPath.section] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        
    } else {
        // Close Opened HEADER
        variableTableIndex = index + 1;
        [[tempArray objectAtIndex:index] setObject:[NSNumber numberWithInt:CLOSED] forKey:STATUS];
        RPageSectionObj *sObj = [[rowsSectionArray objectAtIndex:index] objectForKey:ITEM];
        
        for (RPageSectionRowObj *rObj in sObj.rows) {

            if (![rObj.dataType isEqualToString:@"list"]) {
                [tempArray removeObjectAtIndex:variableTableIndex];
            } else {
                // Remove opened items first under List
                if ([[[rowsSectionArray objectAtIndex:variableTableIndex] objectForKey:STATUS] intValue] == OPENED) {
                    NSMutableArray *nestedList = rObj.listValue;
                    
                    for (NSMutableArray *nestedInnerList in nestedList) {
//                        NSLog(@"\nNestedInnerList: %@", nestedInnerList);
                        [tempArray removeObjectAtIndex:variableTableIndex + 1];
                    }
                }
                [tempArray removeObjectAtIndex:variableTableIndex];
            }
            
        }
        
        variableTableIndex = -1;
        [reqTableView reloadData];
    }
}

- (void)sectionButtonTouchUpInside:(UIButton *)sender {
    touchPoint = [sender convertPoint:CGPointZero toView:reqTableView];
    senderIndexPath = [reqTableView indexPathForRowAtPoint:touchPoint];
    [self showHideSectionAction:senderIndexPath];
}

- (void)showHideListAction:(NSIndexPath *)currentIndexPath {
    tempArray = rowsSectionArray;
    
    int index = (int) currentIndexPath.row;
    
    if ([[[tempArray objectAtIndex:index] objectForKey:STATUS] intValue] == CLOSED) {
        
#pragma mark - TODO Close any Opened LIST first -
        
        RPageSectionRowObj *rObj = [[rowsSectionArray objectAtIndex:index] objectForKey:ITEM];
        NSMutableArray *nestedList = rObj.listValue;
        variableTableIndex = index + 1;
        
        for (NSMutableArray *nestedInnerList in nestedList) {
            
            if (nestedInnerList.count == 0) {
                [tempArray insertObject:[NSMutableDictionary dictionaryWithObjects:@[[NSNumber numberWithInt:OPENED], rObj, [NSNumber numberWithInt:VALUE_ONLY_CELL], [NSNumber numberWithInt:NOTHING]] forKeys:@[STATUS, ITEM, TYPE, ACTION]] atIndex:variableTableIndex];
            } else if (nestedInnerList.count == 1) {
                [tempArray insertObject:[NSMutableDictionary dictionaryWithObjects:@[[NSNumber numberWithInt:OPENED], rObj, [NSNumber numberWithInt:TITLE_VALUE_CELL], [NSNumber numberWithInt:NOTHING]] forKeys:@[STATUS, ITEM, TYPE, ACTION]] atIndex:variableTableIndex];
            } else {
                // 2 or more items
                [tempArray insertObject:[NSMutableDictionary dictionaryWithObjects:@[[NSNumber numberWithInt:OPENED], nestedInnerList, [NSNumber numberWithInt:DETAILED_CELL], [NSNumber numberWithInt:DETAILS]] forKeys:@[STATUS, ITEM, TYPE, ACTION]] atIndex:variableTableIndex];
                variableTableIndex += 1;
            }
        }
        
        [[tempArray objectAtIndex:index] setObject:[NSNumber numberWithInt:OPENED] forKey:STATUS];
        
        [reqTableView reloadData];
        
    } else {
        // Close Opened List
        variableTableIndex = index + 1;
        [[tempArray objectAtIndex:index] setObject:[NSNumber numberWithInt:CLOSED] forKey:STATUS];
        RPageSectionRowObj *rObj = [[rowsSectionArray objectAtIndex:index] objectForKey:ITEM];
        
        // Remove opened items first under List
        NSMutableArray *nestedList = rObj.listValue;
        
        for (NSMutableArray *nestedInnerList in nestedList) {
//            NSLog(@"\nNestedInnerList: %@", nestedInnerList);
            [tempArray removeObjectAtIndex:variableTableIndex];
        }
        
        variableTableIndex = -1;
        [reqTableView reloadData];
    }
}

- (void)listButtonTouchUpInside:(UIButton *)sender {
    touchPoint = [sender convertPoint:CGPointZero toView:reqTableView];
    senderIndexPath = [reqTableView indexPathForRowAtPoint:touchPoint];
    [self showHideListAction:senderIndexPath];
}

#pragma mark - Retrieve Cell Type -

- (NSNumber *)getRequestCellType:(RPageSectionRowObj *)rObj {
    
    NSNumber *requestCellType;
//    NSLog(@"Data Type: %@", rObj.dataType);
    if ([rObj.dataType isEqualToString:@"list"]) {
        requestCellType = [NSNumber numberWithInt:LIST_CELL];
    } else if ([rObj.dataType isEqualToString:@"text"] || [rObj.dataType isEqualToString:@"textarea"]) {
        requestCellType = [NSNumber numberWithInt:TITLE_VALUE_CELL];
    } else if ([rObj.dataType isEqualToString:@"labelText"] || [rObj.dataType isEqualToString:@"noData"]) {
        requestCellType = [NSNumber numberWithInt:VALUE_ONLY_CELL];
    } else {
        requestCellType = [NSNumber numberWithInt:DETAILED_CELL];
    }
    
    return requestCellType;
}

@end
