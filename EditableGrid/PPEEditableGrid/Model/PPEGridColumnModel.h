//
//  PPEAppDelegate.h
//  EditableGrid
//
//  Created by Alexander Snegursky on 9/23/16.
//  Copyright © 2016 Alexander Snegursky. All rights reserved.
//


#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, PPEGridColumnType) {
    PPEGridColumnTypeUndefined = 0,
    PPEGridColumnTypeText = 1,
    PPEGridColumnTypeSwitch = 2,
};


@interface PPEGridColumnModel : NSObject

@property (nonatomic, readonly) PPEGridColumnType type;
@property (nonatomic, strong, readonly) NSString *title;
@property (nonatomic, strong, readonly) NSString *key;
@property (nonatomic, strong, readonly) NSString *validator;
@property (nonatomic, readonly) CGFloat width;

+ (NSArray<PPEGridColumnModel *> *)itemsFromFileWithName:(NSString *)fileName;

- (instancetype)initWithType:(PPEGridColumnType)type
                       title:(NSString *)title
                         key:(NSString *)key
                   validator:(NSString *)validator
                       width:(CGFloat)width;
@end
