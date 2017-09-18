//
//  PathViewController.m
//  Baoguochacha
//
//  Created by tiny on 2017/9/18.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "PathViewController.h"

@interface PathViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *arrData;
}
@property (nonatomic,strong)UITableView *tableView;
@end

@implementation PathViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"物流信息" leftText:@"返回" rightText:@""];

    arrData = _dicInfo[@"data"];
    if(arrData.count) {
        [self.tableView reloadData];
    }
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PathCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell) {
        cell = [[PathCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell data:arrData[indexPath.row] index:indexPath.row totle:arrData.count];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableView *)tableView
{
    if(!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SW, SH-64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 50;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

@interface PathCell()

@end

@implementation PathCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.labelTime];
        [_labelTime mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(12);
            make.left.equalTo(self.contentView.mas_left).offset(12+16+12);
            make.height.mas_offset(14);
        }];
        
        [self.contentView addSubview:self.labelContext];
        [_labelContext mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_labelTime.mas_bottom).offset(6);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
            make.left.equalTo(_labelTime.mas_left).offset(0);
            make.right.equalTo(self.contentView.mas_right).offset(-12);
        }];
        
        [self.contentView addSubview:self.imageViewIcon];
        [_imageViewIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_labelContext.mas_centerY).offset(0);
            make.left.equalTo(self.contentView.mas_left).offset(12);
            make.width.height.mas_offset(16);
        }];
        
        [self.contentView insertSubview:self.imageViewVLine belowSubview:_imageViewIcon];
        [_imageViewVLine mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_imageViewIcon.mas_centerX).offset(0);
            make.top.equalTo(self.contentView.mas_top).offset(0);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
            make.width.mas_offset(0.5);
        }];
        
    }
    return self;
}

- (void)data:(NSDictionary *)dic index:(NSInteger)row totle:(NSInteger)totle
{
    _labelTime.text = dic[@"time"];
    _labelContext.text = dic[@"context"];
    
    _imageViewIcon.image = [UIImage imageNamed:@"greenCircle"];
    
    if(0 == row) {
        _imageViewIcon.image = [UIImage imageNamed:@"redCircle"];
        [_imageViewVLine mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_imageViewIcon.mas_centerX).offset(0);
            make.top.equalTo(_imageViewIcon.mas_centerY).offset(0);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
            make.width.mas_offset(0.5);
        }];
    }else if(totle-1 == row) {
        [_imageViewVLine mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_imageViewIcon.mas_centerX).offset(0);
            make.top.equalTo(self.contentView.mas_top).offset(0);
            make.bottom.equalTo(_imageViewIcon.mas_centerY).offset(0);
            make.width.mas_offset(0.5);
        }];
    }else {
        [_imageViewVLine mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_imageViewIcon.mas_centerX).offset(0);
            make.top.equalTo(self.contentView.mas_top).offset(0);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
            make.width.mas_offset(0.5);
        }];
    }
}

- (UIImageView *)imageViewIcon
{
    if(!_imageViewIcon) {
        _imageViewIcon = [[UIImageView alloc] init];
        _imageViewIcon.image = [UIImage imageNamed:@"redCircle"];
    }
    return _imageViewIcon;
}

- (UILabel *)labelContext
{
    if(!_labelContext) {
        _labelContext = [UILabel new];
        _labelContext.textColor = HEX_RGB(0x666666);
        _labelContext.font = iFont(kFontName_PF_M, 13);
        _labelContext.numberOfLines = 0;
    }
    return _labelContext;
}

- (UILabel *)labelTime
{
    if(!_labelTime) {
        _labelTime = [UILabel new];
        _labelTime.textColor = HEX_RGB(0x999999);
        _labelTime.font = iFont(kFontName_PF_M, 12);
    }
    return _labelTime;
}

- (UIImageView *)imageViewVLine
{
    if(!_imageViewVLine) {
        _imageViewVLine = [UIImageView new];
        _imageViewVLine.backgroundColor = HEX_RGB(0xcccccc);
    }
    return _imageViewVLine;
}

@end
