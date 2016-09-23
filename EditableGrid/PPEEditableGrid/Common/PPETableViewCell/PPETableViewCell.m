//
//  PPECollectionViewCell.h
//  EditableGrid
//
//  Created by Alexander Snegursky on 9/23/16.
//  Copyright © 2016 Alexander Snegursky. All rights reserved.
//


#import "PPETableViewCell.h"
#import "NSObject+NibLoading.h"


@implementation PPETableViewCell


#pragma mark - Public Methods


+ (NSString *)reuseIdentifier {
    return NSStringFromClass([self class]);
}

+ (CGFloat)height {
    return 0.0;
}

+ (void)registerForTableView:(UITableView *)tableView {
    [tableView registerNib:[self nib] forCellReuseIdentifier:[[self class]reuseIdentifier]];
}

@end
