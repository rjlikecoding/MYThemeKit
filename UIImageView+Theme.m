//
//  UIImageView+Theme.m
//  MYThemeTest
//
//  Created by my on 16/6/17.
//  Copyright © 2016年 mayi. All rights reserved.
//  负责人：马毅

#import "UIImageView+Theme.h"
#import <objc/runtime.h>
#import "MYThemeKit.h"


@interface UIImageView ()

@end

@implementation UIImageView (Theme)



/**
 本地图片通过更新图片切换

 @param imageName <#imageName description#>
 */
- (void)my_setImageWithName:(NSString *)imageName
{
    self.changeAuto = 1;
    self.image = [UIImage my_setImageWithName:imageName];
    //[self.image my_setImageWithName:imageName];
    [self updateThemeColor];
}



/**
 本地图片通过tintColor切换主题

 @param imageName 图片名称
 @param tintColors 主题颜色数组
 */
- (void)my_setImageWithName:(NSString *)imageName tintColors:(NSArray *)tintColors
{
    self.changeAuto = 1;
    if(imageName){
        self.image = [UIImage my_setImageWithName:imageName tintColors:tintColors];
    }else{
        [self.image my_setImageWithName:imageName tintColors:tintColors];
    }
    
    //[self.image my_setImageWithName:imageName tintColors:tintColors];
    [self updateThemeColor];
}



/**
 网络请求图片通过tintColor切换主题

 @param tintColors
 */
- (void)my_setimageWithTintColors:(NSArray *)tintColors
{
    self.changeAuto = 1;
    [self.image my_setImageWithName:nil tintColors:tintColors];
    [self updateThemeColor];
}


- (void)updateThemeColor
{
    [super updateThemeColor];
    self.image = [self.image getNewImage];
}


- (void)my_setImageTintMode
{
    self.showNightView = 1;
    [self updateThemeColor];
}

- (void)my_setImageTintRenderModeWithName:(NSString *)imageName
{
    NSArray *tintColor = @[[NSNull null],RGBA(0.3, 0.3, 0.3, 0.4)];
    [self my_setImageWithName:imageName tintColors:tintColor];
    
}

- (void)my_setImageTintRenderMode
{
    [self my_setImageTintRenderModeWithName:nil];
}

@end
