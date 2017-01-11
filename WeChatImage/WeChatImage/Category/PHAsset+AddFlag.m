//
//  PHAsset+AddFlag.m
//  WeChatImage
//
//  Created by CPZX008 on 17/1/4.
//  Copyright © 2017年 xboker. All rights reserved.
//

#import "PHAsset+AddFlag.h"
#import <objc/runtime.h>

static const char *CHOOSEFLAG = "CHOOSEFLAG";

@implementation PHAsset (AddFlag)

- (void)setChooseFlag:(BOOL)chooseFlag {
    objc_setAssociatedObject(self, CHOOSEFLAG, @(chooseFlag), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)chooseFlag {
    return [objc_getAssociatedObject(self, CHOOSEFLAG) integerValue];
}




@end
