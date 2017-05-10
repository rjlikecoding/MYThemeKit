//
//  UIButton+Theme.h
//  GKBB-iOS
//
//  Created by my on 16/7/4.
//  Copyright © 2016年 xkw. All rights reserved.
//  

#import <UIKit/UIKit.h>
#import "MYThemeKit.h"
@interface UIButton (Theme)
//文字颜色设置
- (void)my_setBtnTextWhite;
- (void)my_setBtnTextNormal;
- (void)my_setBtnTextBlue;
- (void)ya_setBtnTextBlue2;
- (void)my_setBtnTextGray;
- (void)my_setBtnTextBlack;
- (void)my_setTitleColors:(NSArray *)colors forState:(UIControlState)state;

//背景颜色设置
- (void)my_setBtnBgBlue;


//图片设置
- (void)my_setImageWithName:(NSString *)imageName forState:(UIControlState)state;
- (void)my_setImageWithName:(NSString *)imageName tintColors:(NSArray *)my_tintColors forState:(UIControlState)state;
- (void)my_setImageWithTintColors:(NSArray *)tintColors forState:(UIControlState)state;

//背景图片设置
- (void)my_setBgImageWithName:(NSString *)imageName forState:(UIControlState)state;
- (void)my_setBgImageWithName:(NSString *)imageName tintColors:(NSArray *)my_tintColors forState:(UIControlState)state;
- (void)my_setBgImageWithTintColors:(NSArray *)tintColors forState:(UIControlState)state;


@end
