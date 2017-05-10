//
//  UITextField+Theme.m
//  LYrecite
//
//  Created by scfhao on 16/12/27.
//  Copyright © 2016年 DS6GKBB. All rights reserved.
//  负责人：马毅

#import "UITextField+Theme.h"

@implementation UITextField (Theme)

- (void)my_setTextColorNormal:(NSString *)normal night:(NSString *)night
{
    [self my_setColorConfigWithTheme:ThemeType_Normal Property:@"textColor" Color:normal];
    [self my_setColorConfigWithTheme:ThemeType_Night Property:@"textColor" Color:night];
    [self updateThemeColor];
}

- (void)my_setNormalTextColor {
    [self my_setTextColorNormal:textNormal night:textNormalNight];
}

- (void)my_setWhiteTextColor {
    [self my_setTextColorNormal:textWhite night:textWhiteNight];
}

- (void)my_setGrayTextColor {
    [self my_setTextColorNormal:textGray night:textGrayNight];
}

@end
