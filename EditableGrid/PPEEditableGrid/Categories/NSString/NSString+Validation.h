//
//  NSString+Validation.h
//  EditableGrid
//
//  Created by Alexander Snegursky on 9/23/16.
//  Copyright © 2016 Alexander Snegursky. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface NSString (Validation)

- (BOOL)isValidAccordingToRegex:(NSString *)regex;

@end
