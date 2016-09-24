//
//  PPEGridTextFieldCell.m
//
//  Created by Alexander Snegursky on 9/24/16.
//  Copyright © 2016 Alexander Snegursky. All rights reserved.
//


#import "PPEGridTextFieldCell.h"
#import "NSObject+Utilities.h"
#import "NSObject+Properties.h"
#import "NSString+Validation.h"
#import "NSString+Utilities.h"


@interface PPEGridTextFieldCell () <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextField *textField;

- (void)textDidChange:(UITextField *)sender;
- (BOOL)isInputValid:(NSString *)candidate;

@end


@implementation PPEGridTextFieldCell


#pragma mark - PPEGridCell


- (void)update {
    [super update];
    
    NSString *stringValue = nil;
    
    if ([self.object respondsToSelector:[self.column.key getter]]) {
        id value = [self.object valueForKey:self.column.key];
        stringValue = [value extractString];
    }
    
    _textField.text = stringValue ?: @"";
}


#pragma mark - Lifecycle Methods


- (void)awakeFromNib {
    [super awakeFromNib];
    
    _textField.delegate = self;
    
    [_textField addTarget:self
                   action:@selector(textDidChange:)
         forControlEvents:UIControlEventEditingChanged];
}


#pragma mark - UITextFieldDelegate


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *candidate = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (self.column.validator && self.column.validator.length > 0) {
        return [self isInputValid:candidate] && [self shouldUpdateValue:candidate];
    }
    
    return [self shouldUpdateValue:candidate];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - Internal Logic


- (void)textDidChange:(UITextField *)sender {
    if ([self.object respondsToSelector:[self.column.key getter]]) {
        id value = [self.object valueForKey:self.column.key];
        
        if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]] ||
            (value == nil && ([self.object propertyWithName:self.column.key correspondsToClass:[NSString class]] ||
                              [self.object propertyWithName:self.column.key correspondsToClass:[NSNumber class]]))) {
            NSString *oldString = [value extractString];
            NSString *newString = sender.text;
            
            if (oldString == nil || [oldString isEqualToString:newString] == NO) {
                if ([self.object respondsToSelector:[self.column.key setter]]) {
                    [self.object setValue:newString forKey:self.column.key];
                    
                    if (self.delegate && [self.delegate respondsToSelector:@selector(gridCell:didUpdateValue:)]) {
                        [self.delegate gridCell:self didUpdateValue:newString];
                    }
                }
            }
        }
    }
}


- (BOOL)isInputValid:(NSString *)candidate {
    if (self.column.validator.length > 0 &&
        candidate.length > 0 &&
        [candidate isValidAccordingToRegex:self.column.validator] == NO) {
        return NO;
    }
    
    return YES;
}

@end
