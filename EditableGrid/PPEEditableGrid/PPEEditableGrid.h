//
//  PPEEditableGrid.h
//  EditableGrid
//
//  Created by Alexander Snegursky on 9/24/16.
//  Copyright © 2016 Alexander Snegursky. All rights reserved.
//


#import <UIKit/UIKit.h>


@class PPEGridColumnModel;
@class PPEEditableGrid;
@class PPEGridRow;
@class PPEGridCell;


@protocol PPEEditableGridDelegate <NSObject>

- (void)didAddButtonClickedOnGrid:(PPEEditableGrid *)grid;
- (void)editableGrid:(PPEEditableGrid *)grid didDeleteObject:(id)object;

@optional

- (BOOL)editableGrid:(PPEEditableGrid *)grid shouldDeleteObject:(id)object;
- (BOOL)editableGrid:(PPEEditableGrid *)grid shouldUpdateValue:(id)value onCell:(PPEGridCell *)cell onRow:(PPEGridRow *)row;
- (void)editableGrid:(PPEEditableGrid *)grid didUpdateValue:(id)value onCell:(PPEGridCell *)cell onRow:(PPEGridRow *)row;

@end


@interface PPEEditableGrid : UIView

@property (nonatomic, weak) id <PPEEditableGridDelegate> delegate;

+ (CGFloat)widthWithColumns:(NSArray<PPEGridColumnModel *> *)columns
                   maxWidth:(CGFloat)maxWidth;

- (instancetype)initWithObjects:(NSArray *)objects
                        columns:(NSArray<PPEGridColumnModel *> *)columns
                       delegate:(id<PPEEditableGridDelegate>)delegate;

- (void)updateWithObjects:(NSArray *)objects;
- (BOOL)containsColumnWithKey:(NSString *)key;
- (void)scrollToBottomAnimated:(BOOL)animated;
- (void)scrollToTopAnimated:(BOOL)animated;

@end
