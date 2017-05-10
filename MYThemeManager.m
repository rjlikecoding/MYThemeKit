//
//  MYThemeManager.m
//  MYThemeTest
//
//  Created by my on 16/5/26.
//  Copyright © 2016年 mayi. All rights reserved.
//  主题切换的控制器 完成配置信息读取 主题记录 主题切换逻辑
//  负责人：马毅

#import "MYThemeManager.h"
#import "MYThemeConst.h"
#import "UIColor+init.h"


@interface MYThemeManager ()
@property (nonatomic,strong) NSDictionary *colorConfigDic;
@property (nonatomic,strong) NSArray *themeArray; //主题名称的数组
@end


@implementation MYThemeManager

//+(instancetype)sharedManager
//{
//    return [[self alloc] sharedManager];
//}

+ (instancetype)sharedManager
{
    static MYThemeManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[MYThemeManager alloc] init];
        
    });
    
    return manager;
}


- (instancetype)init
{
    if(self = [super init])
    {
        //self.themeType = ThemeNormal;
        NSString *currentTheme = [[NSUserDefaults standardUserDefaults] valueForKey:CurrentThemeKey];
        if(currentTheme == nil)
        {
            [[NSUserDefaults standardUserDefaults] setValue:ThemeType_Normal forKey:CurrentThemeKey];
            currentTheme = ThemeType_Normal;
        }
        _themeType = currentTheme;
        
        [self initDic];
    }
    return self;
}


- (void)setThemeType:(NSString *)themeType
{
    _themeType = themeType;
    
     if([themeType isEqualToString:ThemeType_Normal])
     {
     NSLog(@"changeToNormal");
     }
     else if([themeType isEqualToString:ThemeType_Night])
     {
     NSLog(@"changeToNight");
     }
     
     dispatch_async(dispatch_get_main_queue(), ^{
         [[NSNotificationCenter defaultCenter] postNotificationName:MYThemeChangeNotification object:nil];
     });
}

- (void)switchTheme
{
     
    if([self.themeType isEqualToString:ThemeType_Normal])
    {
        self.themeType = ThemeType_Night;
    }
    else
    {
        self.themeType = ThemeType_Normal;
    }
    
    //self.themeType = !self.themeType;
    [[NSUserDefaults standardUserDefaults] setValue:self.themeType forKey:CurrentThemeKey];
}

//初始化配置文件
- (void)initDic
{
    NSString *path = [[NSBundle mainBundle] pathForResource:ColorConfigPath ofType:nil];
    self.colorConfigDic = [[NSDictionary alloc] initWithContentsOfFile:path];

    //path = [[NSBundle mainBundle] pathForResource:UIConfigPath ofType:nil];
    //self.uiConfigDic = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    self.themeArray = @[ThemeType_Normal,ThemeType_Night];
}


//根据颜色的key获取对应的颜色值
- (UIColor *)getColorWithKey:(NSString *)colorKey
{
    NSString *colorStr = self.colorConfigDic[colorKey];
    return [UIColor colorWithStr:colorStr];
}

//根据日间模式颜色的key获取对应主题的颜色值
- (UIColor *)getCurrentColorWithKey:(NSString *)colorKey
{
    if(![self.themeManager.themeType isEqualToString:ThemeType_Normal]){
        NSString *themeStr = [[self.themeManager.themeType lowercaseString] capitalizedString];
        colorKey = [colorKey stringByAppendingString:themeStr];
    }

    return [self getColorWithKey:colorKey];
}


/**
 根据key获取不同主题的颜色数组

 @param colorKey
 @return
 */
- (NSArray *)getColorArrayWithKey:(NSString *)colorKey
{
    NSMutableArray *colorArray = [NSMutableArray array];
    [self.themeArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIColor *color;
        NSString *key = colorKey;
        if(![obj isEqualToString:ThemeType_Normal]){
            NSString *themeStr = [[obj lowercaseString] capitalizedString];
            key = [colorKey stringByAppendingString:themeStr];
        }
        color = [self getColorWithKey:key];
        [colorArray addObject:color];
    }];
    
    return colorArray;
}



/**
 获取设置夜间模式需要的tintColor数组

 @return
 */
- (NSArray *)getNightTintColorArray
{
    return @[[NSNull null], RGBA(0.4, 0.4, 0.4, 0.4)];
}



- (BOOL)isNightModel {
    return [self.themeType isEqualToString:ThemeType_Night];
}

+ (BOOL)isNightModel {
    return [[self sharedManager]isNightModel];
}

@end
