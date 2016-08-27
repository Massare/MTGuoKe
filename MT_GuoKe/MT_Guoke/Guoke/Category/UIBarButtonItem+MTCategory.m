//
//  UIBarButtonItem+MTCategory.m
//  MT_Guoke
//
//  Created by Austen on 16/8/26.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import "UIBarButtonItem+MTCategory.h"

@implementation UIBarButtonItem (MTCategory)

+ (UIBarButtonItem *)itemWithImage:(NSString *)image highlightedImage:(NSString *)highlightedImage target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highlightedImage] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.size = button.currentBackgroundImage.size;
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    return item;
}

@end
