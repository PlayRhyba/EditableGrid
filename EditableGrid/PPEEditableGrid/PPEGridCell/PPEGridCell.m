//
//  PPEGridCell.m
//  EditableGrid
//
//  Created by Alexander Snegursky on 9/24/16.
//  Copyright © 2016 Alexander Snegursky. All rights reserved.
//


#import "PPEGridCell.h"


@interface PPEGridCell ()

@property (nonatomic, weak, readwrite) PPEGridColumnModel *column;
@property (nonatomic, weak, readwrite) id object;

@end


@implementation PPEGridCell


#pragma mark - Public Methods


- (void)configureWithColumn:(PPEGridColumnModel *)column
                     object:(id)object {
    self.column = column;
    self.object = object;
    
    [self update];
}


- (BOOL)shouldUpdateValue:(id)value {
    BOOL shouldUpdate = YES;
    
    if (_delegate && [_delegate respondsToSelector:@selector(gridCell:shouldUpdateValue:)]) {
        shouldUpdate = [_delegate gridCell:self shouldUpdateValue:value];
    }
    
    return shouldUpdate;
}


- (void)update {}


#pragma mark - Lifecycle Methods


- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.layer.borderColor = [UIColor blackColor].CGColor;
    self.layer.borderWidth = 1.0;
    
    self.contentView.exclusiveTouch = YES;
    self.exclusiveTouch = YES;
}

@end
