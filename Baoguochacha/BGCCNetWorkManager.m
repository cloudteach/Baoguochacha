//
//  BGCCNetWorkManager.m
//  Baoguochacha
//
//  Created by tiny on 2017/9/18.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "BGCCNetWorkManager.h"
#import "SuperManager.h"

@implementation BGCCNetWorkManager

- (void)getEMSWithParam:(NSDictionary *)param success:(RequestSuccessBlock)success failed:(RequestFailedBlock)failed
{
    [[SuperManager manager] methodGetRequestWithUrl:@"" withParam:param success:^(NSDictionary *result) {
        success(result);
    } failed:^(NSError *error) {
        failed(error);
    }];
}

@end
