//
//  SuperViewController.h
//  Baoguochacha
//
//  Created by tiny on 2017/9/18.
//  Copyright © 2017年 tiny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD+NJ.h"

@interface SuperViewController : UIViewController
@property (nonatomic, strong) UIImageView *titleImageView;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UILabel *titleLabel;

- (void)setTitle:(NSString *)title leftText:(NSString *)leftText rightText:(NSString *)rightText;

- (void)setTitle:(NSString *)title leftImage:(UIImage *)leftImage rightText:(NSString *)rightText;

- (void)setTitle:(NSString *)title leftText:(NSString *)leftText rightImage:(UIImage *)rightImage;

- (void)setTitle:(NSString *)title leftImage:(UIImage *)leftImage rightImage:(UIImage *)rightImage;

- (void)rightButtonAction;

- (void)leftButtonAction;

- (void)hideTitle;

- (NSString *)dateToString:(NSDate *)date format:(NSString *)format;

- (void)showTip:(NSString *)text;
- (void)showTip:(NSString *)text toView:(UIView *)view;

- (void)showSuccess:(NSString *)success;
- (void)showSuccess:(NSString *)success toView:(UIView *)view;

- (void)showError:(NSString *)error;
- (void)showError:(NSString *)error toView:(UIView *)view;

- (MBProgressHUD *)showMessage:(NSString *)message;
- (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;

- (void)hideHUD;
- (void)hideHUDForView:(UIView *)view;

- (NSString *)dictionaryOrArrayToJsonString:(id)dictOrArray;
@end
