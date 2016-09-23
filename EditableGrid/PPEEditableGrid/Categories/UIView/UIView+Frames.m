//
//  PPECollectionViewCell.h
//  EditableGrid
//
//  Created by Alexander Snegursky on 9/23/16.
//  Copyright © 2016 Alexander Snegursky. All rights reserved.
//


#import "UIView+Frames.h"


@implementation UIView (Frames)


- (CGPoint)origin {
    return self.frame.origin;
}


- (void)setOrigin:(CGPoint)newOrigin {
    self.frame = CGRectMake(newOrigin.x, newOrigin.y, self.frame.size.width, self.frame.size.height);
}


- (CGFloat)x {
    return self.frame.origin.x;
}


- (void)setX:(CGFloat)x {
    self.frame = CGRectMake(x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}


- (CGFloat)y {
    return self.frame.origin.y;
}


- (void)setY:(CGFloat)y {
    self.frame = CGRectMake(self.frame.origin.x, y, self.frame.size.width, self.frame.size.height);
}


- (CGFloat)width {
    return self.frame.size.width;
}


- (void)setWidth:(CGFloat)newWidth {
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, newWidth, self.frame.size.height);
}


- (CGFloat)height {
    return self.frame.size.height;
}


- (void)setHeight:(CGFloat)newHeight {
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, newHeight);
}


- (CGSize)size {
    return self.frame.size;
}


- (void)setSize:(CGSize)size {
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width, size.height);
}


- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}


- (void)setRight:(CGFloat)right {
    self.frame = CGRectMake(right - self.frame.size.width, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}


- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}


- (void)setBottom:(CGFloat)bottom {
    self.frame = CGRectMake(self.frame.origin.x, bottom - self.frame.size.height, self.frame.size.width, self.frame.size.height);
}


- (CGFloat)centerX {
    return self.center.x;
}


- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}


- (CGFloat)centerY {
    return self.center.y;
}


- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

@end
