//
//  UITableView+Theme.m
//  GKBB-iOS
//
//  Created by my on 16/7/12.
//  Copyright © 2016年 xkw. All rights reserved.
//  负责人：马毅

#import "UITableView+Theme.h"
#import "UIView+Theme.h"
#import "MYThemeConst.h"
@implementation UITableView (Theme)
-(void)my_setSeperatorGrayColor
{
    [self my_setColorConfigWithTheme:ThemeType_Normal Property:@"separatorColor" Color:@"sepColor"];
    [self my_setColorConfigWithTheme:ThemeType_Night Property:@"separatorColor" Color:@"sepColorNight"];
    [self updateThemeColor];
}
@end
