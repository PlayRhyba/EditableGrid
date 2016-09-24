//
//  PPEDataObject.m
//  EditableGrid
//
//  Created by Alexander Snegursky on 9/23/16.
//  Copyright © 2016 Alexander Snegursky. All rights reserved.
//


#import "PPEDataObject.h"


@implementation PPEDataObject


#pragma mark - NSObject


- (NSString *)description {
    return @{NSStringFromSelector(@selector(firstname)): _firstname ?: @"",
             NSStringFromSelector(@selector(lastname)): _lastname ?: @"",
             NSStringFromSelector(@selector(age)): _age ?: @0,
             NSStringFromSelector(@selector(address)): _address ?: @"",
             NSStringFromSelector(@selector(enabled)): _enabled ?: @0,
             NSStringFromSelector(@selector(notes)): _notes ?: @""}.description;
}

@end
