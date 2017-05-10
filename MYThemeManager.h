//
//  MYThemeManager.h
//  MYThemeTest
//
//  Created by my on 16/5/26.
//  Copyright © 2016年 mayi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/*
typedef NS_ENUM(NSInteger,ThemeType){
    ThemeNormal,
    ThemeNight
};*/



@interface MYThemeManager : NSObject
@property (nonatomic,strong) NSString *themeType;
@property (nonatomic,strong,readonly) NSDictionary *colorConfigDic;
//@property (nonatomic,strong,readonly) NSDictionary *uiConfigDic;
@property (nonatomic,strong,readonly) NSArray *themeArray; //主题名称的数组
+(instancetype)sharedManager;
- (UIColor *)getColorWithKey:(NSString *)colorKey;
- (UIColor *)getCurrentColorWithKey:(NSString *)colorKey;
- (NSArray *)getColorArrayWithKey:(NSString *)colorKey;
- (void)switchTheme;
+ (BOOL)isNightModel;

- (NSArray *)getNightTintColorArray;
@end
