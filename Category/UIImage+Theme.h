//
//  UIImage+Theme.h
//  LYrecite
//
//  Created by my on 16/11/29.
//  Copyright © 2016年 DS6GKBB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYThemeKit.h"
@interface UIImage (Theme)
@property (nonatomic,strong) NSString *my_imageName;
@property (nonatomic,strong) NSArray <UIColor *> *my_tintColors;
@property (nonatomic,assign) ThemeChangeType changeType; //图片进行日夜间切换的方式

- (UIImage *) my_imageWithTintColor:(UIColor *)tintColor;
- (UIImage *) my_imageWithGradientTintColor:(UIColor *)tintColor;

#pragma mark 日夜间切换方法
- (UIImage *)getNewImage;
+ (instancetype)my_setImageWithName:(NSString *)imageName;
+ (instancetype)my_setImageWithName:(NSString *)imageName tintColors:(NSArray *)tintColors;
+ (instancetype)my_setimageWithTintColors:(NSArray *)tintColors;

- (instancetype)my_setImageWithName:(NSString *)imageName;
- (instancetype)my_setImageWithName:(NSString *)imageName tintColors:(NSArray *)tintColors;
- (instancetype)my_setimageWithTintColors:(NSArray *)tintColors;
@end
