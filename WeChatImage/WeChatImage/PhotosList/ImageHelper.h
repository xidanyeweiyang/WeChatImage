//
//  ImageHelper.h
//  WeChatImage
//
//  Created by CPZX008 on 17/1/4.
//  Copyright © 2017年 xboker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageHelper : NSObject

+ (ImageHelper *)shareImageHelper;

#pragma mark    所有相片集合, 里面是一个个的PHAsset
@property (nonatomic, strong) NSMutableArray *phassetArr;
#pragma mark    所有被选择的PHAsset
@property (nonatomic, strong) NSMutableArray *phassetChoosedArr;

#pragma mark    实际获取相册所有照片的操作
- (void)getAllImageActionWithCollection:(PHFetchResult *)result;


@end
