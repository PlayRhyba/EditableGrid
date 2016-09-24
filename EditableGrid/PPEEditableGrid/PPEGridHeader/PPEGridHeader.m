//
//  PPEGridHeader.m
//  EditableGrid
//
//  Created by Alexander Snegursky on 9/24/16.
//  Copyright © 2016 Alexander Snegursky. All rights reserved.
//


#import "PPEGridHeader.h"
#import "PPEGridColumnModel.h"
#import "PPEGridHeaderCell.h"


static const CGFloat kHeight = 50.0;


@interface PPEGridHeader () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, PPEGridCellDelegate>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

- (void)update;

@end


@implementation PPEGridHeader


#pragma mark - PPETableViewHeaderFooterView


+ (CGFloat)height {
    return kHeight;
}


#pragma mark - Getters/Setters


- (void)setColumns:(NSArray<PPEGridColumnModel *> *)columns {
    _columns = columns;
    [self update];
}


- (void)setXOffset:(CGFloat)xOffset {
    _xOffset = xOffset;
    
    _collectionView.delegate = nil;
    _collectionView.contentOffset = CGPointMake(xOffset, 0.0);
    _collectionView.delegate = self;
}


#pragma mark - Lifecycle Methods


- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.containerView.backgroundColor = [UIColor clearColor];
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.multipleTouchEnabled = NO;
    
    [PPEGridHeaderCell registerForCollectionView:_collectionView];
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


- (CGFloat)                collectionView:(UICollectionView *)collectionView
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


- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return _columns.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PPEGridHeaderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[PPEGridHeaderCell reuseIdentifier]
                                                                        forIndexPath:indexPath];
    [cell configureWithColumn: _columns[indexPath.row] object:nil];
    cell.delegate = self;
    
    return cell;
}


#pragma mark - UIScrollViewDelegate


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_delegate && [_delegate respondsToSelector:@selector(gridHeader:didChangeXOffset:)]) {
        [_delegate gridHeader:self didChangeXOffset:scrollView.contentOffset.x];
    }
}


#pragma mark - Internal Logic


- (void)update {
    if (_columns.count > 0) {
        [_collectionView reloadData];
    }
}

@end
