//
//  BGCCNetWorkManager.h
//  Baoguochacha
//
//  Created by tiny on 2017/9/18.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SuperManager.h"

@interface BGCCNetWorkManager : NSObject
+ (BGCCNetWorkManager *)manager;
- (void)getEMSWithParam:(NSDictionary *)param success:(RequestSuccessBlock)success failed:(RequestFailedBlock)failed;
@end
