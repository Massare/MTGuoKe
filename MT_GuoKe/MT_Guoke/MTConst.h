//
//  MTConst.h
//  MT_Guoke
//
//  Created by Austen on 16/2/15.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, MTCenterControllerType) {
    MTCenterControllerTypeMain = 0,
    MTCenterControllerTypeCollection,
    MTCenterControllerTypeSetting,
    MTCenterControllerTypeCommunication,
};

UIKIT_EXTERN CGFloat const kDeckControllerLeftWidth;


//MTSideMenuTableViewCell
UIKIT_EXTERN CGFloat const kIconTopAndBottomMargin;
UIKIT_EXTERN CGFloat const kIconLeftMargin;
UIKIT_EXTERN CGFloat const kIconWidthAndHeight;
UIKIT_EXTERN CGFloat const kIconAndTitleSpace;
UIKIT_EXTERN CGFloat const kIndicatorWidthAndHeight;
UIKIT_EXTERN CGFloat const kBottomLineHeight;

// MTCollectionViewCell 
UIKIT_EXTERN UIEdgeInsets const MTEdgeInsets;
UIKIT_EXTERN NSInteger const MTColumnCount;
UIKIT_EXTERN CGFloat const MTColumnMargin;
UIKIT_EXTERN CGFloat const MTRowMargin;
UIKIT_EXTERN CGFloat const MTTitleLeftMargin;
UIKIT_EXTERN CGFloat const MTTitleMaxHeight;
UIKIT_EXTERN CGFloat const MTSourceButtonHeight;

UIKIT_EXTERN NSString * const MTNavigationLeftItemClickNotification;


//MTCollectionTableViewCell
UIKIT_EXTERN CGFloat const kTitleTopPadding;
UIKIT_EXTERN CGFloat const kTitleLeftPadding;
UIKIT_EXTERN CGFloat const kTitleAndSummarySpacing;















