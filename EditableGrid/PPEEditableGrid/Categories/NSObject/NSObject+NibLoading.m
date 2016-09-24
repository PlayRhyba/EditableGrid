//
//  NSObject+NibLoading.m
//  EditableGrid
//
//  Created by Alexander Snegursky on 9/23/16.
//  Copyright © 2016 Alexander Snegursky. All rights reserved.
//


#import "NSObject+NibLoading.h"


@implementation NSObject (NibLoading)


+ (id)loadFromNib {
    return [self loadFromNibNamed:NSStringFromClass([self class])];
}


+ (id)loadFromNibNamed:(NSString *)nibName {
    return [self loadFromNibNamed:nibName ownedBy:nil];
}


+ (id)loadFromNibNamed:(NSString *)nibName ownedBy:(id)owner {
    NSArray *objects = [[NSBundle mainBundle] loadNibNamed:nibName owner:owner options:nil];
    
    for (id object in objects) {
        if ([object isKindOfClass:[self class]]) {
            return object;
        }
    }
    
    return nil;
}


+ (UINib *)nib {
    return [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
}

@end
