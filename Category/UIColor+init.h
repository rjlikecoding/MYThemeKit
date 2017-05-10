//
//  UIColor+init.h
//  GKBB-iOS
//
//  Created by my on 16/6/30.
//  Copyright © 2016年 xkw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYThemeKit.h"
@interface UIColor (init)

/**
 *  根据一定格式的字符串解析获得颜色值
 *
 *  @param str 解析的字符串
 *
 *  @return 生成的颜色值
 */
+ (UIColor *)colorWithStr:(NSString *)str;



@end
