//
//  PPEGridHeaderCell.m
//  EditableGrid
//
//  Created by Alexander Snegursky on 9/24/16.
//  Copyright © 2016 Alexander Snegursky. All rights reserved.
//


#import "PPEGridHeaderCell.h"


@interface PPEGridHeaderCell ()

@property (nonatomic, weak) IBOutlet UIButton *button;

- (IBAction)buttonClicked:(UIButton *)sender;

@end


@implementation PPEGridHeaderCell


#pragma mark - PPEGridCell


- (void)update {
    [super update];
    [_button setTitle:self.column.title forState:UIControlStateNormal];
}


#pragma mark - Lifecycle Methods


- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    
    _button.titleLabel.adjustsFontSizeToFitWidth = YES;
    _button.titleLabel.minimumScaleFactor = 0.5;
    _button.titleLabel.numberOfLines = 3;
    _button.titleLabel.textAlignment = NSTextAlignmentCenter;
}


#pragma mark - IBAction


- (IBAction)buttonClicked:(UIButton *)sender {
    
    
    //TODO: Invoke heeader click action delegate
    
    
}

@end
