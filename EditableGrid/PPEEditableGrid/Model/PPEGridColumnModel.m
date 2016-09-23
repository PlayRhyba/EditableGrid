//
//  PPEAppDelegate.h
//  EditableGrid
//
//  Created by Alexander Snegursky on 9/23/16.
//  Copyright © 2016 Alexander Snegursky. All rights reserved.
//


#import "PPEGridColumnModel.h"


static const CGFloat kDefaultWidth = 100.0;


static NSString * const kText = @"text";
static NSString * const kSwitch = @"switch";


@interface PPEGridColumnModel ()

+ (PPEGridColumnType)typeWithString:(NSString *)string;

@end


@implementation PPEGridColumnModel


#pragma mark - Public Methods


+ (NSArray<PPEGridColumnModel *> *)itemsFromFileWithName:(NSString *)fileName {
    NSMutableArray *result = [NSMutableArray array];
    NSString *path = [[NSBundle mainBundle]pathForResource:fileName ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    if (data) {
        NSError *error = nil;
        
        NSArray *objects = [NSJSONSerialization JSONObjectWithData:data
                                                           options:NSJSONReadingMutableContainers
                                                             error:&error];
        if (error) {
            NSLog(@"%@: %@. Error: %@", NSStringFromClass([self class]),
                  NSStringFromSelector(@selector(itemsFromFileWithName:)),
                  error.localizedDescription);
        }
        
        if (objects && [objects isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dictionary in objects) {
                NSString *type = dictionary[NSStringFromSelector(@selector(type))];
                
                PPEGridColumnModel *object = [[PPEGridColumnModel alloc]initWithType:[self typeWithString:type]
                                                                               title:dictionary[NSStringFromSelector(@selector(title))]
                                                                                 key:dictionary[NSStringFromSelector(@selector(key))]
                                                                           validator:dictionary[NSStringFromSelector(@selector(validator))]
                                                                               width:[dictionary[NSStringFromSelector(@selector(width))] floatValue]];
                [result addObject:object];
            }
        }
    }
    
    return result;
}


- (instancetype)initWithType:(PPEGridColumnType)type
                       title:(NSString *)title
                         key:(NSString *)key
                   validator:(NSString *)validator
                       width:(CGFloat)width {
    if (self = [super init]) {
        _type = type;
        _title = title;
        _key = key;
        _validator = validator;
        _width = width > 0 ? width : kDefaultWidth;
    }
    
    return self;
}


#pragma mark - Internal Logic


+ (PPEGridColumnType)typeWithString:(NSString *)string {
    if ([string isEqualToString:kText]) return PPEGridColumnTypeText;
    else if ([string isEqualToString:kSwitch]) return PPEGridColumnTypeSwitch;
    else return PPEGridColumnTypeUndefined;
}

@end
