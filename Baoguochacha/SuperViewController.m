//
//  SuperViewController.m
//  Baoguochacha
//
//  Created by tiny on 2017/9/18.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import "SuperViewController.h"

@interface SuperViewController ()

@end

@implementation SuperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HEX_RGB(0xffffff);
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
}

- (UIImageView *)titleImageView
{
    if(!_titleImageView) {
        _titleImageView = [UIImageView new];
        _titleImageView.frame = CGRectMake(0, 0, SW, 64);
        _titleImageView.userInteractionEnabled = YES;
        _titleImageView.backgroundColor = Default_Color;
    }
    return _titleImageView;
}

- (UIButton *)leftButton
{
    if(!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftButton.frame = CGRectMake(5, 20, 44, 44);
        _leftButton.titleLabel.textColor = HEX_RGB(0xffffff);
        _leftButton.titleLabel.font = iFont(kFontName_PF_M, 12);
        [_leftButton addTarget:self action:@selector(leftButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftButton;
}

- (UIButton *)rightButton
{
    if(!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.frame = CGRectMake(SW - 5 - 44, 20, 44, 44);
        _rightButton.titleLabel.textColor = HEX_RGB(0xffffff);
        _rightButton.titleLabel.font = iFont(kFontName_PF_M, 12);
        [_rightButton addTarget:self action:@selector(rightButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _rightButton;
}

- (UILabel *)titleLabel
{
    if(!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.frame = CGRectMake(50, 20, SW - 100, 44);
        _titleLabel.textColor = HEX_RGB(0xffffff);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = iFont(kFontName_PF_M, 20);
    }
    return _titleLabel;
}

- (void)setTitle:(NSString *)title leftText:(NSString *)leftText rightText:(NSString *)rightText
{
    [self setTitle];
    
    _titleLabel.text = title;
    [_leftButton setTitle:leftText forState:UIControlStateNormal];
    [_rightButton setTitle:rightText forState:UIControlStateNormal];
    
    if([leftText isEqualToString:@""]) {_leftButton.userInteractionEnabled = NO;} else {_leftButton.userInteractionEnabled = YES;}
    if([rightText isEqualToString:@""]) {_rightButton.userInteractionEnabled = NO;} else {_rightButton.userInteractionEnabled = YES;}
}

- (void)setTitle:(NSString *)title leftImage:(UIImage *)leftImage rightText:(NSString *)rightText
{
    [self setTitle];
    
    _titleLabel.text = title;
    [_leftButton setImage:leftImage forState:UIControlStateNormal];
    [_rightButton setTitle:rightText forState:UIControlStateNormal];
    
    if(leftImage) { _leftButton.userInteractionEnabled = YES; } else {_leftButton.userInteractionEnabled = NO; }
    if([rightText isEqualToString:@""]) {_rightButton.userInteractionEnabled = NO;} else {_rightButton.userInteractionEnabled = YES;}
}

- (void)setTitle:(NSString *)title leftText:(NSString *)leftText rightImage:(UIImage *)rightImage
{
    [self setTitle];
    
    _titleLabel.text = title;
    [_leftButton setTitle:leftText forState:UIControlStateNormal];
    [_rightButton setImage:rightImage forState:UIControlStateNormal];
    
    if([leftText isEqualToString:@""]) {_leftButton.userInteractionEnabled = NO;} else {_leftButton.userInteractionEnabled = YES;}
    if(rightImage) { _rightButton.userInteractionEnabled = YES; } else {_rightButton.userInteractionEnabled = NO; }
}

- (void)setTitle:(NSString *)title leftImage:(UIImage *)leftImage rightImage:(UIImage *)rightImage
{
    [self setTitle];
    
    _titleLabel.text = title;
    [_leftButton setImage:leftImage forState:UIControlStateNormal];
    [_rightButton setImage:rightImage forState:UIControlStateNormal];
    
    if(leftImage) { _leftButton.userInteractionEnabled = YES; } else {_leftButton.userInteractionEnabled = NO; }
    if(rightImage) { _rightButton.userInteractionEnabled = YES; } else {_rightButton.userInteractionEnabled = NO; }
}

- (void)setTitle
{
    [self.view addSubview:self.titleImageView];
    [_titleImageView addSubview:self.leftButton];
    [_titleImageView addSubview:self.rightButton];
    [_titleImageView addSubview:self.titleLabel];
}

- (void)hideTitle
{
    self.titleImageView.hidden = YES;
    self.leftButton.hidden = YES;
    self.rightButton.hidden = YES;
    self.titleLabel.hidden = YES;
}

- (void)rightButtonAction
{
    NSLog(@"rightButtonAction");
}


- (void)leftButtonAction
{
    NSLog(@"leftButtonAction");
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSString *)dateToString:(NSDate *)date format:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:date];
}


#pragma mark Hud

- (void)showTip:(NSString *)text {
    [MBProgressHUD showTip:text];
}

- (void)showTip:(NSString *)text toView:(UIView *)view {
    [MBProgressHUD showTip:text toView:view];
}

- (void)showSuccess:(NSString *)success {
    [MBProgressHUD showSuccess:success];
}
- (void)showSuccess:(NSString *)success toView:(UIView *)view {
    [MBProgressHUD showSuccess:success toView:view];
}

- (void)showError:(NSString *)error {
    [MBProgressHUD showError:error];
}
- (void)showError:(NSString *)error toView:(UIView *)view {
    [MBProgressHUD showError:error toView:view];
}

- (MBProgressHUD *)showMessage:(NSString *)message {
    return [MBProgressHUD showMessage:message];
}
- (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    return [MBProgressHUD showMessage:message toView:view];
}

- (void)hideHUD {
    [MBProgressHUD hideHUD];
}
- (void)hideHUDForView:(UIView *)view {
    [MBProgressHUD hideHUDForView:view];
}

//将Dictionary和Array转化为NSString
- (NSString *)dictionaryOrArrayToJsonString:(id)dictOrArray
{
    NSData * data = [NSJSONSerialization dataWithJSONObject:dictOrArray options:NSJSONWritingPrettyPrinted error:nil];
    NSString * jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return jsonString;
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
