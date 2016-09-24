//
//  PPEGridRow.m
//  EditableGrid
//
//  Created by Alexander Snegursky on 9/24/16.
//  Copyright © 2016 Alexander Snegursky. All rights reserved.
//


#import "PPEGridRow.h"
#import "PPEGridColumnModel.h"
#import "PPEGridTextFieldCell.h"
#import "PPEGridSwitchCell.h"
#import "UIView+Frames.h"


static const CGFloat kHeight = 44.0;


@interface PPEGridRow () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, PPEGridCellDelegate>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, weak, readwrite) id object;
@property (nonatomic, weak, readwrite) NSArray<PPEGridColumnModel *> *columns;

@end


@implementation PPEGridRow


#pragma mark - Getters/Setters


- (void)setXOffset:(CGFloat)xOffset {
    _xOffset = xOffset;
    
    _collectionView.delegate = nil;
    _collectionView.contentOffset = CGPointMake(xOffset, 0.0);
    _collectionView.delegate = self;
}


#pragma mark - PPETableViewCell


+ (CGFloat)height {
    return kHeight;
}


#pragma mark - Public Methods


- (void)configureWithObject:(id)object
                    columns:(NSArray<PPEGridColumnModel *> *)columns
                    xOffset:(CGFloat)xOffset
                   delegate:(id <PPEGridRawDelegate>)delegate {
    self.object = object;
    self.columns = columns;
    self.delegate = delegate;
    self.xOffset = xOffset;
    
    [self update];
}


- (void)update {
    if (_columns.count > 0) {
        [_collectionView reloadData];
    }
}


- (void)updateColumnsWithKeys:(NSArray<NSString *> *)keys {
    NSMutableArray *indexPaths = [NSMutableArray arrayWithCapacity:keys.count];
    
    for (NSString *key in keys) {
        [self.columns enumerateObjectsUsingBlock:^(PPEGridColumnModel * _Nonnull column, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([key isEqualToString:column.key]) {
                [indexPaths addObject:[NSIndexPath indexPathForRow:idx inSection:0]];
                *stop = YES;
            }
        }];
    }
    
    if (indexPaths.count > 0) {
        [UIView performWithoutAnimation:^{
            [self.collectionView reloadItemsAtIndexPaths:indexPaths];
        }];
    }
}


#pragma mark - Lifecycle Methods


- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.multipleTouchEnabled = NO;
    
    [PPEGridTextFieldCell registerForCollectionView:_collectionView];
    [PPEGridSwitchCell registerForCollectionView:_collectionView];
}


#pragma mark - UICollectionViewDelegateFlowLayout


- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    PPEGridColumnModel *column = _columns[indexPath.row];
    return CGSizeMake(column.width, kHeight);
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
}


- (CGFloat)                 collectionView:(UICollectionView *)collectionView
                                    layout:(UICollectionViewLayout *)collectionViewLayout
  minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}


- (CGFloat)             collectionView:(UICollectionView *)collectionView
                                layout:(UICollectionViewLayout *)collectionViewLayout
   minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}


#pragma mark - UICollectionViewDataSource, UICollectionViewDelegate


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _columns.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PPEGridColumnModel *column = _columns[indexPath.row];
    NSString *reuseIdentifier = nil;
    
    switch (column.type) {
        case PPEGridColumnTypeText: {
            reuseIdentifier = [PPEGridTextFieldCell reuseIdentifier];
            break;
        }
        case PPEGridColumnTypeSwitch: {
            reuseIdentifier = [PPEGridSwitchCell reuseIdentifier];
            break;
        }
        case PPEGridColumnTypeUndefined: break;
    }
    
    PPEGridCell *cell = nil;
    
    if (reuseIdentifier) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                                         forIndexPath:indexPath];
        [cell configureWithColumn:column object:_object];
        cell.delegate = self;
    }
    
    return cell;
}


#pragma mark - UIScrollViewDelegate


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_delegate && [_delegate respondsToSelector:@selector(gridRow:didChangeXOffset:)]) {
        [_delegate gridRow:self didChangeXOffset:scrollView.contentOffset.x];
    }
}


#pragma mark - PPEGridCellDelegate


- (BOOL)gridCell:(PPEGridCell *)cell shouldUpdateValue:(id)value {
    if (_delegate && [_delegate respondsToSelector:@selector(gridRow:shouldUpdateValue:onCell:)]) {
        return [_delegate gridRow:self shouldUpdateValue:value onCell:cell];
    }
    
    return YES;
}


- (void)gridCell:(PPEGridCell *)cell didUpdateValue:(id)value {
    if (_delegate && [_delegate respondsToSelector:@selector(gridRow:didUpdateValue:onCell:)]) {
        [_delegate gridRow:self didUpdateValue:value onCell:cell];
    }
}

@end
