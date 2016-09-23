//
//  PPECollectionViewCell.h
//  EditableGrid
//
//  Created by Alexander Snegursky on 9/23/16.
//  Copyright © 2016 Alexander Snegursky. All rights reserved.
//


#import <UIKit/UIKit.h>


@interface NSObject (NibLoading)

+ (id)loadFromNib;
+ (id)loadFromNibNamed:(NSString *)nibName;
+ (id)loadFromNibNamed:(NSString *)nibName ownedBy:(id)owner;
+ (UINib *)nib;

@end
