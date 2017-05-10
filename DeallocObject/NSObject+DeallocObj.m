//
//  NSObject+DeallocObj.m
//  GKBB-iOS
//
//  Created by my on 16/7/4.
//  Copyright © 2016年 xkw. All rights reserved.
//  负责人：马毅

#import "NSObject+DeallocObj.h"
#import <objc/runtime.h>
@implementation NSObject (DeallocObj)

- (void)setDeallocObj:(MYDeallocObject *)deallocObj
{
    objc_setAssociatedObject(self, @selector(deallocObj), deallocObj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (MYDeallocObject *)deallocObj
{
    return objc_getAssociatedObject(self, _cmd);
}

@end
