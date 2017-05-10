//
//  UITextField+Theme.m
//  LYrecite
//
//  Created by YuAng on 2016/12/19.
//  Copyright © 2016年 DS6GKBB. All rights reserved.
//  负责人：马毅

#import "UITextView+Theme.h"

@implementation UITextView (Theme)
- (void)my_setGrayText
{
    [self my_setTextColorNormal:@"textGray" night:@"textGrayNight"];
}

- (void)my_setNormalText
{
    [self my_setTextColorNormal:@"textNormal" night:@"textNormalNight"];
}

- (void)my_setTextWhite
{
    [self my_setTextColorNormal:@"textWhite" night:@"textWhiteNight"];
}

- (void)my_setTextBlue
{
    [self my_setTextColorNormal:@"blue" night:@"blueNight"];
}

- (void)my_setTextLightBlue2
{
    [self my_setTextColorNormal:@"lightBlue2" night:@"lightBlue2Night"];
}

- (void)my_setTextColorNormal:(NSString *)normal night:(NSString *)night
{
    [self my_setColorConfigWithTheme:ThemeType_Normal Property:@"textColor" Color:normal];
    [self my_setColorConfigWithTheme:ThemeType_Night Property:@"textColor" Color:night];
    [self updateThemeColor];
}
@end
