//
//  MYActionSheet.m
//  MYThemeTest
//
//  Created by my on 16/6/21.
//  Copyright © 2016年 mayi. All rights reserved.
//  负责人：马毅

#import "MYActionSheet.h"
#import "UIView+Theme.h"

const CGFloat KMYAnimationDuration = 0.3;

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
@interface MYActionSheet ()
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) NSMutableArray *otherBtnArray; //其他按钮的数组
@property (nonatomic,strong) UIButton *destructiveBtn; //红色的按钮 默认为nil
@property (nonatomic,strong) UIButton *cancelBtn; //取消按钮
@property (nonatomic,strong) UIView *contentView; //容器视图，存储所有的控件，执行动画效果
@property (nonatomic,strong) UIView *bgView; //背景视图，用来遮挡后面的内容，实现点击效果
@property (nonatomic,strong) NSMutableArray *allBtnArray;
@property (nonatomic, weak) UIView *targetView;
@property (nonatomic,assign,getter=isVisible) BOOL visible;

//@property (nonatomic,strong) UIColor *contentBgColor;
//@property (nonatomic,strong) UIColor *titleColor;
//@property (nonatomic,strong) UIColor *btnBgColor;
//@property (nonatomic,strong) UIColor *btnTitleColor;

@property (nonatomic,assign) CGFloat width; //actionsheet的宽度
@property (nonatomic,assign) CGFloat height; //actionsheet高度
@property (nonatomic,assign) CGFloat btnHeight; //按钮的高度
@property (nonatomic,assign) CGFloat titleHeight; //标题的高度
@property (nonatomic,assign) CGFloat cancelBtnTopSpace; //取消按钮与上方的间距
@property (nonatomic,strong) UIFont *btnFont; //按钮文字大小
//颜色设定
@property (nonatomic,strong) UIColor *separatorColor; //分割线颜色
//@property (nonatomic,strong)
@end


@implementation MYActionSheet

- (instancetype)initWithTitle:(NSString *)title delegate:(id<MYActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray *)titleArray
{
    if(self = [super init])
    {
        [self my_setClearBg];
        self.btnFont = [UIFont systemFontOfSize:16];
        self.titleHeight = 40;
        self.btnHeight = 40;
        self.width = SCREEN_WIDTH;
        self.cancelBtnTopSpace = 5;
        self.changeAuto = YES;
        self.allBtnArray = [NSMutableArray array];
        self.visible = NO;
        self.delegate = delegate;
        self.bgView = [[UIView alloc] init];
        self.bgView.backgroundColor = [UIColor blackColor];
        self.bgView.alpha = 0.2;
        self.bgView.hidden = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
        [self.bgView addGestureRecognizer:tap];
        [self addSubview:self.bgView];
        
        //self.contentBgColor = [UIColor lightGrayColor];
        //self.titleColor = [UIColor darkGrayColor];
        //self.btnTitleColor = [UIColor blackColor];
        //self.btnBgColor = [UIColor whiteColor];
        
        self.contentView = [[UIView alloc] init];
        [self.contentView my_setGrayBg];
        [self addSubview:self.contentView];
        
        if(title)
        {
            self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
            self.titleLabel.text = title;
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            self.titleLabel.font = [UIFont systemFontOfSize:14];
            //self.titleLabel.backgroundColor = self.btnBgColor;
            [self.titleLabel my_setWhiteBg];
            [self.titleLabel my_setNormalText];
            //self.titleLabel.textColor = [UIColor darkGrayColor];
            [self.contentView addSubview:self.titleLabel];
        }
        
        if(destructiveButtonTitle)
        {
            self.destructiveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [self.destructiveBtn setTitle:destructiveButtonTitle forState:UIControlStateNormal];
            [self.destructiveBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            //self.destructiveBtn.backgroundColor = self.btnBgColor;
            [self.destructiveBtn my_setWhiteBg];
            [self.contentView addSubview:self.destructiveBtn];
            [self.allBtnArray addObject:self.destructiveBtn];
            
            [self.destructiveBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        if(titleArray.count > 0)
        {
            self.otherBtnArray = [NSMutableArray array];
            for(int i=0; i<titleArray.count; i++)
            {
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                [btn setTitle:titleArray[i] forState:UIControlStateNormal];
                btn.titleLabel.textAlignment = NSTextAlignmentCenter;
                btn.titleLabel.font = self.btnFont;
                //[btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [btn my_setBtnTextBlack];
                //btn.backgroundColor = self.btnBgColor;
                [btn my_setWhiteBg];
                [self.otherBtnArray addObject:btn];
                [self.contentView addSubview:btn];
                [self.allBtnArray addObject:btn];
                [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
            }
        }
        
        if(cancelButtonTitle)
        {
            self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.cancelBtn.titleLabel.font = self.btnFont;
            self.cancelBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
            //[self.cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self.cancelBtn my_setBtnTextBlack];
            [self.cancelBtn setTitle:cancelButtonTitle forState:UIControlStateNormal];
            [self.contentView addSubview:self.cancelBtn];
            //self.cancelBtn.backgroundColor = [UIColor whiteColor];
            [self.cancelBtn my_setWhiteBg];
            [self.allBtnArray addObject:self.cancelBtn];
            [self.cancelBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        //[self updateViewColor];
    }

    return self;
}

- (NSInteger)addButtonWithTitle:(nullable NSString *)title
{
    if(!self.otherBtnArray){
        self.otherBtnArray = [NSMutableArray array];
    }
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    btn.titleLabel.font = self.btnFont;
    //[btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn my_setBtnTextBlack];
    //btn.backgroundColor = self.btnBgColor;
    [btn my_setWhiteBg];
    [self.otherBtnArray addObject:btn];
    [self.contentView addSubview:btn];
    [self.allBtnArray addObject:btn];
    [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self calculateFrame];
    
    return self.otherBtnArray.count-1;
}



//frame计算
- (void)calculateFrame
{
    CGFloat y = 0;
    CGFloat space = 1; //按钮之间的间距
    CGFloat tag = 0;
    self.width = self.targetView.frame.size.width;
    self.frame = self.targetView.bounds;
    self.bgView.frame = self.bounds;
    
    if(self.titleLabel)
    {
        self.titleLabel.frame = CGRectMake(0, y, self.width, self.titleHeight);
        y = self.titleHeight + space;
    }
    
    if(self.destructiveBtn)
    {
        self.destructiveBtn.frame = CGRectMake(0, y, self.width, self.btnHeight);
        y = CGRectGetMaxY(self.destructiveBtn.frame) + space;
        self.destructiveBtn.tag = tag;
        tag += 1;
    }
    
    if(self.otherBtnArray.count > 0)
    {
        for(int i=0; i<self.otherBtnArray.count; i++)
        {
            UIButton *btn = self.otherBtnArray[i];
            btn.frame = CGRectMake(0, y, self.width, self.btnHeight);
            y = CGRectGetMaxY(btn.frame) + space;
            btn.tag = tag;
            tag += 1;
        }
    }
    
    if(self.cancelBtn)
    {
        self.cancelBtn.frame = CGRectMake(0, y + self.cancelBtnTopSpace, self.width, self.btnHeight);
        self.cancelBtn.tag = tag;
    }
    self.height = y + self.btnHeight + self.cancelBtnTopSpace;
    self.contentView.frame = CGRectMake(0, self.bounds.size.height, self.width, self.height);
}

- (void)showInView:(UIView *)view
{
    _targetView = view;
    [self calculateFrame];
    
    if([self.delegate respondsToSelector:@selector(actionSheetWillPresent:)])
    {
        [self.delegate actionSheetWillPresent:self];
    }
    
    [view addSubview:self];
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [UIView animateWithDuration:KMYAnimationDuration animations:^{
        self.contentView.frame = CGRectMake(0, self.bounds.size.height - self.contentView.frame.size.height, self.width, self.height);
        self.bgView.hidden = NO;
    } completion:^(BOOL finished) {
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        self.visible = YES;
        if([self.delegate respondsToSelector:@selector(actionSheetDidPresent:)])
        {
            [self.delegate actionSheetDidPresent:self];
        }
    }];
}

//隐藏视图
- (void)hide
{
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    
    if([self.delegate respondsToSelector:@selector(actionSheetWillDismiss:)])
    {
        [self.delegate actionSheetWillDismiss:self];
    }
    
    [UIView animateWithDuration:KMYAnimationDuration animations:^{
        self.contentView.frame = CGRectMake(0, self.bounds.size.height, self.width, self.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        self.bgView.hidden = YES;
        self.targetView = nil;
        self.visible = NO;
        
        if([self.delegate respondsToSelector:@selector(actionSheetDidDismiss:)])
        {
            [self.delegate actionSheetDidDismiss:self];
        }
        
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    }];
}


- (NSInteger)numberOfButtons
{
    return self.allBtnArray.count;
}

- (NSInteger)firstOtherButtonIndex
{
    if(self.otherBtnArray.count == 0)
    {
        return -1;
    }
    else
    {
        UIButton *btn = self.otherBtnArray[0];
        return btn.tag;
    }
}

- (UIView *)targetView
{
    return _targetView;
}

- (NSInteger)cancelButtonIndex
{
    
    return self.cancelBtn ? self.cancelBtn.tag : -1;
}

- (NSInteger)destructiveButtonIndex
{
    return self.destructiveBtn ? self.destructiveBtn.tag : -1;
}


- (void)clickBtn:(UIButton *)btn
{
    if([self.delegate respondsToSelector:@selector(actionSheet:clickedButtonAtIndex:)])
    {
        [self.delegate actionSheet:self clickedButtonAtIndex:btn.tag];
    }
    
    [self hide];
}



@end
