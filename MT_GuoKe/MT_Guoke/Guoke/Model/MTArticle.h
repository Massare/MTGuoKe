//
//  MTArticle.h
//  MT_Guoke
//
//  Created by Austen on 16/2/16.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "MTArticleFrame.h"

@interface MTArticle : NSObject

@property (nonatomic, copy) NSString *articleID;

@property (nonatomic, copy) NSString *headline_img_tb;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *source_name;

@property (nonatomic, copy) NSString *date_picked;

@property (nonatomic, copy) NSString *date_created;

@property (nonatomic, copy) NSString *author;

@property (nonatomic, copy) NSString *summary;

@property (nonatomic, copy) NSString *content;

//@property (nonatomic, strong) MTArticleFrame *articleFrame;

@end
