//
//  UIBarButtonItem+MTCategory.h
//  MT_Guoke
//
//  Created by Austen on 16/8/26.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (MTCategory)

+ (UIBarButtonItem *)itemWithImage:(NSString *)image highlightedImage:(NSString *)highlightedImage target:(id)target action:(SEL)action;

@end
