//
//  ImageHelper.m
//  WeChatImage
//
//  Created by CPZX008 on 17/1/4.
//  Copyright © 2017年 xboker. All rights reserved.
//

#import "ImageHelper.h"

@implementation ImageHelper


+ (ImageHelper *)shareImageHelper {
    static ImageHelper *helper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (helper == nil) {
            helper = [[ImageHelper alloc] init];
        }
    });
    return helper;
}



#pragma mark    Method
#pragma mark    实际获取相册所有照片的操作
- (void)getAllImageActionWithCollection:(PHFetchResult *)result {
    if (result) {
        for (id obj in result) {//获取标识符
        [self.phassetArr addObject:obj];
        }
    }else {
        // 获取所有资源的集合，并按资源的创建时间排序
        ///获取资源时的参数
        PHFetchOptions *options = [[PHFetchOptions alloc] init];
        options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
        //表示一系列的资源的集合,也可以是相册的集合
        PHFetchResult *assetsFetchResults = [PHAsset fetchAssetsWithOptions:options];
        for (id obj in assetsFetchResults) {//获取标识符
            [self.phassetArr addObject:obj];

#pragma mark    不采用标志符方式.读取太慢会导致拖动卡顿
//            PHAsset *asset = obj;
//            if ([asset.localIdentifier isKindOfClass:[NSString class]]) {
//                [self.phassetArr addObject:asset.localIdentifier];
//            }
        }
    }
}







#pragma mark    Case
- (NSMutableArray *)phassetArr {
    if (!_phassetArr) {
        _phassetArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _phassetArr;
}


- (NSMutableArray *)phassetChoosedArr  {
    if (!_phassetChoosedArr) {
        _phassetChoosedArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _phassetChoosedArr;
}



@end
