//
//  UIColor+init.m
//  GKBB-iOS
//
//  Created by my on 16/6/30.
//  Copyright © 2016年 xkw. All rights reserved.
//  负责人：马毅

#import "UIColor+init.h"

@implementation UIColor (init)

//读取字符串 解析出对应的16进制的颜色值
+ (CGFloat)colorComponentWithStr:(NSString *)colorStr start:(NSInteger)start length:(NSInteger)length
{
    NSString *str = [colorStr substringWithRange:NSMakeRange(start, length)];
    unsigned colorValue;
    [[NSScanner scannerWithString:str] scanHexInt:&colorValue];
    return colorValue / 255.0;
}


//解析#RRGGBB格式的字符串为对应的颜色值
+ (UIColor *)colorWithHexStr:(NSString *)str
{
    UIColor *color = nil;
    if(str.length == 6)
    {
        CGFloat red = [self colorComponentWithStr:str start:0 length:2];
        CGFloat green = [self colorComponentWithStr:str start:2 length:2];
        CGFloat blue = [self colorComponentWithStr:str start:4 length:2];
        color = [UIColor colorWithRed:red green:green blue:blue alpha:1];
    }
    
    return color;
}


/**
 *  解析字符串为颜色对象，支持不同格式的字符串解析
 *
 *  @param colorStr 要解析的字符串
 *
 *  @return 颜色对象
 */
+ (UIColor *)colorWithStr:(NSString *)str
{
    UIColor *color = nil;
    NSString *firstLetter = [str substringToIndex:1];
    if([firstLetter isEqualToString:@"#"])
    {
        color = [self colorWithHexStr:[str substringFromIndex:1]];
    }
    else
    {
        color = [self colorWithRGBStr:str];
    }
    
    return color;
}

/**
 *  r,g,b格式的字符串解析为颜色值
 *
 *  @param colorStr 传入的颜色值
 *
 *  @return
 */
+ (UIColor *)colorWithRGBStr:(NSString *)str
{
    UIColor *color = nil;
    NSArray *colorArray = [str componentsSeparatedByString:@","];
    
    if(colorArray.count == 3)
    {
        color = [UIColor colorWithRed:[colorArray[0] floatValue]/255.0 green:[colorArray[1] floatValue]/255.0 blue:[colorArray[2] floatValue]/255.0 alpha:1];
    }
    
    return color;
}

@end
