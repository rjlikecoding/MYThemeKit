//
//  UITabBar+Theme.m
//  GKBB-iOS
//
//  Created by my on 16/7/12.
//  Copyright © 2016年 xkw. All rights reserved.
//  负责人：马毅

#import "UITabBar+Theme.h"
#import "MYThemeKit.h"
@implementation UITabBar (Theme)
- (void)setTabBarGray
{
    [self my_setColorConfigWithTheme:ThemeType_Normal Property:@"tintColor" Color:@"blue"];
    [self my_setColorConfigWithTheme:ThemeType_Night Property:@"tintColor" Color:@"blueNight"];
    
    [self my_setColorConfigWithTheme:ThemeType_Normal Property:@"barTintColor" Color:@"bgGray"];
    [self my_setColorConfigWithTheme:ThemeType_Night Property:@"barTintColor" Color:@"bgGrayNight"];
    [self updateThemeColor];
}


@end
