//
//  PathViewController.h
//  Baoguochacha
//
//  Created by tiny on 2017/9/18.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "SuperViewController.h"

@interface PathViewController : SuperViewController
@property(nonatomic,strong)NSDictionary *dicInfo;
@end

@interface PathCell : UITableViewCell
@property (nonatomic,strong) UIImageView *imageViewIcon;
@property (nonatomic,strong) UILabel *labelContext;
@property (nonatomic,strong) UILabel *labelTime;
@property (nonatomic,strong) UIImageView *imageViewVLine;
- (void)data:(NSDictionary *)dic index:(NSInteger)row totle:(NSInteger)totle;
@end
