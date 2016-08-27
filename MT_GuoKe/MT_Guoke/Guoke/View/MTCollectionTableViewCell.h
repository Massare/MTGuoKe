//
//  MTCollectionTableViewCell.h
//  MT_Guoke
//
//  Created by Austen on 16/2/17.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MTArticle;
@class MTArticleFrame;

@interface MTCollectionTableViewCell : UITableViewCell

@property (nonatomic, strong) MTArticle *article;

//@property (nonatomic, strong) MTArticleFrame *articleFrame;

@end
