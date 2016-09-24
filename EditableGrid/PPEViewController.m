//
//  PPEViewController.m
//  EditableGrid
//
//  Created by Alexander Snegursky on 9/23/16.
//  Copyright © 2016 Alexander Snegursky. All rights reserved.
//


#import "PPEViewController.h"
#import "PPEGridColumnModel.h"
#import "PPEDataObject.h"
#import "PPEEditableGrid.h"
#import "UIView+Frames.h"


@interface PPEViewController () <PPEEditableGridDelegate>

@property (nonatomic, strong) NSMutableArray <PPEDataObject *> *dataSource;
@property (nonatomic, strong) PPEEditableGrid *editableGrid;

- (void)configureGrid;

@end


@implementation PPEViewController


#pragma mark - Getters/Setters


- (NSMutableArray <PPEDataObject *> *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    
    return _dataSource;
}


#pragma mark - Lifecycle Methods


- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureGrid];
}


#pragma mark - PPEEditableGridDelegate


- (void)didAddButtonClickedOnGrid:(PPEEditableGrid *)grid {
    [self.dataSource addObject:[PPEDataObject new]];
    [_editableGrid updateWithObjects:self.dataSource];
    [_editableGrid scrollToBottomAnimated:YES];
    
    NSLog(@"%@", self.dataSource);
}


- (void)editableGrid:(PPEEditableGrid *)grid didDeleteObject:(id)object {
    [self.dataSource removeObject:object];
    [_editableGrid updateWithObjects:self.dataSource];
    
    NSLog(@"%@", self.dataSource);
}


#pragma mark - Internal Logic


- (void)configureGrid {
    NSArray <PPEGridColumnModel *> *columns = [PPEGridColumnModel itemsFromFileWithName:@"columns"];
    
    self.editableGrid = [[PPEEditableGrid alloc]initWithObjects:self.dataSource
                                                        columns:columns
                                                       delegate:self];
    _editableGrid.frame = CGRectMake(0.0,
                                     self.view.height / 4.0,
                                     [PPEEditableGrid widthWithColumns:columns maxWidth:self.view.width],
                                     self.view.height / 2.0);
    
    [self.view addSubview:_editableGrid];
}

@end
