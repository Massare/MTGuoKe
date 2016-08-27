//
//  MTHTTPTool.h
//  MT_Guoke
//
//  Created by Austen on 16/2/16.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTHTTPTool : NSObject

+ (void)checkNetworkWithConnected:(void(^)())connected disconnected:(void(^)())disconnected;

@end
