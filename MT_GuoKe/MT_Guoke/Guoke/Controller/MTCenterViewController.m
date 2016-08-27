//
//  MTCenterViewController.m
//  MT_Guoke
//
//  Created by Austen on 16/2/16.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import "MTCenterViewController.h"
#import "MTMainViewController.h"
#import "MTCollectionViewController.h"
#import "MTSettingTableViewController.h"
#import "MTCommunicationViewController.h"
#import "MTNavigationController.h"

#define MainStoryboard [UIStoryboard storyboardWithName:@"Main" bundle:nil]

@interface MTCenterViewController ()<IIViewDeckControllerDelegate>

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) UIViewController *currentController;
@property (nonatomic, assign, getter=isShow) BOOL show;
@property (nonatomic, strong) UIView *coverView;

@property (nonatomic, strong) MTMainViewController *mainVC;
@property (nonatomic, strong) MTCollectionViewController *collectionVC;
@property (nonatomic, strong) MTSettingTableViewController *settinVC;
@property (nonatomic, strong) MTCommunicationViewController *communicationVC;

@end

@implementation MTCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBasic];
    
    [self addChildController];
    
    [self listenNotification];
}

- (void)listenNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(letBarButtonItemClick) name:MTNavigationLeftItemClickNotification object:nil];
}

- (void)letBarButtonItemClick {
    self.show = !self.show;
    if (self.show) {
        [self.viewDeckController closeLeftViewAnimated:YES];
        [self hideCoverView];
    }else {
        [self.viewDeckController openLeftViewAnimated:YES];
        [self showCoverView];
    }
}

- (void)setupBasic {
    self.view.backgroundColor = [UIColor purpleColor];
    
    self.show = YES;
    self.viewDeckController.delegate = self;
}

- (void)addChildController {
    self.mainVC.title = self.titleArray.firstObject;
    
    MTNavigationController *nav = [[MTNavigationController alloc] initWithRootViewController:self.mainVC];
    [self.view addSubview:nav.view];
    nav.view.frame = self.view.bounds;
    
    self.currentController = nav;
    [self addChildViewController:self.currentController];
}

#pragma mark - MTSideMenuViewControllerDelegate
- (void)sideMenuController:(MTSideMenuViewController *)sideController didSelectedItemAtIndex:(NSInteger)index {
    
    [self setupCurrentControllerWithIndex:index];
}

- (void)setupCurrentControllerWithIndex:(NSInteger)index {
    [self.currentController.view removeFromSuperview];
    [self.currentController removeFromParentViewController];
    UIViewController *viewController = nil;
    switch (index) {
        case MTCenterControllerTypeMain:
            viewController = self.mainVC;
            break;
        case MTCenterControllerTypeCollection:
            viewController = self.collectionVC;
            break;
        case MTCenterControllerTypeSetting:
            viewController = self.settinVC;
            break;
        case MTCenterControllerTypeCommunication:
            viewController = self.communicationVC;
            break;
        default:
            break;
    }
    
    viewController.title = self.titleArray[index];
    MTNavigationController *nav = [[MTNavigationController alloc] initWithRootViewController:viewController];
    [self.view addSubview:nav.view];
    [self addChildViewController:nav];
    
    self.currentController = nav;
}

#pragma mark - IIViewDeckControllerDelegate
- (void)viewDeckController:(IIViewDeckController *)viewDeckController didOpenViewSide:(IIViewDeckSide)viewDeckSide animated:(BOOL)animated {
    self.show = NO;
    
    [self showCoverView];
}

- (void)viewDeckController:(IIViewDeckController *)viewDeckController didShowCenterViewFromSide:(IIViewDeckSide)viewDeckSide animated:(BOOL)animated {
    self.show = YES;
    [self hideCoverView];
}

- (void)showCoverView {
    [self.view addSubview:self.coverView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCoverView)];
    [self.coverView addGestureRecognizer:tap];
}

- (void)hideCoverView {
    [self.coverView removeFromSuperview];
    self.coverView = nil;
}

- (void)tapCoverView {
    [self hideCoverView];
    [self.viewDeckController closeLeftViewAnimated:YES];
}

#pragma mark - getter;
- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"果壳精选", @"我的收藏", @"设置", @"与我们交流"];
    }
    return _titleArray;
}

- (UIView *)coverView {
    if (!_coverView) {
        _coverView = [[UIView alloc] initWithFrame:self.view.bounds];
    }
    return _coverView;
}

- (MTMainViewController *)mainVC {
    if (!_mainVC) {
        _mainVC = [[MTMainViewController alloc] init];
    }
    return _mainVC;
}

- (MTCollectionViewController *)collectionVC {
    if (!_collectionVC) {
        _collectionVC = [[MTCollectionViewController alloc] init];
    }
    return _collectionVC;
}

- (MTSettingTableViewController *)settinVC {
    if (!_settinVC) {
        _settinVC = [MainStoryboard instantiateViewControllerWithIdentifier:@"MTSettingTableViewController"];
    }
    return _settinVC;
}

- (MTCommunicationViewController *)communicationVC {
    if (!_communicationVC) {
        _communicationVC = [MainStoryboard instantiateViewControllerWithIdentifier:@"MTCommunicationViewController"];
    }
    return _communicationVC;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MTNavigationLeftItemClickNotification object:nil];
}

@end
