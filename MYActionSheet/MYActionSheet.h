//
//  MYActionSheet.h
//  MYThemeTest
//
//  Created by my on 16/6/21.
//  Copyright © 2016年 mayi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MYActionSheetDelegate;


@interface MYActionSheet : UIView

@property (nonatomic,weak) id<MYActionSheetDelegate> delegate;
@property (nonatomic,copy) NSString *title; //标题
@property (nonatomic,readonly) NSInteger numberOfButtons;
@property (nonatomic) NSInteger cancelButtonIndex;
@property (nonatomic) NSInteger destructiveButtonIndex;        // sets destructive (red) button. -1 means none set. default is -1. ignored if only one button
@property (nonatomic,readonly) NSInteger firstOtherButtonIndex;	// -1 if no otherButtonTitles or initWithTitle:... not used
@property (nonatomic,readonly,getter=isVisible) BOOL visible;
@property (nonatomic, weak, readonly) UIView *targetView; 

- (instancetype)initWithTitle:(NSString *)title delegate:(id<MYActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray *)titleArray;
- (void)showInView:(UIView *)view;
- (NSInteger)addButtonWithTitle:(nullable NSString *)title;
@end



#pragma mark - 代理定义 -
@protocol MYActionSheetDelegate <NSObject>
@optional
/**
 Called before the action sheet will present. (Optional)
 */
- (void)actionSheetWillPresent:(MYActionSheet *)actionSheet;

/**
 Called after the action sheet did present. (Optional)
 */
- (void)actionSheetDidPresent:(MYActionSheet *)actionSheet;

/**
 Called before the action sheet will dismiss. (Optional)
 */
- (void)actionSheetWillDismiss:(MYActionSheet *)actionSheet;

/**
 Called after the action sheet did present. (Optional)
 */
- (void)actionSheetDidDismiss:(MYActionSheet *)actionSheet;

- (void)actionSheet:(MYActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)index;

@end
