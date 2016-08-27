//
//  MTSideMenuViewController.h
//  MT_Guoke
//
//  Created by Austen on 16/2/16.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MTSideMenuViewController;

@protocol MTSideMenuViewControllerDelegate <NSObject>

- (void)sideMenuController:(MTSideMenuViewController *)sideController didSelectedItemAtIndex:(NSInteger)index;

@end

@interface MTSideMenuViewController : UIViewController

@property (nonatomic, weak) id<MTSideMenuViewControllerDelegate>delegate;

@end
