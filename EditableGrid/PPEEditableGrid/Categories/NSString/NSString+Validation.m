//
//  NSString+Validation.m
//  EditableGrid
//
//  Created by Alexander Snegursky on 9/23/16.
//  Copyright © 2016 Alexander Snegursky. All rights reserved.
//


#import "NSString+Validation.h"


@implementation NSString (Validation)


- (BOOL)isValidAccordingToRegex:(NSString *)regex {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES[c] %@", regex];
    return [predicate evaluateWithObject:self];
}

@end
