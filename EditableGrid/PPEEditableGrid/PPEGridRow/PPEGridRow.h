//
//  PPEGridRow.h
//  EditableGrid
//
//  Created by Alexander Snegursky on 9/24/16.
//  Copyright © 2016 Alexander Snegursky. All rights reserved.
//


#import "PPETableViewCell.h"


@class PPEGridColumnModel;
@class PPEGridRow;
@class PPEGridCell;


@protocol PPEGridRawDelegate <NSObject>

- (void)gridRow:(PPEGridRow *)row didChangeXOffset:(CGFloat)xOffset;

@optional

- (BOOL)gridRow:(PPEGridRow *)row shouldUpdateValue:(id)value onCell:(PPEGridCell *)cell;
- (void)gridRow:(PPEGridRow *)row didUpdateValue:(id)value onCell:(PPEGridCell *)cell;

@end


@interface PPEGridRow : PPETableViewCell

@property (nonatomic, weak, readonly) id object;
@property (nonatomic, weak, readonly) NSArray<PPEGridColumnModel *> *columns;
@property (nonatomic, readonly) BOOL isEnabled;
@property (nonatomic) CGFloat xOffset;
@property (nonatomic, weak) id <PPEGridRawDelegate> delegate;

- (void)configureWithObject:(id)object
                    columns:(NSArray<PPEGridColumnModel *> *)columns
                    xOffset:(CGFloat)xOffset
                   delegate:(id <PPEGridRawDelegate>)delegate;
- (void)update;
- (void)updateColumnsWithKeys:(NSArray<NSString *> *)keys;

@end
