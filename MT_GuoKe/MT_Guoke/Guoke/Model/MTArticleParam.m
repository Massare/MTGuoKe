//
//  MTArticleParam.m
//  MT_Guoke
//
//  Created by Austen on 16/2/16.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import "MTArticleParam.h"

@implementation MTArticleParam

- (instancetype)init {
    if (self = [super init]) {
        _retrieve_type = @"by_since";
        _since = @"";
        _orientation = @"before";
        _category = @"all";
        _ad = @"1";
    }
    return self;
}

+ (instancetype)paramWithPickedDate:(NSString *)pickedDate {
    return [[self alloc] initWithPickedDate:pickedDate];
}

- (instancetype)initWithPickedDate:(NSString *)pickedDate {
    if (self = [super init]) {
        _since = pickedDate;
    }
    return self;
}


@end
