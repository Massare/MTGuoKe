//
//  MTArticleParam.h
//  MT_Guoke
//
//  Created by Austen on 16/2/16.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTArticleParam : NSObject

@property (nonatomic, copy) NSString *retrieve_type;
@property (nonatomic, copy) NSString *since;
@property (nonatomic, copy) NSString *orientation;
@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *ad;

+ (instancetype)paramWithPickedDate:(NSString *)pickedDate;

@end
