//
//  UIView+MTCategory.m
//  MT_Guoke
//
//  Created by Austen on 16/8/25.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import "UIView+MTCategory.h"

@implementation UIView (MTCategory)

- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (BOOL)isShowingOnKeyWindow {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    CGRect newFrame = [keyWindow convertRect:self.frame fromView:self.superview];
    CGRect windowBounds = keyWindow.bounds;
    
    BOOL intersects = CGRectIntersectsRect(newFrame, windowBounds);
    return !self.isHidden&&self.alpha > 0.01 && self.window == keyWindow && intersects;
}

+ (instancetype)viewFromXib {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)setCornerRadii:(CGSize)size roundingCorners:(UIRectCorner)corner {
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corner cornerRadii:size];
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.frame = self.bounds;
    layer.path = path.CGPath;
    self.layer.mask = layer;
}

@end
