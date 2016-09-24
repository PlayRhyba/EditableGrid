//
//  PPETableViewHeaderFooterView.m
//  EditableGrid
//
//  Created by Alexander Snegursky on 9/23/16.
//  Copyright © 2016 Alexander Snegursky. All rights reserved.
//


#import "PPETableViewHeaderFooterView.h"
#import "NSObject+NibLoading.h"


@implementation PPETableViewHeaderFooterView


#pragma mark - Public Methods


+ (CGFloat)height {
    return 0.0;
}


+ (NSString *)reuseIdentifier {
    return NSStringFromClass([self class]);
}


+ (void)registerForTableView:(UITableView *)tableView {
    [tableView registerNib:[self nib] forHeaderFooterViewReuseIdentifier:[[self class]reuseIdentifier]];
}

@end
