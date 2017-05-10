//
//  NSObject+Theme.m
//  LYrecite
//
//  Created by my on 16/12/2.
//  Copyright © 2016年 DS6GKBB. All rights reserved.
//  负责人：马毅

#import "NSObject+Theme.h"
#import "MYThemeKit.h"
#import <objc/runtime.h>

@interface NSObject ()

@end


@implementation NSObject (Theme)
//根据文件类型获取对应的字符串
- (NSString *)getObjType
{
    //NSLog(@"type:%@",NSStringFromClass([self class]));
    if([self isKindOfClass:[UIButton class]])
    {
        return @"UIButton";
    }
    else if([self isKindOfClass:[UILabel class]])
    {
        return @"UILabel";
    }
    else if([self isKindOfClass:[UISlider class]])
    {
        return @"UISlider";
    }
    else if([self isKindOfClass:[UIImageView class]])
    {
        return @"UIImageView";
    }
    else if([self isKindOfClass:[DQAlertView class]])
    {
        return @"DQAlertView";
    }
    else if([self isKindOfClass:[MYActionSheet class]])
    {
        return @"MYActionSheet";
    }
    else if([self isKindOfClass:[UITabBar class]])
    {
        return @"UITabBar";
    }
    else if([self isKindOfClass:[UIView class]])
    {
        return @"UIView";
    }
    
    //NSLog(@"type:%@",NSStringFromClass([self class]));
    return nil;
}

#pragma mark - 属性设置 -
- (NSString *)objType
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setObjType:(NSString *)type
{
    objc_setAssociatedObject(self, @selector(objType), type, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSArray *)selArray
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setSelArray:(NSArray *)array
{
    objc_setAssociatedObject(self, @selector(selArray), array, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSDictionary *)configInfo
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setConfigInfo:(NSDictionary *)configInfo
{
    objc_setAssociatedObject(self, @selector(configInfo), configInfo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSDictionary *)currentConfigInfo
{
    NSDictionary *dic = self.configInfo[self.themeManager.themeType];
    [self setCurrentConfigInfo:dic];
    return objc_getAssociatedObject(self, _cmd);
}


- (void)setCurrentConfigInfo:(NSDictionary *)currentConfigInfo
{
    objc_setAssociatedObject(self, @selector(currentConfigInfo), currentConfigInfo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


#pragma mark - 程序逻辑 -
- (NSInteger)changeAuto
{
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

- (void)setChangeAuto:(NSInteger)changeAuto
{
    objc_setAssociatedObject(self, @selector(changeAuto), @(changeAuto), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if(!self.deallocObj)
    {
        if(changeAuto == 1)
        {
            WEAKSELF
            
            id observer = [[NSNotificationCenter defaultCenter] addObserverForName:MYThemeChangeNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
                [weakSelf updateThemeColor];
            }];
            
            //确定类型以及对应的selector
            self.objType = [self getObjType];
            [self initConfigInfo];
            
            //移除监听
            MYDeallocObject *deallocObj = [[MYDeallocObject alloc] initWithDeallocBlock:^{
                [[NSNotificationCenter defaultCenter] removeObserver:observer];
            }];
            self.deallocObj = deallocObj;
            //[self updateThemeColor];
        }
    }
}



/**
 主题切换逻辑 在子类中重写 不同类型的类有不同的切换逻辑
 */
- (void)updateThemeColor
{
    
}

//更新当前主题颜色的配置属性
- (void)initConfigInfo
{
    NSMutableDictionary *configInfo = [[NSMutableDictionary alloc] init];
    [self.themeManager.themeArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        //NSLog(@"%@",obj);
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        NSString *themeStr = (NSString *)obj;
        [configInfo setValue:dic forKey:themeStr];
        
        //NSDictionary *uiConfigDic = self.themeManager.uiConfigDic[self.objType];
        /*[uiConfigDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            NSString *colorKey = [obj valueForKey:themeStr];
            UIColor *color = [self.themeManager getColorWithKey:colorKey];
            [dic setValue:color forKey:key];
        }];*/
        
    }];
    
    self.configInfo = configInfo;
}


- (MYThemeManager *)themeManager
{
    return [MYThemeManager sharedManager];
}


/**
 根据传入的参数进行配置

 @param theme 需要配置的主题
 @param property 需要配置的属性
 @param colorKey 配置的颜色的字符串key或者是uicolor的值
 */
- (void)my_setColorConfigWithTheme:(NSString *)theme Property:(NSString *)property Color:(id)colorKey
{
    if(self.changeAuto == 0)
    {
        self.changeAuto = 1;
    }
    UIColor *color;
    if([colorKey isKindOfClass:[NSString class]]){
        color = [self.themeManager getColorWithKey:colorKey];
    }else if([colorKey isKindOfClass:[UIColor class]]){
        color = (UIColor *)colorKey;
    }else{
        color = [UIColor clearColor];
    }
    
    
    NSDictionary *colorConfig = [self.configInfo objectForKey:theme];
    if(colorConfig) //如果是有效的数据
    {
        [colorConfig setValue:color forKey:property];
    }
    else
    {
        NSLog(@"=========无效的主题=============");
    }
}

@end
