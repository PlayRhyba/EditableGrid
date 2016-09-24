//
//  NSObject+Utilities.m
//  EditableGrid
//
//  Created by Alexander Snegursky on 9/24/16.
//  Copyright © 2016 Alexander Snegursky. All rights reserved.
//


#import "NSObject+Utilities.h"


@implementation NSObject (Utilities)


- (NSString *)extractString {
    if ([self isKindOfClass:[NSString class]]) {
        return (NSString *)self;
    }
    else if ([self isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *)self stringValue];
    }
    
    return nil;
}

@end
