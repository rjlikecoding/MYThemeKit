//
//  UIButton+Theme.m
//  GKBB-iOS
//
//  Created by my on 16/7/4.
//  Copyright © 2016年 xkw. All rights reserved.
//  负责人：马毅

#import "UIButton+Theme.h"
#import "UIView+Theme.h"
#import <objc/runtime.h>
@interface UIButton ()
@property (nonatomic,strong) NSMutableDictionary *imageNameDic;
@property (nonatomic,strong) NSMutableDictionary *tintColorsDic;
@property (nonatomic,strong) NSMutableDictionary *titleColorDic;
@property (nonatomic,strong) NSMutableDictionary *bgImageNameDic;
@end

@implementation UIButton (Theme)

#pragma mark - set get方法 -
- (NSMutableDictionary *)imageNameDic
{
    if(!objc_getAssociatedObject(self, _cmd)){
        NSMutableDictionary *dic = [NSMutableDictionary new];
        [self setImageNameDic:dic];
    }
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setImageNameDic:(NSMutableDictionary *)imageNameDic
{
    objc_setAssociatedObject(self, @selector(imageNameDic), imageNameDic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (NSMutableDictionary *)tintColorsDic
{
    if(!objc_getAssociatedObject(self, _cmd)){
        NSMutableDictionary *dic = [NSMutableDictionary new];
        [self setTintColorsDic:dic];
    }
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setTintColorsDic:(NSMutableDictionary *)tintColorsDic
{
    
    objc_setAssociatedObject(self, @selector(tintColorsDic), tintColorsDic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (NSMutableDictionary *)titleColorDic
{
    if(!objc_getAssociatedObject(self, _cmd)){
        NSMutableDictionary *dic = [NSMutableDictionary new];
        [self setTitleColorDic:dic];
    }
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setTitleColorDic:(NSMutableDictionary *)titleColorDic
{
    objc_setAssociatedObject(self, @selector(titleColorDic), titleColorDic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary *)bgImageNameDic
{
    if(!objc_getAssociatedObject(self, _cmd)){
        NSMutableDictionary *dic = [NSMutableDictionary new];
        [self setBgImageNameDic:dic];
    }
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setBgImageNameDic:(NSMutableDictionary *)bgImageNameDic
{
    objc_setAssociatedObject(self, @selector(bgImageNameDic), bgImageNameDic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - 颜色配置 -
- (void)my_setBtnTextWhite
{
    [self my_setBtnTextNormal:@"textWhite" Night:@"textWhiteNight" forState:UIControlStateNormal];
}

- (void)my_setBtnTextNormal
{
    [self my_setBtnTextNormal:@"textNormal" Night:@"textNormalNight" forState:UIControlStateNormal];
}

- (void)my_setBtnTextBlack
{
    [self my_setBtnTextNormal:@"black" Night:@"blackNight" forState:UIControlStateNormal];
}

- (void)my_setBtnTextBlue
{
    [self my_setBtnTextNormal:@"blue" Night:@"blueNight" forState:UIControlStateNormal];
}
- (void)ya_setBtnTextBlue2
{
    [self my_setBtnTextNormal:@"lightBlue2" Night:@"lightBlue2Night" forState:UIControlStateNormal];
}
- (void)my_setBtnTextGray
{
    [self my_setBtnTextNormal:@"textGray" Night:@"textGrayNight" forState:UIControlStateNormal];
}

- (void)my_setBtnTextNormal:(NSString *)normal Night:(NSString *)night forState:(UIControlState)state
{
    UIColor *normalColor = [self.themeManager getColorWithKey:normal];
    UIColor *nightColor = [self.themeManager getColorWithKey:night];
    [self my_setTitleColors:@[normalColor,nightColor] forState:state];
    
    [self updateThemeColor];
}


- (void)my_setBtnBgBlue
{
    [self my_setBgNormal:@"blue" Night:@"blueNight"];
}

#pragma mark - 带状态的日夜间配置 -
- (void)my_setImageWithName:(NSString *)imageName forState:(UIControlState)state
{
    self.changeAuto = 1;
    [self.imageNameDic setValue:imageName forKey:@(state).stringValue];
    [self updateThemeColor];
}

- (void)my_setImageWithName:(NSString *)imageName tintColors:(NSArray *)my_tintColors forState:(UIControlState)state
{
    self.changeAuto = 1;
    [self.imageNameDic setValue:imageName forKey:@(state).stringValue];
    [self.tintColorsDic setValue:my_tintColors forKey:@(state).stringValue];
    [self updateThemeColor];
}

- (void)my_setImageWithTintColors:(NSArray *)tintColors forState:(UIControlState)state
{
    self.changeAuto = 1;
    [self.tintColorsDic setValue:tintColors forKey:@(state).stringValue];
    [self updateThemeColor];
}



- (void)my_setTitleColors:(NSArray *)colors forState:(UIControlState)state
{
    self.changeAuto = 1;
    [self.titleColorDic setValue:colors forKey:@(state).stringValue];
    [self updateThemeColor];
}

- (void)my_setBgImageWithName:(NSString *)imageName forState:(UIControlState)state
{
    self.changeAuto = 1;
    [self.bgImageNameDic setValue:imageName forKey:@(state).stringValue];
    [self updateThemeColor];
}


- (void)my_setBgImageWithName:(NSString *)imageName tintColors:(NSArray *)my_tintColors forState:(UIControlState)state
{
    self.changeAuto = 1;
    [self.bgImageNameDic setValue:imageName forKey:@(state).stringValue];
    [self.tintColorsDic setValue:my_tintColors forKey:@(state).stringValue];
    [self updateThemeColor];
}
- (void)my_setBgImageWithTintColors:(NSArray *)tintColors forState:(UIControlState)state
{
    self.changeAuto = 1;
    [self.tintColorsDic setValue:tintColors forKey:@(state).stringValue];
    [self updateThemeColor];
}
#pragma  mark - 切换逻辑 -
- (void)updateThemeColor
{
    [super updateThemeColor];
    [self.titleColorDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSArray *titleColors = (NSArray *)obj;
        NSInteger themeIndex = [[self.themeManager themeArray] indexOfObject:self.themeManager.themeType];
        UIColor *color = [titleColors objectAtIndex:themeIndex];
        
        [self setTitleColor:color forState:[key integerValue]];
    }];
    
    //本地图片处理
    [self.imageNameDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSInteger state = [key integerValue];
        NSArray *tintColors = [self.tintColorsDic objectForKey:key];
        if(tintColors){
            UIImage *image = [UIImage my_setImageWithName:obj tintColors:tintColors];
            [self setImage:[image getNewImage] forState:state];
        }else{
            UIImage *image = [UIImage my_setImageWithName:obj];
            [self setImage:[image getNewImage] forState:state];
        }
    }];
    
    [self.bgImageNameDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSInteger state = [key integerValue];
        NSArray *tintColors = [self.tintColorsDic objectForKey:key];
        if(tintColors){
            UIImage *image = [UIImage my_setImageWithName:obj tintColors:tintColors];
            [self setBackgroundImage:[image getNewImage] forState:state];
        }else{
            UIImage *image = [UIImage my_setImageWithName:obj];
            [self setBackgroundImage:[image getNewImage] forState:state];
        }
    }];
    
    //网络图片处理
    [self.tintColorsDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSInteger state = [key integerValue];
        NSArray *tintColors = (NSArray *)obj;
        NSString *imageName = [self.imageNameDic objectForKey:key];
        if(!imageName){
            UIImage *image = [self imageForState:state];
            image = [image my_setimageWithTintColors:tintColors];
            [self setImage:[image getNewImage] forState:state];
        }
        
        
        NSString *bgImageName = [self.bgImageNameDic objectForKey:key];
        if(!bgImageName){
            UIImage *image = [self backgroundImageForState:state];
            image = [image my_setimageWithTintColors:tintColors]; //这里出错了，更新的时候不应该需要这个东西
            [self setBackgroundImage:[image getNewImage] forState:state];
        }
        
    }];
    
}

@end
