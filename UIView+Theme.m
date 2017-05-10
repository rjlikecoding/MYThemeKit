//
//  UIView+Theme.m
//  MYThemeTest
//
//  Created by my on 16/5/30.
//  Copyright © 2016年 mayi. All rights reserved.
//  负责人：马毅

#import "UIView+Theme.h"
#import <objc/runtime.h>
#import "DQAlertView/DQAlertView.h"
#import "MYActionSheet.h"
#import "MYThemeConst.h"
@interface UIView ()

@end


@implementation UIView (Theme)

#pragma mark - 属性设置 -
- (UIView *)my_nightView
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setMy_nightView:(UIView *)my_nightView
{
    objc_setAssociatedObject(self, @selector(my_nightView), my_nightView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger)showNightView
{
    return [objc_getAssociatedObject(self, _cmd) intValue];
}

- (void)setShowNightView:(NSInteger)showNightView
{
    objc_setAssociatedObject(self, @selector(showNightView), @(showNightView), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if(!self.my_nightView)
    {
        UIView *view = [[UIView alloc] initWithFrame:self.bounds];
        view.backgroundColor = [self.themeManager getColorWithKey:@"bgWhiteNight"];
        view.alpha = MaskAlpha;
        [self setMy_nightView:view];
        [self addSubview:self.my_nightView];
        self.my_nightView.hidden = YES;
        self.changeAuto = 1;
    }
}


#pragma mark - 切换逻辑 -
- (void)updateThemeColor
{
    //读取配置文件 获得对应的主题配置信息
    if(self.changeAuto == 1)
    {
        NSDictionary *currentConfig = self.configInfo[self.themeManager.themeType];
        [currentConfig enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            NSString *firstLetter = [key substringToIndex:1];
            NSString *lastStr = [key substringFromIndex:1];
            NSString *methodStr = [NSString stringWithFormat:@"set%@%@:",[firstLetter capitalizedString],lastStr];
            UIColor *color = (UIColor *)obj;
            //NSLog(@"%@",color);
            SEL sel = NSSelectorFromString(methodStr);
            if([self respondsToSelector:sel])
            {
                
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                [self performSelector:sel withObject:color];
#pragma clang diagnostic pop
            }
            
            //按钮逻辑的单独处理
            if([methodStr isEqualToString:@"setTitleColor:"] && [self.objType isEqualToString:@"UIButton"])
            {
                UIButton *btn = (UIButton *)self;
                [btn setTitleColor:color forState:UIControlStateNormal];
            }
            
            //边框的单独处理逻辑
            if([methodStr isEqualToString:@"setBorderColor:"] && [self isKindOfClass:[UIView class]])
            {
                self.layer.borderColor = color.CGColor;
                self.layer.borderWidth = 1;
            }
        }];
    }
    
    //显示遮罩
    if(self.showNightView)
    {
        self.my_nightView.frame = self.bounds;
        self.my_nightView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self bringSubviewToFront:self.my_nightView];
        self.my_nightView.hidden = [self.themeManager.themeType isEqualToString:ThemeType_Normal];
    }
}

#pragma mark - 配色设置 -


/**
 *  设置灰色背景
 */
- (void)my_setGrayBg
{
    [self my_setBgNormal:@"bgGray" Night:@"bgGrayNight"];
}

- (void)my_setBlueBg
{
    [self my_setBgNormal:@"blue" Night:@"blueNight"];
}

- (void)my_setWhiteBg
{
    [self my_setBgNormal:@"bgWhite" Night:@"bgWhiteNight"];
}

- (void)my_setSepGrayBg
{
    [self my_setBgNormal:@"sepColor" Night:@"sepColorNight"];
}

- (void)my_setClearBg
{
    [self my_setBgNormalColor:[UIColor clearColor] NightColor:[UIColor clearColor]];
}
/**
 *  设置背景颜色
 *
 *  @param normalStr 日间模式
 *  @param nightStr  夜间模式
 */
- (void)my_setBgNormal:(NSString *)normalStr Night:(NSString *)nightStr
{
    [self my_setColorConfigWithTheme:ThemeType_Normal Property:@"backgroundColor" Color:normalStr];
    [self my_setColorConfigWithTheme:ThemeType_Night Property:@"backgroundColor" Color:nightStr];
    [self updateThemeColor];
}

- (void)ya_setBgColorWithCommonKey:(NSString *)commonKey {
    [self my_setBgNormal:commonKey Night:[commonKey stringByAppendingString:@"Night"]];
}

- (void)my_setBgNormalColor:(UIColor *)normalColor NightColor:(UIColor *)nightColor
{
    [self my_setColorConfigWithTheme:ThemeType_Normal Property:@"backgroundColor" Color:normalColor];
    [self my_setColorConfigWithTheme:ThemeType_Night Property:@"backgroundColor" Color:nightColor];
    [self updateThemeColor];
}

/**
 根据传入的内容进行颜色设置

 @param normal 日间模式的内容
 @param night 夜间模式的内容
 */
- (void)my_setTintColorNormal:(NSString *)normal Night:(NSString *)night
{
    [self my_setColorConfigWithTheme:ThemeType_Normal Property:@"tintColor" Color:normal];
    [self my_setColorConfigWithTheme:ThemeType_Night Property:@"tintColor" Color:night];
    [self updateThemeColor];
}
/**
 *  设置边框颜色
 *
 *  @param normalStr 日间模式
 *  @param nightStr  夜间模式
 */
- (void)my_setBorderNormal:(NSString *)normalStr Night:(NSString *)nightStr
{
    [self my_setColorConfigWithTheme:ThemeType_Normal Property:@"borderColor" Color:normalStr];
    [self my_setColorConfigWithTheme:ThemeType_Night Property:@"borderColor" Color:nightStr];
    [self updateThemeColor];
}

- (void)my_setBorderNormalColor:(UIColor *)normalColor Night:(UIColor *)nightColor
{
    [self my_setColorConfigWithTheme:ThemeType_Normal Property:@"borderColor" Color:normalColor];
    [self my_setColorConfigWithTheme:ThemeType_Night Property:@"borderColor" Color:nightColor];
    [self updateThemeColor];
}

- (void)my_setGrayBorder
{
    [self my_setBorderNormal:@"textGray" Night:@"textGrayNight"];
}

- (void)my_setBlueBorder
{
    [self my_setBorderNormal:@"blue" Night:@"blueNight"];
}

- (void)my_setTextNormalBorder
{
    [self my_setBorderNormal:@"textNormal" Night:@"textNormalNight"];
}

- (void)my_setWhiteTintColor
{
    [self my_setTintColorNormal:@"textWhite" Night:@"textWhiteNight"];
}

- (void)my_setBlueTintColor
{
    [self my_setTintColorNormal:@"blue" Night:@"blueNight"];
}


- (void)my_setGrayTintColor
{
    [self my_setTintColorNormal:@"textGray" Night:@"textGrayNight"];
}
@end
