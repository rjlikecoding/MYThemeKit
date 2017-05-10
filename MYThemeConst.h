//
//  MYThemeConst.h
//  LYrecite
//
//  Created by my on 16/11/29.
//  Copyright © 2016年 DS6GKBB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#pragma mark - 常量定义 -

UIKIT_EXTERN CGFloat const MaskAlpha;
UIKIT_EXTERN NSString * const CurrentThemeKey;
UIKIT_EXTERN NSString *const MYThemeChangeNotification;
UIKIT_EXTERN NSString *const ThemeType_Night;
UIKIT_EXTERN NSString *const ThemeType_Normal;
UIKIT_EXTERN NSString *const ColorConfigPath;
UIKIT_EXTERN NSString *const UIConfigPath;

#pragma mark - 颜色配置 -
UIKIT_EXTERN NSString * const btnBgBlue2Night;
UIKIT_EXTERN NSString * const btnBgBlue2;
UIKIT_EXTERN NSString * const btnBgBlueNight;
UIKIT_EXTERN NSString * const btnBgBlue;
UIKIT_EXTERN NSString * const home_bgViewNight;
UIKIT_EXTERN NSString * const home_bgView;
UIKIT_EXTERN NSString * const bgWhite;
UIKIT_EXTERN NSString * const bgWhiteNight;
UIKIT_EXTERN NSString * const bgGray;
UIKIT_EXTERN NSString * const bgGrayNight;
UIKIT_EXTERN NSString * const textNormal;
UIKIT_EXTERN NSString * const textNormalNight;
UIKIT_EXTERN NSString * const textGray;
UIKIT_EXTERN NSString * const textGrayNight;
UIKIT_EXTERN NSString * const blueColor;
UIKIT_EXTERN NSString * const blueColorNight;
UIKIT_EXTERN NSString * const textWhite;
UIKIT_EXTERN NSString * const textWhiteNight;
UIKIT_EXTERN NSString * const blackColor;
UIKIT_EXTERN NSString * const blackColorNight;
UIKIT_EXTERN NSString * const lightBlue;
UIKIT_EXTERN NSString * const lightBlueNight;
UIKIT_EXTERN NSString * const lightBlue2;
UIKIT_EXTERN NSString * const lightBlue2Night;
UIKIT_EXTERN NSString * const sepColor;
UIKIT_EXTERN NSString * const sepColorNight;
UIKIT_EXTERN NSString * const expandText;
UIKIT_EXTERN NSString * const expandTextNight;






#pragma mark - 类型定义 -
typedef NS_ENUM(NSInteger,ThemeChangeType) {
    ThemeChangeTypeImage,  //用不同图片进行切换
    ThemeChangeTypeTintColor, //用不同的tintColor进行切换
    ThemeChangeTypeMask, //通过添加蒙版的方式进行切换
};







#pragma mark - 宏定义 -
#define WEAKSELF typeof(self) __weak weakSelf = self;
#define STRONGSELF typeof(weakSelf) __strong strongSelf = weakSelf;
