//
//  MTCommentViewController.m
//  MT_Guoke
//
//  Created by Austen on 16/2/16.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import "MTCommentViewController.h"
#import "MTCommentView.h"

@interface MTCommentViewController ()

@end

@implementation MTCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupCommentView];
}

- (void)setupCommentView {
    MTCommentView *commentView = [[MTCommentView alloc] init];
    [self.view addSubview:commentView];
    
    [commentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.equalTo(@44);
    }];
    
}

@end
