//
//  BGCCNetWorkManager.m
//  Baoguochacha
//
//  Created by tiny on 2017/9/18.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "BGCCNetWorkManager.h"

@implementation BGCCNetWorkManager

+ (BGCCNetWorkManager *)manager
{
    Singleton(BGCCNetWorkManager, manager);
    return manager;
}

- (void)getEMSWithParam:(NSDictionary *)param success:(RequestSuccessBlock)success failed:(RequestFailedBlock)failed
{
    [[SuperManager manager] methodGetRequestWithUrl:[NSString stringWithFormat:@"http://www.kuaidi100.com/query"] withParam:param success:^(NSDictionary *result) {
        success(result);
    } failed:^(NSError *error) {
        failed(error);
    }];
}

@end
