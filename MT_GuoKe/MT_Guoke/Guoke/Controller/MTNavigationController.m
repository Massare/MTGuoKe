//
//  MTNavigationController.m
//  MT_Guoke
//
//  Created by Austen on 16/2/16.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import "MTNavigationController.h"



@interface MTNavigationController ()

@end

@implementation MTNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    UIBarButtonItem *leftItem = nil;
    if (self.childViewControllers.count == 0) {
        leftItem = [UIBarButtonItem itemWithImage:@"nav_menuBtn" highlightedImage:@"nav_menuBtn_press" target:self action:@selector(leftBarItemClick)];
    }else {
        leftItem = [UIBarButtonItem itemWithImage:@"nav_back" highlightedImage:@"nav_back_press" target:self action:@selector(backBarButtonItemClick)];
    }
    viewController.navigationItem.leftBarButtonItems = [self fixLeftSpaceWithItem:leftItem];

    [super pushViewController:viewController animated:animated];
}

- (NSArray *)fixLeftSpaceWithItem:(UIBarButtonItem *)item {
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = -15;
    return @[spaceItem,item];
}

- (void)leftBarItemClick {
    [[NSNotificationCenter defaultCenter] postNotificationName:MTNavigationLeftItemClickNotification object:nil];
}

- (void)backBarButtonItemClick {
    [self popViewControllerAnimated:YES];
}

@end
