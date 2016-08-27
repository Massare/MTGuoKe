//
//  MTArticleCollectionViewCell.m
//  MT_Guoke
//
//  Created by Austen on 16/2/16.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import "MTArticleCollectionViewCell.h"
#import "MTButton.h"
#import "MTArticle.h"
#import "MTArticleFrame.h"
#import <UIImageView+WebCache.h>

@interface MTArticleCollectionViewCell ()

@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) UIView *titleBgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) MTButton *sourceButton;
@property (nonatomic, strong) MTButton *timeButton;

@end

@implementation MTArticleCollectionViewCell


//- (void)setArticle:(MTArticle *)article {
//    _article = article;
//    
//    [self setupSubViewFrame];
//    
//    [self setupSubViewData];
//    
//    [self setupCornerRadius];
//}

//- (void)setupSubViewFrame {
//    self.headerImageView.frame = _article.articleFrame.imageF;
//    self.titleBgView.frame = _article.articleFrame.titleBgF;
//    self.titleLabel.frame = _article.articleFrame.titleF;
//    self.lineView.frame = _article.articleFrame.lineF;
//    self.sourceButton.frame = _article.articleFrame.sourceF;
//    self.timeButton.frame = _article.articleFrame.timeF;
//}

- (void)setArticleFrame:(MTArticleFrame *)articleFrame {
    _articleFrame = articleFrame;
    
    [self setupSubViewFrame];

    [self setupSubViewData];

    [self setupCornerRadius];
}

- (void)setupSubViewFrame {
    self.headerImageView.frame = _articleFrame.imageF;
    self.titleBgView.frame = _articleFrame.titleBgF;
    self.titleLabel.frame = _articleFrame.titleF;
    self.lineView.frame = _articleFrame.lineF;
    self.sourceButton.frame = _articleFrame.sourceF;
    self.timeButton.frame = _articleFrame.timeF;
}


- (void)setupSubViewData {
    
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:_articleFrame.article.headline_img_tb]];
   
    self.titleLabel.text = _articleFrame.article.title;

    [self.sourceButton setTitle:_articleFrame.article.source_name forState:UIControlStateNormal];
    [self.sourceButton setImage:[UIImage imageNamed:@"icon_source"] forState:UIControlStateDisabled];

    [self.timeButton setTitle:_articleFrame.article.date_picked forState:UIControlStateDisabled];
    [self.timeButton setImage:[UIImage imageNamed:@"icon_time"] forState:UIControlStateDisabled];
}

- (void)setupCornerRadius {
    [self.headerImageView setCornerRadii:MTCellCornerRadii roundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight];
    [self.sourceButton setCornerRadii:MTCellCornerRadii roundingCorners:UIRectCornerBottomLeft];
    [self.timeButton setCornerRadii:MTCellCornerRadii roundingCorners:UIRectCornerBottomRight];
}

#pragma mark - getter
- (UIImageView *)headerImageView {
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_headerImageView];
    }
    return _headerImageView;
}

- (UIView *)titleBgView {
    if (!_titleBgView) {
        _titleBgView = [[UIView alloc] init];
        _titleBgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_titleBgView];
    }
    return _titleBgView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = [UIFont systemFontOfSize:13];
        _titleLabel.textColor = [UIColor darkGrayColor];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor darkGrayColor];
        _lineView.alpha = 0.5;
        [self.contentView addSubview:_lineView];
    }
    return _lineView;
}

- (MTButton *)sourceButton {
    if (!_sourceButton) {
        _sourceButton = [[MTButton alloc] init];
        _sourceButton.type = MTButtonTypeLeft;
        _sourceButton.enabled = NO;
        _sourceButton.backgroundColor = [UIColor whiteColor];
        [_sourceButton setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        _sourceButton.titleLabel.font = [UIFont systemFontOfSize:10];
        _sourceButton.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [self.contentView addSubview:_sourceButton];
    }
    return _sourceButton;
}

- (MTButton *)timeButton {
    if (!_timeButton) {
        _timeButton = [[MTButton alloc] init];
        _timeButton.type = MTButtonTypeRight;
        _timeButton.backgroundColor = [UIColor whiteColor];
        _timeButton.enabled = NO;
        [_timeButton setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        _timeButton.titleLabel.font = [UIFont systemFontOfSize:10];
        _timeButton.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [self.contentView addSubview:_timeButton];
    }
    return _timeButton;
}

@end
