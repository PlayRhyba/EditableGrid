//
//  PPEGridCell.h
//  EditableGrid
//
//  Created by Alexander Snegursky on 9/24/16.
//  Copyright © 2016 Alexander Snegursky. All rights reserved.
//


#import "PPECollectionViewCell.h"
#import "PPEGridColumnModel.h"


@class PPEGridCell;


@protocol PPEGridCellDelegate <NSObject>

@optional

- (BOOL)gridCell:(PPEGridCell *)cell shouldUpdateValue:(id)value;
- (void)gridCell:(PPEGridCell *)cell didUpdateValue:(id)value;

@end


@interface PPEGridCell : PPECollectionViewCell

@property (nonatomic, weak, readonly) PPEGridColumnModel *column;
@property (nonatomic, weak, readonly) id object;
@property (nonatomic, weak) id <PPEGridCellDelegate> delegate;

- (void)configureWithColumn:(PPEGridColumnModel *)column
                     object:(id)object;

- (BOOL)shouldUpdateValue:(id)value;
- (void)update;

@end
