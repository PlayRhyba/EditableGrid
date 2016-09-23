//
//  PPECollectionViewCell.h
//  EditableGrid
//
//  Created by Alexander Snegursky on 9/23/16.
//  Copyright © 2016 Alexander Snegursky. All rights reserved.
//


#import <UIKit/UIKit.h>


@interface PPECollectionViewCell : UICollectionViewCell

+ (NSString *)reuseIdentifier;
+ (CGSize)size;
+ (void)registerForCollectionView:(UICollectionView *)collectionView;

@end
