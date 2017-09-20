//
//  HomeViewController.m
//  Baoguochacha
//
//  Created by tiny on 2017/9/18.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "HomeViewController.h"
#import "PackageModel.h"
#import "BGCCNetWorkManager.h"
#import "PathViewController.h"

BOOL isLightDevice(){
    if(SW < 375) {
        return YES;
    }
    return NO;
}

@interface HomeViewController ()
{
    NSArray *arrPackage;
    UIButton *currentButton;
}
@property(nonatomic,strong)UITextField *tfPackageNumber;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"包裹查查" leftText:@"" rightText:@""];
    
    arrPackage = @[@{@"packageName":@"申通",@"packageEnName":@"shentong"},
                       @{@"packageName":@"EMS",@"packageEnName":@"ems"},
                       @{@"packageName":@"顺丰",@"packageEnName":@"shunfeng"},
                       @{@"packageName":@"圆通",@"packageEnName":@"yuantong"},
                       @{@"packageName":@"中通",@"packageEnName":@"zhongtong"},
                       @{@"packageName":@"韵达",@"packageEnName":@"yunda"},
//                       @{@"packageName":@"天天",@"packageEnName":@"tiantian"},
//                       @{@"packageName":@"汇通",@"packageEnName":@"huitongkuaidi"},
//                       @{@"packageName":@"全峰",@"packageEnName":@"quanfengkuaidi"},
                       @{@"packageName":@"德邦",@"packageEnName":@"debangwuliu"},
                       @{@"packageName":@"宅急送",@"packageEnName":@"zhaijisong"}
                       ];
    // Do any additional setup after loading the view.
    
    [self initUI];
}

- (void)initUI
{
    UILabel *labelTitle = [[UILabel alloc] init];
    labelTitle.frame = CGRectMake(16, 64 + 20, SW, 30);
    labelTitle.text = @"请选择快递";
    [self.view addSubview:labelTitle];
    
    int countPerRow = 4;
    float header = 64 + 20 + 30 + 20;
    float distancePerRow = 10;
    float buttontHeight = 30;
    float lengthPerButton = SW/9;
    float totleHeight = ((arrPackage.count-1) / countPerRow+1)*buttontHeight+((arrPackage.count-1) / countPerRow)*distancePerRow;
    for(int i=0;i<arrPackage.count;i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(lengthPerButton*(i%countPerRow*2+1), header + i/countPerRow*(distancePerRow+buttontHeight), lengthPerButton, buttontHeight);
        button.backgroundColor = HEX_RGB(0x345678);
        [button setTitleColor:HEX_RGB(0xffffff) forState:UIControlStateNormal];
        [button setTitleColor:HEX_RGB(0x000000) forState:UIControlStateSelected];
        [button setTitle:arrPackage[i][@"packageName"] forState:UIControlStateNormal];
        if(isLightDevice()) {
            button.titleLabel.font = iFont(kFontName_PF_M, 10);
        }else {
            button.titleLabel.font = iFont(kFontName_PF_M, 12);
        }
        button.tag = i;
        [button addTarget:self action:@selector(selectPackage:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        
        if(0 == i){
            currentButton = button;
            currentButton.selected = YES;
        }
    }
    
    UILabel *labelPackage = [[UILabel alloc] init];
    labelPackage.frame = CGRectMake(16, 64 + 20 + 30 + 20 + totleHeight + 20, SW, 30);
    labelPackage.text = @"请输入单号";
    [self.view addSubview:labelPackage];
    
    [self.view addSubview:self.tfPackageNumber];
    [_tfPackageNumber mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(lengthPerButton);
        make.right.equalTo(self.view.mas_right).offset(-lengthPerButton);
        make.top.equalTo(labelPackage.mas_bottom).offset(20);
        make.height.mas_offset(30);
    }];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = HEX_RGB(0x345678);
    [button setTitleColor:HEX_RGB(0xffffff) forState:UIControlStateNormal];
    [button setTitle:@"查询" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(searchPackage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    [button mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(16);
        make.right.equalTo(self.view.mas_right).offset(-16);
        make.top.equalTo(_tfPackageNumber.mas_bottom).offset(20);
        make.height.mas_offset(30);
    }];
}

- (void)selectPackage:(UIButton *)sender
{
    currentButton.selected = NO;
    currentButton = sender;
    currentButton.selected = YES;
    
    NSLog(@"package : %@",arrPackage[sender.tag][@"packageName"]);
}

- (void)searchPackage
{
    NSString *type = arrPackage[currentButton.tag][@"packageEnName"];
    NSString *postid = _tfPackageNumber.text;
    
    if(postid.length < 1) {
        [self showTip:@"单号不能为空!!!"];
        return;
    }
    
    NSDictionary *param = @{@"type":type,@"postid":postid};
    [self showMessage:@"正在查询..."];
    weakSelf(ws);
    [[BGCCNetWorkManager manager] getEMSWithParam:param success:^(NSDictionary *result) {
        [ws hideHUD];
        if([result[@"status"] isEqualToString:@"200"]) {
            PathViewController *path = [[PathViewController alloc] init];
            path.dicInfo = result;
            [ws.navigationController pushViewController:path animated:YES];
        }else {
            [ws showError:@"数据异常!!!"];
        }
        
    } failed:^(NSError *error) {
        [ws hideHUD];
        [ws showError:@"查询失败"];
    }];
}

- (UITextField *)tfPackageNumber
{
    if(!_tfPackageNumber) {
        _tfPackageNumber = [[UITextField alloc] init];
        _tfPackageNumber.placeholder = @"请输入单号";
        _tfPackageNumber.keyboardType = UIKeyboardTypeNumberPad;
        _tfPackageNumber.textColor = HEX_RGB(0x999999);
    }
    return _tfPackageNumber;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
