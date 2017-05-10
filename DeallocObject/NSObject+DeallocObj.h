//
//  NSObject+DeallocObj.h
//  GKBB-iOS
//
//  Created by my on 16/7/4.
//  Copyright © 2016年 xkw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MYDeallocObject.h"
@interface NSObject (DeallocObj)
@property (nonatomic,strong) MYDeallocObject *deallocObj;
@end
