//
//  PPETableViewCell.h
//  EditableGrid
//
//  Created by Alexander Snegursky on 9/23/16.
//  Copyright © 2016 Alexander Snegursky. All rights reserved.
//


#import <UIKit/UIKit.h>


@interface PPETableViewCell : UITableViewCell

+ (NSString *)reuseIdentifier;
+ (CGFloat)height;
+ (void)registerForTableView:(UITableView *)tableView;

@end
