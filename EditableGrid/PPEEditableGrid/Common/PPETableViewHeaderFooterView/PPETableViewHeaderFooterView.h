//
//  PPETableViewHeaderFooterView.h
//  EditableGrid
//
//  Created by Alexander Snegursky on 9/23/16.
//  Copyright © 2016 Alexander Snegursky. All rights reserved.
//


#import <UIKit/UIKit.h>


@interface PPETableViewHeaderFooterView : UITableViewHeaderFooterView

@property (nonatomic, weak) IBOutlet UIView *containerView;
@property (nonatomic) NSInteger sectionIndex;

+ (CGFloat)height;
+ (NSString *)reuseIdentifier;
+ (void)registerForTableView:(UITableView *)tableView;

@end
