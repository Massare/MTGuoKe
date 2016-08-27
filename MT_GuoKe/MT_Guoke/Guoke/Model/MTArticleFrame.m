//
//  MTArticleFrame.m
//  MT_Guoke
//
//  Created by Austen on 16/2/16.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import "MTArticleFrame.h"
#import "MTArticle.h"

@implementation MTArticleFrame

- (void)setArticle:(MTArticle *)article {
    _article = article;
    
    [self getImageFrame];
    
    [self getTitleFrame];
    
    [self getLineFrame];
    
    [self getSourceAndTimeFrame];
}

#pragma mark - 图片frame
- (void)getImageFrame {
    
    // 默认高度
    CGFloat height = MTCollectionCellWidth;
    
    if ([_article.headline_img_tb rangeOfString:@"imageView2/1/"].location != NSNotFound) {
        
        NSArray *component = [_article.headline_img_tb componentsSeparatedByString:@"/"];
        
        CGFloat sourceWidth   = [component[component.count - 3] floatValue];
        CGFloat sourceHeight  = [component[component.count - 1] floatValue];
        
        height = MTCollectionCellWidth * sourceHeight / sourceWidth;
    }
    _imageF = CGRectMake(0, 0, MTCollectionCellWidth, height);
}

#pragma mark - 标题frame
- (void)getTitleFrame {
    
    
    CGSize size = [_article.title boundingRectWithSize:CGSizeMake(MTCollectionCellWidth - 2 * MTTitleLeftMargin, MTTitleMaxHeight)
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                            attributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:13] }
                                               context:nil].size;
    
    _titleF = CGRectMake(MTTitleLeftMargin, CGRectGetMaxY(_imageF) + MTRowMargin, size.width, size.height);
    
}

#pragma mark - 线frame
- (void)getLineFrame {
    
    _lineF = CGRectMake(0, CGRectGetMaxY(_titleF) + MTRowMargin, MTCollectionCellWidth, 1);
}

#pragma mark - 来源&时间frame
- (void)getSourceAndTimeFrame {
    
    _sourceF = CGRectMake(0, CGRectGetMaxY(_lineF), _imageF.size.width/2, MTSourceButtonHeight);
    
    _timeF = CGRectMake(CGRectGetMaxX(_sourceF), CGRectGetMinY(_sourceF), CGRectGetWidth(_sourceF), CGRectGetHeight(_sourceF));
    
    _titleBgF = CGRectMake(0, CGRectGetMaxY(_imageF), CGRectGetWidth(_imageF), CGRectGetMaxY(_lineF) - CGRectGetMaxY(_imageF));
    
    // 设置cellSize
    _cellSize = CGSizeMake(MTCollectionCellWidth, CGRectGetMaxY(_sourceF));
}


@end
