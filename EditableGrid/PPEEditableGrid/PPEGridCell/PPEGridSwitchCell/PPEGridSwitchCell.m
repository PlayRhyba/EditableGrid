//
//  PPEGridSwitchCell.m
//  EditableGrid
//
//  Created by Alexander Snegursky on 9/24/16.
//  Copyright © 2016 Alexander Snegursky. All rights reserved.
//


#import "PPEGridSwitchCell.h"
#import "NSObject+Properties.h"
#import "NSString+Utilities.h"


@interface PPEGridSwitchCell ()

@property (nonatomic, weak) IBOutlet UISwitch *stateSwitch;

- (IBAction)switchStateChanged:(UISwitch *)sender;

@end


@implementation PPEGridSwitchCell


#pragma mark - PPEGridCell


- (void)update {
    [super update];
    
    BOOL on = NO;
    
    if ([self.object respondsToSelector:[self.column.key getter]]) {
        id value = [self.object valueForKey:self.column.key];
        on = [value isKindOfClass:[NSNumber class]] ? [value boolValue] : NO;
    }
    
    _stateSwitch.on = on;
}


#pragma mark - IBAction


- (IBAction)switchStateChanged:(UISwitch *)sender {
    if ([self.object respondsToSelector:[self.column.key getter]]) {
        id value = [self.object valueForKey:self.column.key];
        
        if ([value isKindOfClass:[NSNumber class]] ||
            (value == nil && [self.object propertyWithName:self.column.key correspondsToClass:[NSNumber class]])) {
            BOOL oldState = [(NSNumber *)value boolValue];
            
            if (oldState != _stateSwitch.on) {
                if ([self shouldUpdateValue:@(_stateSwitch.on)] == NO) {
                    [_stateSwitch setOn:oldState animated:YES];
                }
                else {
                    if ([self.object respondsToSelector:[self.column.key setter]]) {
                        [self.object setValue:@(_stateSwitch.on) forKey:self.column.key];
                        
                        if (self.delegate && [self.delegate respondsToSelector:@selector(gridCell:didUpdateValue:)]) {
                            [self.delegate gridCell:self didUpdateValue:@(_stateSwitch.on)];
                        }
                    }
                }
            }
        }
    }
}

@end
