//
//  UINavigationBar+Theme.m
//  GKBB-iOS
//
//  Created by my on 16/7/12.
//  Copyright © 2016年 xkw. All rights reserved.
//  负责人：马毅

#import "UINavigationBar+Theme.h"
#import "UIView+Theme.h"
#import "MYThemeConst.h"
@implementation UINavigationBar (Theme)
- (void)updateThemeColor
{
    if(self.changeAuto == 1)
    {
        if([self.themeManager.themeType isEqualToString:ThemeType_Normal])
        {
            [self setBarStyle:UIBarStyleBlack];
        }
        else
        {
            [self setBarStyle:UIBarStyleDefault];
        }
    }
}
@end
