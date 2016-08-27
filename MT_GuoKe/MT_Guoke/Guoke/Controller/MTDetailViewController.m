//
//  MTDetailViewController.m
//  MT_Guoke
//
//  Created by Austen on 16/2/16.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import "MTDetailViewController.h"
#import "MTCommentView.h"
#import "MTCommentViewController.h"
#import "MTArticle.h"
#import "MTDBTool.h"
#import <AFNetworking.h>
#import <MJExtension.h>

#define ArticleHTML @"http://jingxuan.guokr.com/pick/v2/%@/"
static NSString * kArticleURL = @"http://apis.guokr.com/handpick/article.json";

@interface MTDetailViewController ()<MTCommentViewDelegate>

@property (nonatomic, strong) UIBarButtonItem * shareItem;

@property (nonatomic, strong) UIButton * favoriteBtn;

@property (nonatomic, strong) UIBarButtonItem * commentItem;

@property (nonatomic, strong) UIWebView * webView;

@property (nonatomic, strong) MTArticle * article;

@end

@implementation MTDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBasic];
    
    [self setupNavigationItems];
//
    [self setupWebView];
//
    [self setupCommentView];
//
    [self fetchArticleInfo];
//

    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self checkArticleCollectionStatus];
}

- (void)setupBasic {
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setupNavigationItems {
    // 缩小右边空格
    UIBarButtonItem * fixRightSpaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixRightSpaceItem.width = -5;
    
    // 每个item间隔
    UIBarButtonItem * spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = 20;
    
    UIBarButtonItem * favoriteItem = [[UIBarButtonItem alloc] initWithCustomView:self.favoriteBtn];
    
    self.navigationItem.rightBarButtonItems = @[fixRightSpaceItem, self.commentItem, spaceItem, favoriteItem, spaceItem, self.shareItem];
}

- (void)setupWebView {
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 44, 0));
    }];
    
    // 下拉刷新
    self.webView.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.webView.scrollView.mj_header endRefreshing];
    }];
}

- (void)setupCommentView {
    MTCommentView *comment = [[MTCommentView alloc] init];
    comment.delegate = self;
    [self.view addSubview:comment];
    
    [comment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.bottom.and.right.equalTo(self.view);
        make.height.equalTo(@44);
    }];
}

- (void)fetchArticleInfo {
    NSDictionary *param = @{ @"pick_id" : self.articleID};
    [[AFHTTPSessionManager manager] GET:kArticleURL parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableArray *array = [MTArticle mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        self.article = array.firstObject;
        
        [self handleHTML];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

- (void)handleHTML {
    // 图片属性
    NSString * imageHTML = [NSString stringWithFormat:@"<img src=\"%@\" width = \"303\" height = \"180\">", _article.headline_img_tb];
    
    // 创建日期
    NSDateFormatter * fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm";
    
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:[_article.date_created longLongValue]];
    NSString * dateStr = [fmt stringFromDate:date];
    
    // <h1 style="font-family:verdana;">A heading</h1>
    //    <p style="font-family:arial;color:red;font-size:20px;">A paragraph.</p>
    // 作者 . 日期
    NSString * authorAndDate = [NSString stringWithFormat:@"%@ . %@", _article.author, dateStr];
    
    //    NSString * authorHTML = [NSString stringWithFormat:@"<p style=\"font-family:arial;color:gray;font-size:20px;\">%@</p>", authorAndDate];
    
    NSString * authorHTML = @"<div>测试</div>";
    
    // 最终拼接的HTML
    NSString * finalHTML = [NSString stringWithFormat:@"%@%@%@", imageHTML, _article.content, authorHTML];
    
    [self.webView loadHTMLString:finalHTML baseURL:nil];
}

- (void)checkArticleCollectionStatus {
    if ([[MTDBTool shareDB] isExistArticleWithID:self.articleID]) {   // 已收藏过文章
        
        self.favoriteBtn.selected = YES;
        
    } else {
        
        self.favoriteBtn.selected = NO;
    }
}

#pragma mark - MTCommentViewDelegate
- (void)commentViewDidClick:(MTCommentView *)commentView {
    
}

#pragma mark - UIBarButtonItem - click 
- (void)didClickShareItem {
    MTCommentViewController *commentVC = [[MTCommentViewController alloc] init];
    commentVC.title = @"评论";
    [self.navigationController pushViewController:commentVC animated:YES];
}

- (void)didClickFavoriteItem {
    self.favoriteBtn.selected = !self.favoriteBtn.selected;
    
    if (self.favoriteBtn.selected) {    // 收藏
        
        [[MTDBTool shareDB] likeArticle:self.article];
        
    } else {                            // 取消收藏
        
        [[MTDBTool shareDB] dislikeArticle:self.article];
    }
}

- (void)didclickCommentItem {
    MTCommentViewController *commentVC = [[MTCommentViewController alloc] init];
    commentVC.title = @"评论";
    [self.navigationController pushViewController:commentVC animated:YES];
}

#pragma mark - getter
- (UIWebView *)webView {
    
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        [self.view addSubview:_webView];
    }
    return _webView;
}


- (UIBarButtonItem *)shareItem {
    
    if (!_shareItem) {
        _shareItem = [UIBarButtonItem itemWithImage:@"article_btn_share" highlightedImage:@"article_btn_share_press" target:self action:@selector(didClickShareItem)];
    }
    return _shareItem;
}

- (UIButton *)favoriteBtn {
    
    if (!_favoriteBtn) {
        _favoriteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_favoriteBtn setBackgroundImage:[UIImage imageNamed:@"article_btn_like"]
                                forState:UIControlStateNormal];
        [_favoriteBtn setBackgroundImage:[UIImage imageNamed:@"article_btn_like_press"]
                                forState:UIControlStateSelected];
        _favoriteBtn.size = _favoriteBtn.currentBackgroundImage.size;
        _favoriteBtn.adjustsImageWhenHighlighted = NO;
        [_favoriteBtn addTarget:self
                         action:@selector(didClickFavoriteItem)
               forControlEvents:UIControlEventTouchDown];
    }
    return _favoriteBtn;
}

- (UIBarButtonItem *)commentItem {
    
    if (!_commentItem) {
        _commentItem = [UIBarButtonItem itemWithImage:@"article_nav_review_press" highlightedImage:@"article_nav_review" target:self action:@selector(didclickCommentItem)];
    }
    return _commentItem;
}



@end
