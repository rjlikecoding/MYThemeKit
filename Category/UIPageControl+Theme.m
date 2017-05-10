//
//  UIPageControl+Theme.m
//  LYrecite
//
//  Created by scfhao on 17/2/28.
//  Copyright © 2017年 DS6GKBB. All rights reserved.
//

#import "UIPageControl+Theme.h"

@implementation UIPageControl (Theme)

- (void)my_setupDefaultTheme {
    [self my_setColorConfigWithTheme:ThemeType_Normal Property:@"currentPageIndicatorTintColor" Color:@"bgWhite"];
    [self my_setColorConfigWithTheme:ThemeType_Night Property:@"currentPageIndicatorTintColor" Color:@"bgWhiteNight"];
    [self updateThemeColor];
}

@end
