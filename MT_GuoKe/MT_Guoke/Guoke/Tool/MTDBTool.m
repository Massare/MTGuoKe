//
//  MTDBTool.m
//  MT_Guoke
//
//  Created by Austen on 16/2/16.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import "MTDBTool.h"
#import <FMDatabase.h>
#import "MTArticle.h"
#import "MTArticleFrame.h"

@implementation MTDBTool
{
    FMDatabase * _fmDataBase;
}

static MTDBTool *_DBTool = nil;
+ (instancetype)shareDB {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _DBTool = [[MTDBTool alloc] init];
    });
    return _DBTool;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _DBTool = [super allocWithZone:zone];
    });
    return _DBTool;
}

- (instancetype)init {
    if (self = [super init]) {
        [self createDB];
    }
    return self;
}

- (void)createDB {
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *dbPath = [path stringByAppendingPathComponent:@"db_guoke.sqlite"];
    _fmDataBase = [FMDatabase databaseWithPath:dbPath];
    if ([_fmDataBase open]) {
        
        MTLog(@"成功创建数据库db_guoke.sqlite");
        
        [self createTable];
    }
}

- (void)createTable {
    // 缓存表
    NSString * createSQL = @"create table if not exists t_article_cach (id integer primary key autoincrement, article_id text, title text, source_name text, headline_img_tb text, date_picked text)";
    
    if ([_fmDataBase executeUpdate:createSQL]) {
        
        MTLog(@"成功创建缓存表t_article_cach");
    }
    
    // 收藏表
    NSString * likeSQL = @"create table if not exists t_article_like (id integer primary key autoincrement, article_id text, title text, source_name text, summary text, date_picked text)";
    
    if ([_fmDataBase executeUpdate:likeSQL]) {
        
        MTLog(@"成功创建收藏表t_article_like");
    }
}

#pragma mark - 储存数据
- (void)storeArticle:(MTArticleFrame *)articleFrame {
    MTArticle *article = articleFrame.article;
    NSString * insertSQL = @"insert into t_article_cach (article_id, title, source_name, headline_img_tb, date_picked) values (?, ?, ?, ?, ?)";
    
    BOOL success;
    
    @synchronized(self) {
        success = [_fmDataBase executeUpdate:insertSQL, article.articleID, article.title, article.source_name, article.headline_img_tb, article.date_picked];
    }
    
    if (!success) {
        MTLog(@"插入失败！");
    }
}

#pragma mark - 查询所有缓存数据
- (NSArray *)getAllArticles {
    
    NSString * querySQL = @"select * from t_article_cach";
    
    FMResultSet * result;
    
    @synchronized(self) {
        result = [_fmDataBase executeQuery:querySQL];
    }
    
    NSMutableArray * articleFrames = [NSMutableArray array];
    
    while ([result next]) {
        
        MTArticle * article    = [[MTArticle alloc] init];
        article.articleID       = [result objectForColumnName:@"article_id"];
        article.title           = [result objectForColumnName:@"title"];
        article.date_picked     = [result objectForColumnName:@"date_picked"];
        article.source_name     = [result objectForColumnName:@"source_name"];
        article.headline_img_tb = [result objectForColumnName:@"headline_img_tb"];
        
        MTArticleFrame *articleFrame = [[MTArticleFrame alloc] init];
        articleFrame.article = article;
        
        [articleFrames addObject:articleFrame];
    }
    
    return articleFrames;
}

- (BOOL)isExistArticleWithID:(NSString *)article_id {
    
    NSString * querySQL = @"select * from t_article_like where article_id = ?";
    
    FMResultSet * result;
    
    @synchronized(self) {
        result = [_fmDataBase executeQuery:querySQL, article_id];
    }
    
    return [result next];
}

#pragma mark - 清空缓存数据
- (void)removeAllAritcles {
    
    NSString * deleteSQL = @"delete from t_article_cach";
    
    BOOL success;
    
    @synchronized(self) {
        success = [_fmDataBase executeUpdate:deleteSQL];
    }
    
    if (!success) {
        MTLog(@"无法清空缓存数据！");
    }
}

#pragma mark - 收藏
- (void)likeArticle:(MTArticle *)article {
    
    
    NSString * insertSQL = @"insert into t_article_like (article_id, title, source_name, summary, date_picked) values (?, ?, ?, ?, ?)";
    
    BOOL success;
    
    @synchronized(self) {
        success = [_fmDataBase executeUpdate:insertSQL, article.articleID, article.title, article.source_name, article.summary, article.date_picked];
    }
    
    if (!success) {
        MTLog(@"收藏失败！");
    }
}

#pragma mark - 取消收藏
- (void)dislikeArticle:(MTArticle *)article {
    
    NSString * deleteSQL = @"delete from t_article_like where article_id = ?";
    
    BOOL success;
    
    @synchronized(self) {
        success = [_fmDataBase executeUpdate:deleteSQL, article.articleID];
    }
    
    if (!success) {
        MTLog(@"无法取消收藏！");
    }
}

- (NSArray *)getAllLikeArticles {
    
    NSString * querySQL = @"select * from t_article_like";
    
    FMResultSet * result;
    
    @synchronized(self) {
        result = [_fmDataBase executeQuery:querySQL];
    }
    
    NSMutableArray *articles = [NSMutableArray array];
    
    while ([result next]) {
        
        MTArticle *article      = [[MTArticle alloc] init];
        article.articleID       = [result objectForColumnName:@"article_id"];
        article.title           = [result objectForColumnName:@"title"];
        article.date_picked     = [result objectForColumnName:@"date_picked"];
        article.source_name     = [result objectForColumnName:@"source_name"];
        article.summary         = [result objectForColumnName:@"summary"];
        
        [articles addObject:article];
    }
    
    return articles;
}

@end
