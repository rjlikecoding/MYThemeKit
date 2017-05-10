//
//  UIView+Theme.h
//  MYThemeTest
//
//  Created by my on 16/5/30.
//  Copyright © 2016年 mayi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYThemeManager.h"
#import "NSObject+DeallocObj.h"
#import "NSObject+Theme.h"


@interface UIView (Theme)
@property (nonatomic,strong) UIView *my_nightView; //夜间模式的遮罩层
@property (nonatomic,assign) NSInteger showNightView; //标记夜间模式是否显示遮罩 0 不显示 1显示
//- (void)updateThemeColor;

//设置边框颜色
- (void)my_setBorderNormal:(NSString *)normalStr Night:(NSString *)nightStr;
- (void)my_setBorderNormalColor:(UIColor *)normalColor Night:(UIColor *)nightColor;
//设置背景颜色
- (void)my_setBgNormal:(NSString *)normalStr Night:(NSString *)nightStr;

//设置背景颜色 同时指定
- (void)ya_setBgColorWithCommonKey:(NSString *)commonKey;
- (void)my_setBgNormalColor:(UIColor *)normalColor NightColor:(UIColor *)nightColor;

- (void)my_setTintColorNormal:(NSString *)normal Night:(NSString *)night;

//颜色设置
- (void)my_setGrayBg; //设置灰色背景
- (void)my_setBlueBg; //设置蓝色背景
- (void)my_setWhiteBg;
- (void)my_setSepGrayBg;
- (void)my_setClearBg; //设置透明背景色

- (void)my_setGrayBorder; //设置灰色边框
- (void)my_setBlueBorder; //设置蓝色边框
- (void)my_setTextNormalBorder;

- (void)my_setWhiteTintColor; //设置白色的tintColor
- (void)my_setGrayTintColor;
- (void)my_setBlueTintColor;
@end
