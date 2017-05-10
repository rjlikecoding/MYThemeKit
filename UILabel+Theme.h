//
//  UILabel+Theme.h
//  GKBB-iOS
//
//  Created by my on 16/7/4.
//  Copyright © 2016年 xkw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Theme)
- (void)my_setGrayText; //设置浅色文字颜色
- (void)my_setNormalText; //设置正常文字颜色 配置表格默认为正常文字颜色
- (void)my_setTextBlue; //设置蓝色文字
- (void)my_setTextWhite; //设置白色文字
- (void)my_setTextLightBlue2; //设置浅蓝色文字
- (void)my_setTextColorNormal:(NSString *)normal night:(NSString *)night;
- (void)my_setHighlightTextColorBlue;
- (void)my_setHighlightedTextColorNormal:(NSString *)normal night:(NSString *)night ;
@end
