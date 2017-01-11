//
//  GroupModle.m
//  WeChatImage
//
//  Created by CPZX008 on 17/1/4.
//  Copyright © 2017年 xboker. All rights reserved.
//

#import "GroupModle.h"
@implementation GroupModle


- (void)getAllKindImagesAction {
    PHFetchResult *kindAlbum = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *colllection  in kindAlbum) {
        NSString *kindName = colllection.localizedTitle;
        PHFetchResult *result = [PHAsset fetchAssetsInAssetCollection:colllection options:nil];
        NSString *imageCount = [@(result.count) stringValue];
        NSDictionary *resultDic = @{@"count" : imageCount, @"title" : kindName, @"result" : result};
        [self.kindArr addObject:resultDic];
    }
}





#pragma mark    Case
- (NSMutableArray *)kindArr {
    if (!_kindArr) {
        _kindArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _kindArr;
}




@end
