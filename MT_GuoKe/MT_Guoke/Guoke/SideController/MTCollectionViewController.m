//
//  MTCollectionViewController.m
//  MT_Guoke
//
//  Created by Austen on 16/2/16.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import "MTCollectionViewController.h"
#import "MTCollectionTableViewCell.h"
#import "MTArticle.h"
#import "MTDetailViewController.h"
#import "MTDBTool.h"

static NSString * const identifier = @"collectionCell";

@interface MTCollectionViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *articleArray;
//@property (nonatomic, strong) NSArray *articleFrameArray;


@end

@implementation MTCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBasicAndTableView];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getAllCollectionArticles];
}

- (void)setupBasicAndTableView {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[MTCollectionTableViewCell class] forCellReuseIdentifier:identifier];
}

- (void)getAllCollectionArticles {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSArray *datas = [[MTDBTool shareDB] getAllLikeArticles];
        MTLog(@"--- %@",datas);
        self.articleArray = [datas sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            MTArticle *article1 = (MTArticle *)obj1;
            MTArticle *article2 = (MTArticle *)obj2;
            return [article2.date_picked compare:article1.date_picked];
        }];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });

}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.articleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MTCollectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.article = self.articleArray[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MTArticle * article = self.articleArray[indexPath.row];
    
    MTDetailViewController * detailVC = [[MTDetailViewController alloc] init];
    
    detailVC.articleID = article.articleID;
    
    [self.navigationController pushViewController:detailVC animated:YES];
}


#pragma mark - getter
- (NSArray *)articleArray {
    if (!_articleArray) {
        _articleArray = [NSArray array];
    }
    return _articleArray;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.frame = self.view.bounds;
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.estimatedRowHeight = 80;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

@end
