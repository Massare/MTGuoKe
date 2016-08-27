//
//  MTSideMenuViewController.m
//  MT_Guoke
//
//  Created by Austen on 16/2/16.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import "MTSideMenuViewController.h"
#import "MTCenterViewController.h"
#import "MTSideMenuTableViewCell.h"

@interface MTSideMenuViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *imageArray;

@end

static NSString * const identifierSideCell = @"sideCell";

@implementation MTSideMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBasic];
    
    [self setupTableView];
}

- (void)setupBasic {
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setupTableView {
    self.tableView.backgroundColor = MTSideBackgroundColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.rowHeight = 55;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(20, 0, 0, 0));
    }];
    
    [self.tableView registerClass:[MTSideMenuTableViewCell class] forCellReuseIdentifier:identifierSideCell];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MTSideMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierSideCell forIndexPath:indexPath];
    
    [cell setCellWithTitle:self.titleArray[indexPath.row] image:self.imageArray[indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.viewDeckController toggleLeftViewAnimated:YES];
    
    if ([self.delegate respondsToSelector:@selector(sideMenuController:didSelectedItemAtIndex:)]) {
        [self.delegate sideMenuController:self didSelectedItemAtIndex:indexPath.row];
    }
}

#pragma mark - getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"首页", @"我的收藏", @"设置", @"与我们交流"];
    }
    return _titleArray;
}

- (NSArray *)imageArray {
    if (!_imageArray) {
        _imageArray = @[@"menu_home_press", @"menu_collection_press", @"menu_settings_press", @"menu_mail_press"];
    }
    return _imageArray;
}

@end
