//
//  MTCommentView.m
//  MT_Guoke
//
//  Created by Austen on 16/2/16.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import "MTCommentView.h"
#import "MTButton.h"

@interface MTCommentView ()

@property (nonatomic, strong) MTButton *comment;

@property (nonatomic, copy) void(^ClickedBlock)();

@end

@implementation MTCommentView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = MTGlobalBackgroundColor;
        
        [self.comment mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).insets(UIEdgeInsetsMake(6, 12, 6, 12));
        }];
    }
    return self;
}

#pragma mark - 点击事件
- (void)didClickComment {
    
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(commentViewDidClick:)]) {
        [self.delegate commentViewDidClick:self];
    }
}


#pragma mark - getter
- (MTButton *)comment {
    
    if (!_comment) {
        _comment = [[MTButton alloc] init];
        _comment.backgroundColor = [UIColor whiteColor];
        [_comment setTitle:@"写评论" forState:UIControlStateNormal];
        [_comment setImage:[UIImage imageNamed:@"article_btn_review"] forState:UIControlStateNormal];
        [_comment setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _comment.titleLabel.font = [UIFont systemFontOfSize:13];
        _comment.adjustsImageWhenHighlighted = NO;
        
        _comment.layer.cornerRadius = 5;
        _comment.layer.masksToBounds = YES;
        _comment.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _comment.layer.borderWidth = 0.5;
        
        
        [_comment addTarget:self action:@selector(didClickComment) forControlEvents:UIControlEventTouchDown];
        [self addSubview:_comment];
    }
    return _comment;
}

@end
