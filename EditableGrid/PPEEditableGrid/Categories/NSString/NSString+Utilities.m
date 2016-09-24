//
//  NSString+Utilities.m
//  EditableGrid
//
//  Created by Alexander Snegursky on 9/24/16.
//  Copyright © 2016 Alexander Snegursky. All rights reserved.
//


#import "NSString+Utilities.h"


@implementation NSString (Utilities)


- (SEL)getter {
    return NSSelectorFromString(self);
}


- (SEL)setter {
    NSString *firstSymbol = [self substringToIndex:1];
    
    NSString *correctedKey = [self stringByReplacingCharactersInRange:NSMakeRange(0, 1)
                                                           withString:firstSymbol.uppercaseString];
    
    NSString *selectorString = [NSString stringWithFormat:@"set%@:", correctedKey];
    
    return NSSelectorFromString(selectorString);
}

@end
