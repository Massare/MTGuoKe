//
//  MTButton.m
//  MT_Guoke
//
//  Created by Austen on 16/2/16.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import "MTButton.h"

@implementation MTButton



- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.type == MTButtonTypeLeft) {   // 内容靠左
        
        self.imageView.x = 5;
        
        self.titleLabel.x = CGRectGetMaxX(self.imageView.frame);
        
    } else {                                // 内容靠右
        
        self.titleLabel.x = self.width - self.titleLabel.width - 5;
        
        self.imageView.x = CGRectGetMinX(self.titleLabel.frame) - self.imageView.width;
    }
    
}

@end
