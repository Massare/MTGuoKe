//
//  MTArticle.m
//  MT_Guoke
//
//  Created by Austen on 16/2/16.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import "MTArticle.h"
#import <MJExtension.h>

@implementation MTArticle

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"articleID" : @"id"

             };
}

//- (MTArticleFrame *)articleFrame {
//    if (!_articleFrame) {
//        _articleFrame = [[MTArticleFrame alloc] init];
//        _articleFrame.imageF = [self getImageFrame];
//        _articleFrame.titleF = [self getTitleFrame];
//        _articleFrame.lineF = [self getLineFrame];
//        _articleFrame.sourceF = [self getSourceFrame];
//        _articleFrame.timeF = [self getTimeFrame];
//        _articleFrame.cellSize = [self getCellSize];
//        _articleFrame.titleBgF = [self getTitleBgFrame];
//    }
//    return _articleFrame;
//}
//
//
//
//- (CGRect)getImageFrame {
//    CGFloat height = 0;
//    if ([_headline_img_tb rangeOfString:@"imageView2/1/"].location != NSNotFound) {
//        NSArray *components = [_headline_img_tb componentsSeparatedByString:@"/"];
//        CGFloat imageWidth = [components[components.count - 3] floatValue];
//        CGFloat imageHeight = [components[components.count - 1] floatValue];
//        height = MTCollectionCellWidth * imageHeight / imageWidth;
//    }
//    return CGRectMake(0, 0, MTCollectionCellWidth, height);
//}
//
//- (CGRect)getTitleFrame {
//    CGSize size = [_title boundingRectWithSize:CGSizeMake(MTCollectionCellWidth - 2 * MTTitleLeftMargin, MTTitleMaxHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]} context:nil].size;
//    return CGRectMake(MTTitleLeftMargin, CGRectGetMaxY(_articleFrame.imageF) + MTRowMargin, size.width, size.height);
//}
//
//- (CGRect)getLineFrame {
//    return CGRectMake(0, CGRectGetMaxY(_articleFrame.titleF) + MTRowMargin, MTCollectionCellWidth, 1);
//}
//
//- (CGRect)getSourceFrame {
//    return CGRectMake(0, CGRectGetMaxY(_articleFrame.lineF), MTCollectionCellWidth * 0.5, MTSourceButtonHeight);
//}
//
//- (CGRect)getTimeFrame {
//    return CGRectMake(MTCollectionCellWidth * 0.5, CGRectGetMaxY(_articleFrame.lineF), MTCollectionCellWidth * 0.5, MTSourceButtonHeight);
//}
//
//- (CGSize)getCellSize {
//    return CGSizeMake(MTCollectionCellWidth, CGRectGetMaxY(_articleFrame.sourceF)- CGRectGetMinY(_articleFrame.imageF));
//}
//
//- (CGRect)getTitleBgFrame {
//    return CGRectMake(0, CGRectGetMaxY(_articleFrame.imageF), MTCollectionCellWidth, CGRectGetHeight(_articleFrame.titleF) + 2 * MTRowMargin);
//}


@end
