//
//  MTHTTPTool.m
//  MT_Guoke
//
//  Created by Austen on 16/2/16.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import "MTHTTPTool.h"
#import <AFNetworking.h>

@implementation MTHTTPTool

+ (void)checkNetworkWithConnected:(void (^)())connected disconnected:(void (^)())disconnected {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWiFi:
            case AFNetworkReachabilityStatusReachableViaWWAN:
            {
                if (connected) {
                    connected();
                }
            }
                break;
            case AFNetworkReachabilityStatusNotReachable:
            case AFNetworkReachabilityStatusUnknown:
            {
                if (disconnected) {
                    disconnected();
                }
            }
                break;
        }
    }];
}

@end
