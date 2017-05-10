//
//  MYDeallocObject.m
//  GKBB-iOS
//
//  Created by my on 16/7/4.
//  Copyright © 2016年 xkw. All rights reserved.
//  负责人：马毅

#import "MYDeallocObject.h"

@interface MYDeallocObject ()
@property (nonatomic,copy) DeallocBlock deallocBlock;
@end

@implementation MYDeallocObject

- (instancetype)initWithDeallocBlock:(DeallocBlock)deallocBlock
{
    if(self = [super init])
    {
        self.deallocBlock = deallocBlock;
    }
    
    return self;
}


- (void)dealloc
{
    if(self.deallocBlock)
    {
        self.deallocBlock();
        //NSLog(@"dealloc objc");
        self.deallocBlock = nil;
    }
}
@end
