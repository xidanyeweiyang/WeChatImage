//
//  ChoosedCollectionViewCell.m
//  WeChatImage
//
//  Created by CPZX008 on 17/1/5.
//  Copyright © 2017年 xboker. All rights reserved.
//

#import "ChoosedCollectionViewCell.h"

@interface ChoosedCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *chooseImage;


@end


@implementation ChoosedCollectionViewCell
- (void)displayCellWithDataSource:(NSMutableArray *)dataSource withIndexPath:(NSIndexPath *)indexPath  {
    if (dataSource.count > indexPath.row) {
        PHAsset *assetString = dataSource[indexPath.row];
        [self displayCellWithAssetString:assetString ];
    }
}


- (void)displayCellWithAssetString:(PHAsset *)asset  {
    __weak ChoosedCollectionViewCell *weakSelf = self;

    CGSize imageSize = CGSizeMake(CELL_COLLECTION_WIDTH - 6, CELL_COLLECTION_WIDTH - 6);
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.synchronous = YES;
    options.resizeMode = PHImageRequestOptionsResizeModeFast;
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:imageSize contentMode:PHImageContentModeAspectFill options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        weakSelf.chooseImage.image = result;
    }];
}

@end
