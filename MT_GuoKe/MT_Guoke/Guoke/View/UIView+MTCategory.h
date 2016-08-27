//
//  UIView+MTCategory.h
//  MT_Guoke
//
//  Created by Austen on 16/2/15.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MTCategory)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGSize size;

- (BOOL)isShowingOnKeyWindow;

+ (instancetype)viewFromXib;

- (void)setCornerRadii:(CGSize)size roundingCorners:(UIRectCorner)corner;


@end
