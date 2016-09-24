//
//  NSObject+Properties.h
//  EditableGrid
//
//  Created by Alexander Snegursky on 9/23/16.
//  Copyright © 2016 Alexander Snegursky. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface NSObject (Properties)

+ (NSString *)typeOfPropertyWithName:(NSString *)name;
- (BOOL)propertyWithName:(NSString *)name correspondsToClass:(Class)aClass;

@end
