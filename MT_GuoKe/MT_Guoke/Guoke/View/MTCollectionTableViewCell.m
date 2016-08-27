//
//  MTCollectionTableViewCell.m
//  MT_Guoke
//
//  Created by Austen on 16/2/17.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import "MTCollectionTableViewCell.h"
#import "MTButton.h"
#import "MTArticle.h"
#import "MTDateTool.h"
#import "MTArticleFrame.h"

@interface MTCollectionTableViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *summaryLabel;
@property (nonatomic, strong) MTButton *sourceButton;
@property (nonatomic, strong) MTButton *timeButton;

@end

@implementation MTCollectionTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(kTitleTopPadding));
        make.left.equalTo(@(kTitleLeftPadding));
        make.right.equalTo(@(-kTitleLeftPadding));
    }];
    
    [self.summaryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(kTitleAndSummarySpacing);
        make.left.equalTo(@(kTitleLeftPadding));
        make.right.equalTo(@(-kTitleLeftPadding));
    }];
    
    [self.sourceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.summaryLabel.mas_bottom).offset(kTitleAndSummarySpacing);
        make.left.equalTo(@(kTitleLeftPadding));
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
    
    [self.timeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.sourceButton);
        make.left.equalTo(self.contentView.mas_centerX);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
    
    // 底部线
    UIView * line = [[UIView alloc] init];
    line.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.titleLabel);
        make.bottom.equalTo(self.contentView);
        make.height.equalTo(@0.5);
    }];
}

- (void)setArticle:(MTArticle *)article {
    _article = article;
    
    self.titleLabel.text = article.title;
    
    self.summaryLabel.text = article.summary;
    
    [self.sourceButton setTitle:article.source_name forState:UIControlStateDisabled];
    [self.sourceButton setImage:[UIImage imageNamed:@"icon_source"] forState:UIControlStateDisabled];
    
    NSString * customDate = [MTDateTool customDateWithOriginDateString:article.date_picked];
    [self.timeButton setTitle:customDate forState:UIControlStateDisabled];
    [self.timeButton setImage:[UIImage imageNamed:@"icon_time"] forState:UIControlStateDisabled];
}


- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:15];
        _titleLabel.textColor = [UIColor darkGrayColor];
        _titleLabel.numberOfLines = 0;
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)summaryLabel {
    if (!_summaryLabel) {
        _summaryLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:13];
        _titleLabel.textColor = [UIColor grayColor];
        _titleLabel.numberOfLines = 0;
        [self.contentView addSubview:_summaryLabel];
    }
    return _summaryLabel;
}

- (MTButton *)sourceButton {
    if (!_sourceButton) {
        _sourceButton = [[MTButton alloc] init];
        [_sourceButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
        _sourceButton.titleLabel.font = [UIFont systemFontOfSize:10];
        _sourceButton.enabled = NO;
        [self.contentView addSubview:_sourceButton];
    }
    return _sourceButton;
}

- (MTButton *)timeButton {
    if (!_timeButton) {
        _timeButton = [[MTButton alloc] init];
        [_timeButton  setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
        _timeButton.titleLabel.font = [UIFont systemFontOfSize:10];
        _timeButton.enabled = NO;
        [self.contentView addSubview:_timeButton];
    }
    return _timeButton;
}

@end
