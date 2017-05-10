//
//  UITextField+Theme.h
//  LYrecite
//
//  Created by YuAng on 2016/12/19.
//  Copyright © 2016年 DS6GKBB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Theme)
- (void)my_setGrayText; //设置浅色文字颜色
- (void)my_setNormalText; //设置正常文字颜色 配置表格默认为正常文字颜色
- (void)my_setTextBlue; //设置蓝色文字
- (void)my_setTextWhite; //设置白色文字
- (void)my_setTextLightBlue2; //设置浅蓝色文字
- (void)my_setTextColorNormal:(NSString *)normal night:(NSString *)night;
@end
