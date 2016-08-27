//
//  MTMainViewController.m
//  MT_Guoke
//
//  Created by Austen on 16/2/16.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import "MTMainViewController.h"
#import "MTArticleCollectionViewCell.h"
#import "MTDetailViewController.h"
#import "MTArticle.h"
#import "MTArticleFrame.h"
#import "MTArticleParam.h"
#import "MTDBTool.h"
#import "MTHTTPTool.h"
#import <CHTCollectionViewWaterfallLayout.h>
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <MJRefresh.h>
#import <MJExtension.h>
#import "MTNavigationController.h"

@interface MTMainViewController ()<UICollectionViewDataSource, UICollectionViewDelegate,CHTCollectionViewDelegateWaterfallLayout>

//@property (nonatomic ,strong) NSMutableArray *articleArray;
@property (nonatomic, strong) NSMutableArray *articleFrameArray;


@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

static NSString * MTArticleURL = @"http://apis.guokr.com/handpick/article.json";
static NSString * const identifierCell = @"articleCell";

@implementation MTMainViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self checkNetwork];
}

- (void)checkNetwork {
    if (self.articleFrameArray.count) return;
    
    [MTHTTPTool checkNetworkWithConnected:^{
        
        // 当前网络连接正常，获取最新数据
        [self loadNewArticles];
        
    } disconnected:^{
        
        // 当前无网络，从数据库缓存中读取数据
        [self getCachedArticle];
    }];
}

- (void)getCachedArticle {
    if (self.articleFrameArray.count) {
        [self.articleFrameArray removeAllObjects];
    }
    
    [self.articleFrameArray addObjectsFromArray:[[MTDBTool shareDB] getAllArticles]];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBasic];
    
    [self addRefresh];
}

- (void)setupBasic {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[MTArticleCollectionViewCell class] forCellWithReuseIdentifier:identifierCell];
}

- (void)addRefresh {
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewArticles)];
    [self.collectionView.mj_header beginRefreshing];
    
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreArticles)];
    self.collectionView.mj_footer.hidden = YES;
}


#pragma mark - loadArticles
- (void)loadNewArticles {
    [SVProgressHUD showImage:[UIImage imageNamed:@"article_btn_like_press"] status:@"正在加载..."];
//    [SVProgressHUD setBackgroundColor:[UIColor darkGrayColor]];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];

    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"retrieve_type"] = @"by_since";
    params[@"orientation"] = @"before";
    params[@"category"] = @"all";
    params[@"ad"] = @"1";
    
    [self.manager GET:MTArticleURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self.articleFrameArray removeAllObjects];
        
        NSArray *array = [MTArticle mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        for (MTArticle *article in array) {
            MTArticleFrame *articleFrame = [[MTArticleFrame alloc] init];
            articleFrame.article = article;
            [self.articleFrameArray addObject:articleFrame];
        }
        
        MTLog(@"%ld",self.articleFrameArray.count);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
        
        [self.collectionView.mj_header endRefreshing];
        self.collectionView.mj_footer.hidden = NO;
        
        [SVProgressHUD dismiss];
        
        [self storeArticles];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.collectionView.mj_header endRefreshing];
    }];
}

- (void)loadMoreArticles {
    MTArticleFrame *articleFrame = self.articleFrameArray.lastObject;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"retrieve_type"] = @"by_since";
    params[@"orientation"] = @"before";
    params[@"category"] = @"all";
    params[@"ad"] = @"1";
    params[@"since"] = articleFrame.article.date_picked;
    
    [self.manager GET:MTArticleURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *array = [MTArticle mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        for (MTArticle *article in array) {
            MTArticleFrame *articleFrame = [[MTArticleFrame alloc] init];
            articleFrame.article = article;
            [self.articleFrameArray addObject:articleFrame];
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
        
        [self.collectionView.mj_footer endRefreshing];
        
        [self storeArticles];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.collectionView.mj_footer endRefreshing];
    }];
}

- (void)storeArticles {
    // 清空原数据
    [[MTDBTool shareDB] removeAllAritcles];
    
    // 缓存数据
    for (MTArticleFrame *articleFrame in self.articleFrameArray) {
        
        [[MTDBTool shareDB] storeArticle:articleFrame];
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.articleFrameArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MTArticleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifierCell forIndexPath:indexPath];
    cell.articleFrame = self.articleFrameArray[indexPath.item];
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    MTDetailViewController *vc = [[MTDetailViewController alloc] init];
    MTArticleFrame *articleFrame = self.articleFrameArray[indexPath.item];
    vc.articleID = articleFrame.article.articleID;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    MTArticleFrame *articleFrame = self.articleFrameArray[indexPath.item];
    return articleFrame.cellSize;
}

#pragma mark - getter
//- (NSMutableArray *)articleArray {
//    if (!_articleArray) {
//        _articleArray = [NSMutableArray array];
//    }
//    return _articleArray;
//}

- (NSMutableArray *)articleFrameArray {
    if (!_articleFrameArray) {
        _articleFrameArray = [NSMutableArray array];
    }
    return _articleFrameArray;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        layout.minimumColumnSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.frame = self.view.bounds;
        _collectionView.backgroundColor = MTGlobalBackgroundColor;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

@end
