//
//  NSObject+Properties.m
//  EditableGrid
//
//  Created by Alexander Snegursky on 9/23/16.
//  Copyright © 2016 Alexander Snegursky. All rights reserved.
//


#import "NSObject+Properties.h"
#import <objc/runtime.h>


@implementation NSObject (Properties)


+ (NSString *)typeOfPropertyWithName:(NSString *)name {
    objc_property_t property = class_getProperty(self, [name UTF8String]);
    
    if (property == NULL) {
        return nil;
    }
    
    return [NSString stringWithUTF8String:property_getTypeString(property)];
}


- (BOOL)propertyWithName:(NSString *)name correspondsToClass:(Class)aClass {
    NSString *typeStr = [[self class]typeOfPropertyWithName:name];
    
    return typeStr && aClass &&
    [typeStr rangeOfString:NSStringFromClass(aClass)
                   options:NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch].location != NSNotFound;
}


#pragma mark - Internal Logic


const char * property_getTypeString(objc_property_t property) {
    const char * attrs = property_getAttributes( property );
    
    if (attrs == NULL) {
        return NULL;
    }
    
    static char buffer[256];
    const char * e = strchr(attrs, ',');
    
    if (e == NULL) {
        return NULL;
    }
    
    int len = (int)(e - attrs);
    memcpy(buffer, attrs, len);
    buffer[len] = '\0';
    
    return buffer;
}

@end
