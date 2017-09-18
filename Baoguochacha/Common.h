//
//  Common.h
//  Baoguochacha
//
//  Created by tiny on 2017/9/18.
//  Copyright © 2017年 tiny. All rights reserved.
//

#ifndef Common_h
#define Common_h

#define Singleton(C, I)   static C *I = nil; \
static dispatch_once_t pred; \
dispatch_once(&pred, ^{ \
I = [C new];    \
});\
return I;

#define iFont(Name, Size) [Name isEqualToString:@""]?[UIFont systemFontOfSize:Size]:[UIFont fontWithName:Name size:Size]

#define kFontName_PF_M @"PingFangSC-Medium"
#define Default_Color HEX_RGB(0x000000)

#define REQUEST_GET     @"get"
#define REQUEST_POST    @"post"
#define REQUEST_DELETE  @"delete"
#define REQUEST_PUT     @"put"

//获取屏幕 宽度、高度
#define SW  ([UIScreen mainScreen].bounds.size.width)
#define SH  ([UIScreen mainScreen].bounds.size.height)

#define weakSelf(x) __weak typeof(self) x = self;

#import "UIColor+Theme.h"
#import "UIView+Additions.h"

#import <Masonry.h>

#import "BGCCNetWorkManager.h"

#endif /* Common_h */
