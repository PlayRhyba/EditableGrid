//
//  PPEGridHeader.h
//  EditableGrid
//
//  Created by Alexander Snegursky on 9/24/16.
//  Copyright © 2016 Alexander Snegursky. All rights reserved.
//


#import "PPETableViewHeaderFooterView.h"


@class PPEGridHeader;
@class PPEGridColumnModel;


@protocol PPEGridHeaderDelegate <NSObject>

- (void)gridHeader:(PPEGridHeader *)header didChangeXOffset:(CGFloat)xOffset;

@end


@interface PPEGridHeader : PPETableViewHeaderFooterView

@property (nonatomic, weak) NSArray<PPEGridColumnModel *> *columns;
@property (nonatomic) CGFloat xOffset;
@property (nonatomic, weak) id <PPEGridHeaderDelegate> delegate;

@end
