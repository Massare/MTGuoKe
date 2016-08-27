//
//  MTArticleFrame.h
//  MT_Guoke
//
//  Created by Austen on 16/2/16.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MTArticle;

@interface MTArticleFrame : NSObject

@property (nonatomic, strong) MTArticle *article;

@property (nonatomic, assign) CGRect imageF;

@property (nonatomic, assign) CGRect titleBgF;

@property (nonatomic, assign) CGRect titleF;

@property (nonatomic, assign) CGRect lineF;

@property (nonatomic, assign) CGRect sourceF;

@property (nonatomic, assign) CGRect timeF;

@property (nonatomic, assign) CGSize cellSize;



@end
