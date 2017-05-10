//
//  NSObject+Theme.h
//  LYrecite
//
//  Created by my on 16/12/2.
//  Copyright © 2016年 DS6GKBB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MYThemeKit.h"
@interface NSObject (Theme)
@property (nonatomic,strong,readonly) MYThemeManager *themeManager;
@property (nonatomic,strong) NSString *objType; //确定对象类型，用于从配置文件中读取配置信息
@property (nonatomic,strong) NSArray *selArray; //用于颜色更新的方法数组
@property (nonatomic,strong) NSDictionary *configInfo; //控件的颜色配置信息 包括了所有主题的配置信息，key为主题的字符串，value仍然是字典，存储的内容为需要修改的属性以及对应的颜色值
@property (nonatomic,strong) NSDictionary *currentConfigInfo; //当前主题的配色信息
@property (nonatomic,assign) NSInteger changeAuto; //标记是否自动更新状态 1表示自动更新颜色配置
- (void)updateThemeColor;

/**
 *  更新控件的颜色设置 更新指定主题的指定属性的颜色配置
 *
 *  @param theme    对应主题
 *  @param property 对应属性
 *  @param colorKey 对应颜色Key或者是uicolor
 */
- (void)my_setColorConfigWithTheme:(NSString *)theme Property:(NSString *)property Color:(id)colorKey;

@end
