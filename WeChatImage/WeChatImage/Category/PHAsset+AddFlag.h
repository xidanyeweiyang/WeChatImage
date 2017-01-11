//
//  PHAsset+AddFlag.h
//  WeChatImage
//
//  Created by CPZX008 on 17/1/4.
//  Copyright © 2017年 xboker. All rights reserved.
//

#import <Photos/Photos.h>

#pragma mark    为PHAsset绑定一个属性, 当被选择时.chooseFlag设为YES;
@interface PHAsset (AddFlag)

@property (nonatomic, assign) BOOL chooseFlag;


@end
