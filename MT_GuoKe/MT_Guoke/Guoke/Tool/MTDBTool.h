//
//  MTDBTool.h
//  MT_Guoke
//
//  Created by Austen on 16/2/16.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MTArticle;
@class MTArticleFrame;

@interface MTDBTool : NSObject

+ (instancetype)shareDB;

/**
 *  存储文章数据
 *
 *  @param article 文章模型
 */
- (void)storeArticle:(MTArticleFrame *)articleFrame;

/**
 *  获取所有缓存的数据
 *
 *  @return 文章数组
 */
- (NSArray *)getAllArticles;

/**
 *  清空所有缓存数据
 */
- (void)removeAllAritcles;


/**
 *  是否已收藏
 */
- (BOOL)isExistArticleWithID:(NSString *)article_id;


/**
 *  收藏文章
 */
- (void)likeArticle:(MTArticle *)article;

/**
 *  取消收藏
 */
- (void)dislikeArticle:(MTArticle *)article;

/**
 *  获得所有收藏
 */
- (NSArray *)getAllLikeArticles;

@end
