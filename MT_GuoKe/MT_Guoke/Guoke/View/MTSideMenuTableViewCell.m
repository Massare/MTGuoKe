//
//  MTSideMenuTableViewCell.m
//  MT_Guoke
//
//  Created by Austen on 16/2/16.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import "MTSideMenuTableViewCell.h"

@interface MTSideMenuTableViewCell ()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *indicatorImageView;
@property (nonatomic, strong) UIImageView *bottomLineImageView;

@end

@implementation MTSideMenuTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(kIconTopAndBottomMargin);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-kIconTopAndBottomMargin);
        make.left.equalTo(self.contentView.mas_left).offset(kIconLeftMargin);
        make.size.mas_equalTo(CGSizeMake(kIconWidthAndHeight, kIconWidthAndHeight));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(_iconImageView.mas_right).offset(kIconAndTitleSpace);
    }];
    
    [self.indicatorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView.mas_right).offset(-(kDeckControllerLeftWidth + kIconLeftMargin));
        make.size.mas_equalTo(CGSizeMake(kIndicatorWidthAndHeight, kIndicatorWidthAndHeight));
    }];
    
    [self.bottomLineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.and.left.and.bottom.equalTo(self.contentView);
        make.height.equalTo(@(kBottomLineHeight));
    }];
}

- (void)setCellWithTitle:(NSString *)title image:(NSString *)image {
    self.iconImageView.image = [UIImage imageNamed:image];
    self.titleLabel.text = title;
    
    self.indicatorImageView.image = [UIImage imageNamed:@"menu_arrow_press"];
    self.bottomLineImageView.image = [UIImage imageNamed:@"menu_line"];
}

#pragma mark - getter 
- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.tintColor = [UIColor whiteColor];
        [self.contentView addSubview:_iconImageView];
    }
    return _iconImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _titleLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UIImageView *)indicatorImageView {
    if (!_indicatorImageView) {
        _indicatorImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_indicatorImageView];
    }
    return _indicatorImageView;
}

- (UIImageView *)bottomLineImageView {
    if (!_bottomLineImageView) {
        _bottomLineImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_bottomLineImageView];
    }
    return _bottomLineImageView;
}

@end
