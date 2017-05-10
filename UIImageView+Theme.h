//
//  UIImageView+Theme.h
//  MYThemeTest
//
//  Created by my on 16/6/17.
//  Copyright © 2016年 mayi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Theme.h"
#import "MYThemeKit.h"

@interface UIImageView (Theme)

/**
 通过更新图片的方式设置日夜间模式。不同主题的图片要注意命名按照一定规则命名，这样可以在切换时拼接出正确的图片名称。
 */

- (void)my_setImageWithName:(NSString *)imageName;

/**
 *  设置本地图片 通过tintColor切换日夜间模式
 *
 *  @param imageName 图片名称
 *  @param tintColors 存储各个主题的对应颜色
 */
- (void)my_setImageWithName:(NSString *)imageName tintColors:(NSArray *)tintColors;

/**
 网络请求图片通过tintColor切换主题
 */
- (void)my_setimageWithTintColors:(NSArray *)tintColors;

- (void)my_setImageTintMode;

/**
 tintColor渲染模式切换日夜间
 */
- (void)my_setImageTintRenderMode;
@end
