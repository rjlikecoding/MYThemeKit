//
//  UIImage+Theme.m
//  LYrecite
//
//  Created by my on 16/11/29.
//  Copyright © 2016年 DS6GKBB. All rights reserved.
//  负责人：马毅

#import "UIImage+Theme.h"
#import <objc/runtime.h>

@interface UIImage ()
@property (nonatomic,strong) UIImage *my_rawImage; //存储原始图片 如果用tintColor进行了图片的修改 通过rawImage可以获得原始图片
@end


@implementation UIImage (Theme)

- (UIImage *) my_imageWithTintColor:(UIColor *)tintColor
{
    return [self my_imageWithTintColor:tintColor blendMode:kCGBlendModeDestinationIn];
}

- (UIImage *) my_imageWithGradientTintColor:(UIColor *)tintColor
{
    return [self my_imageWithTintColor:tintColor blendMode:kCGBlendModeOverlay];
}

- (UIImage *) my_imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode
{
    //We want to keep alpha, set opaque to NO; Use 0.0f for scale to use the scale factor of the device’s main screen.
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [tintColor setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    //Draw the tinted image in context
    [self drawInRect:bounds blendMode:blendMode alpha:1.0f];
    
    
    if (blendMode != kCGBlendModeDestinationIn) {
        [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    }
    
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}

#pragma mark - 属性设置 -

- (UIImage *)my_rawImage
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setMy_rawImage:(UIImage *)my_rawImage
{
    objc_setAssociatedObject(self, @selector(my_rawImage), my_rawImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)my_imageName
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setMy_imageName:(NSString *)my_imageName
{
    objc_setAssociatedObject(self, @selector(my_imageName), my_imageName, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (NSArray *)my_tintColors
{
    return objc_getAssociatedObject(self,_cmd);
}

- (void)setMy_tintColors:(NSArray<UIColor *> *)my_tintColors
{
    objc_setAssociatedObject(self, @selector(my_tintColors), my_tintColors, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (ThemeChangeType)changeType
{
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

- (void)setChangeType:(ThemeChangeType)type
{
    objc_setAssociatedObject(self, @selector(changeType), @(type), OBJC_ASSOCIATION_ASSIGN);
}

#pragma mark - 日夜间设置方法 -
+ (instancetype)my_setImageWithName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    image.my_imageName = imageName;
    image.changeType = ThemeChangeTypeImage;
    return image;
}


+ (instancetype)my_setImageWithName:(NSString *)imageName tintColors:(NSArray *)tintColors
{
    UIImage *image = [UIImage imageNamed:imageName];
    image.my_imageName = imageName;
    image.changeType = ThemeChangeTypeTintColor;
    image.my_tintColors = tintColors;
    return image;
}

+ (instancetype)my_setimageWithTintColors:(NSArray *)tintColors
{
    return [self my_setImageWithName:nil tintColors:tintColors];
}


- (instancetype)my_setImageWithName:(NSString *)imageName
{
    
    self.my_imageName = imageName;
    self.changeType = ThemeChangeTypeImage;
    return self;
}


- (instancetype)my_setImageWithName:(NSString *)imageName tintColors:(NSArray *)tintColors
{
    
    self.my_imageName = imageName;
    self.changeType = ThemeChangeTypeTintColor;
    self.my_tintColors = tintColors;
    //self.my_rawImage = [self copy];
    if(!self.my_rawImage){
        self.my_rawImage = [self copy];
    }
    return self;
}

- (instancetype)my_setimageWithTintColors:(NSArray *)tintColors
{
    return [self my_setImageWithName:nil tintColors:tintColors];
}





/**
 日夜间切换时，创建新的图片返回
 */
- (UIImage *)getNewImage
{
    UIImage *image = self.my_imageName ? [UIImage imageNamed:self.my_imageName]: self.my_rawImage;
    if(self.changeType == ThemeChangeTypeImage){
        NSString *imageName = [self getImageFullName:self.my_imageName];
        image = [UIImage imageNamed:imageName];
    }else if(self.changeType == ThemeChangeTypeTintColor){
        if(![self.themeManager.themeType isEqualToString:ThemeType_Normal]){
            NSInteger themeIndex = [self.themeManager.themeArray indexOfObject:self.themeManager.themeType];
            UIColor *color = [self.my_tintColors objectAtIndex:themeIndex];
            image = [image my_imageWithGradientTintColor:color];
        }
    }
    
    if(image){
        image.changeAuto = 1;
        image.changeType = self.changeType;
        image.my_imageName = self.my_imageName;
        image.my_tintColors = self.my_tintColors;
        image.my_rawImage = [self.my_rawImage copy];
        return image;
    }else{
        return self;
    }
}


//根据传进来的图片名称以及当前主题，获得完整的图片名称  图片命名规则是：imageName_themeName.XXX
- (NSString *)getImageFullName:(NSString *)imageName
{
    NSString *fullName = nil;
    NSString *str = self.themeManager.themeType;
    
    NSArray *strArray = [imageName componentsSeparatedByString:@"."];
    if(strArray.count > 2)
    {
        NSLog(@"文件名出错");
    }
    else
    {
        fullName = strArray[0];
        if(![str isEqualToString:ThemeType_Normal])
        {
            fullName = [NSString stringWithFormat:@"%@_%@",strArray[0],str];
        }
        
        if(strArray.count == 2)
        {
            fullName = [NSString stringWithFormat:@"%@.%@",fullName,strArray[1]];
        }
    }
    
    return fullName;
}


@end
