//
//  PPEEditableGrid.m
//  EditableGrid
//
//  Created by Alexander Snegursky on 9/24/16.
//  Copyright © 2016 Alexander Snegursky. All rights reserved.
//


#import "PPEEditableGrid.h"
#import "PPEGridHeader.h"
#import "PPEGridRow.h"
#import "PPEGridColumnModel.h"
#import "NSObject+NibLoading.h"


@interface PPEEditableGrid () <UITableViewDataSource, UITableViewDelegate, PPEGridHeaderDelegate, PPEGridRawDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *objects;
@property (nonatomic, strong) NSArray<PPEGridColumnModel *> *columns;
@property (nonatomic) CGFloat xOffset;
@property (nonatomic, strong) PPEGridHeader *tableHeader;

- (IBAction)addButtonClicked:(UIButton *)sender;

@end


@implementation PPEEditableGrid


#pragma mark - Public Methods


+ (CGFloat)widthWithColumns:(NSArray<PPEGridColumnModel *> *)columns
                   maxWidth:(CGFloat)maxWidth {
    CGFloat width = 0.0;
    
    for (PPEGridColumnModel *column in columns) {
        width += column.width;
        
        if (width > maxWidth) {
            return maxWidth;
        }
    }
    
    return width;
}


- (instancetype)initWithObjects:(NSArray *)objects
                        columns:(NSArray<PPEGridColumnModel *> *)columns
                       delegate:(id<PPEEditableGridDelegate>)delegate {
    self = [[self class]loadFromNib];
    
    if (self) {
        _objects = objects;
        _columns = columns;
        _delegate = delegate;
        _xOffset = 0.0;
        
        self.backgroundColor = _tableView.backgroundColor = [UIColor clearColor];
        
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.bounces = NO;
        _tableView.layer.borderWidth = 2.0;
        
        [PPEGridHeader registerForTableView:_tableView];
        [PPEGridRow registerForTableView:_tableView];
        
        [_tableView reloadData];
    }
    
    return self;
}


- (void)scrollToBottomAnimated:(BOOL)animated {
    NSInteger numberOfItems = [_tableView numberOfRowsInSection:0];
    
    if (numberOfItems > 0) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:numberOfItems - 1 inSection:0];
        [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:animated];
    }
}


- (void)scrollToTopAnimated:(BOOL)animated {
    NSInteger numberOfItems = [_tableView numberOfRowsInSection:0];
    
    if (numberOfItems > 0) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
        [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:animated];
    }
}


- (void)updateWithObjects:(NSArray *)objects {
    self.objects = objects;
    [_tableView reloadData];
}


- (BOOL)containsColumnWithKey:(NSString *)key {
    if (key) {
        for (PPEGridColumnModel *column in _columns) {
            if ([column.key isEqualToString:key]) {
                return YES;
            }
        }
    }
    
    return NO;
}


#pragma mark - IBAction


- (IBAction)addButtonClicked:(UIButton *)sender {
    [_tableView endEditing:YES];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didAddButtonClickedOnGrid:)]) {
        [self.delegate didAddButtonClickedOnGrid:self];
    }
}


#pragma mark - UITableViewDataSource, UITableViewDelegate


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [PPEGridHeader height];
}


- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    self.tableHeader = [tableView dequeueReusableHeaderFooterViewWithIdentifier:[PPEGridHeader reuseIdentifier]];
    _tableHeader.columns = _columns;
    _tableHeader.xOffset = _xOffset;
    _tableHeader.delegate = self;
    
    return _tableHeader;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _objects.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return [PPEGridRow height];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PPEGridRow *cell = [tableView dequeueReusableCellWithIdentifier:[PPEGridRow reuseIdentifier]];
    
    [cell configureWithObject:_objects[indexPath.row]
                      columns:_columns
                      xOffset:_xOffset
                     delegate:self];
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    BOOL canEdit = YES;
    
    if (_delegate && [_delegate respondsToSelector:@selector(editableGrid:shouldDeleteObject:)]) {
        canEdit = [_delegate editableGrid:self shouldDeleteObject:_objects[indexPath.row]];
    }
    
    return canEdit;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [tableView endEditing:YES];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(editableGrid:didDeleteObject:)]) {
            [self.delegate editableGrid:self didDeleteObject:self.objects[indexPath.row]];
        }
    }
}


#pragma mark - PPEGridHeaderDelegate


- (void)gridHeader:(PPEGridHeader *)header didChangeXOffset:(CGFloat)xOffset {
    self.xOffset = xOffset;
    
    for (PPEGridRow *cell in [_tableView visibleCells]) {
        cell.xOffset = _xOffset;
    }
}


#pragma mark - PPEGridRawDelegate


- (void)gridRow:(PPEGridRow *)cell didChangeXOffset:(CGFloat)xOffset {
    self.xOffset = xOffset;
    
    for (PPEGridRow *visibleCell in [_tableView visibleCells]) {
        if (visibleCell != cell) {
            visibleCell.xOffset = _xOffset;
        }
    }
    
    _tableHeader.xOffset = _xOffset;
}


- (BOOL)gridRow:(PPEGridRow *)row shouldUpdateValue:(id)value onCell:(PPEGridCell *)cell {
    if (_delegate && [_delegate respondsToSelector:@selector(editableGrid:shouldUpdateValue:onCell:onRow:)]) {
        return [_delegate editableGrid:self shouldUpdateValue:value onCell:cell onRow:row];
    }
    
    return YES;
}


- (void)gridRow:(PPEGridRow *)row didUpdateValue:(id)value onCell:(PPEGridCell *)cell {
    if (_delegate && [_delegate respondsToSelector:@selector(editableGrid:didUpdateValue:onCell:onRow:)]) {
        [_delegate editableGrid:self didUpdateValue:value onCell:cell onRow:row];
    }
}

@end
