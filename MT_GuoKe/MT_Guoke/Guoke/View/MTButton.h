//
//  MTButton.h
//  MT_Guoke
//
//  Created by Austen on 16/2/16.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MTButtonType){
    MTButtonTypeLeft = 0,
    MTButtonTypeRight
};

@interface MTButton : UIButton

@property (nonatomic, assign) MTButtonType type;

@end
