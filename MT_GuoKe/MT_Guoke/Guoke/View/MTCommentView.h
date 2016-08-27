//
//  MTCommentView.h
//  MT_Guoke
//
//  Created by Austen on 16/2/16.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MTCommentView;

@protocol MTCommentViewDelegate <NSObject>

- (void)commentViewDidClick:(MTCommentView *)commentView;

@end

@interface MTCommentView : UIView

@property (nonatomic, weak) id<MTCommentViewDelegate>delegate;

@end
