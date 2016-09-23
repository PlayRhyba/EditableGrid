//
//  PPECollectionViewCell.m
//  Protraak
//  EditableGrid
//
//  Created by Alexander Snegursky on 9/23/16.
//  Copyright © 2016 Alexander Snegursky. All rights reserved.
//


#import "PPECollectionViewCell.h"
#import "NSObject+NibLoading.h"


@implementation PPECollectionViewCell


#pragma mark - Public Methods


+ (NSString *)reuseIdentifier {
    return NSStringFromClass([self class]);
}


+ (CGSize)size {
    return CGSizeZero;
}


+ (void)registerForCollectionView:(UICollectionView *)collectionView {
    [collectionView registerNib:[self nib] forCellWithReuseIdentifier:[[self class]reuseIdentifier]];
}

@end
