//
//  MYDeallocObject.h
//  GKBB-iOS
//
//  Created by my on 16/7/4.
//  Copyright © 2016年 xkw. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^DeallocBlock)(void);

@interface MYDeallocObject : NSObject
- (instancetype)initWithDeallocBlock:(DeallocBlock)deallocBlock;
@end
