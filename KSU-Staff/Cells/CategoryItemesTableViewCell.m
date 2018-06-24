//
//  CategoryItemesTableViewCell.m
//  KSU-Staff
//
//  Created by iOSAccount on 11/6/17.
//  Copyright © 2017 E-Jawdah. All rights reserved.
//

#import "CategoryItemesTableViewCell.h"
#import "CategoryListItems.h"
#import "FLAnimatedImageView+WebCache.h"
#import "UIImageView+WebCache.h"

@implementation CategoryItemesTableViewCell
@synthesize itemName,itemImage,itemDiscount,like,disLike,status,statusImage,expire_date;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)initWithCatItemObj:(CategoryListItems*)obj withRowId:(int)rowId{
    catItem=obj;
    itemName.text= catItem.title;
//    NSString *str = @"hello ";
//    str = [str stringByAppendingString:@"world"];
    itemDiscount.text = [NSString stringWithFormat: @"%@ %@" ,(catItem.discount_perc).stringValue,@"٪ خصم "];
    like.text= (catItem.likes).stringValue;
    disLike.text= (catItem.dislikes).stringValue;
    NSString *status_Value= catItem.status;
    status.text= status_Value;
    if([status_Value isEqual:@"open"]){
        statusImage.image = [UIImage imageNamed:@"open"];
    }
    else {
        statusImage.image = [UIImage imageNamed:@"featured"];
    }
    
    NSString *date_value = catItem.expiration_date  ;
    if(![date_value  isEqual:@""]){
        NSString * timeStampString =date_value;
        NSTimeInterval _interval=[timeStampString doubleValue];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
        NSDateFormatter *_formatter=[[NSDateFormatter alloc]init];
        [_formatter setDateFormat:@"dd/MM/yyyy"];
        expire_date.text=[_formatter stringFromDate:date];
       
       

        
    }else{
        expire_date.text=@"no date";

    }
   
    
   // [itemImage setImage :[NSURL URLWithString:catItem.slide_images[0]]];
    
//    NSString *imageFromUrl= catItem.slide_images[0];
//    NSURL *url = [NSURL URLWithString:imageFromUrl];
//    NSData *data = [NSData dataWithContentsOfURL:url];
//    UIImage *image = [UIImage imageWithData:data];
    itemImage.layer.borderWidth = .5f;
    itemImage.layer.borderColor = [[UIColor grayColor] CGColor];
    
    [itemImage sd_setImageWithURL:[NSURL URLWithString:catItem.slide_images[0]]
                  placeholderImage:[UIImage imageNamed:@"loader"]
                           options:SDWebImageRefreshCached];
    
  //  [itemImage setImage:catItem.slide_images[0]];
    
//
    
    
    
    
}



@end
