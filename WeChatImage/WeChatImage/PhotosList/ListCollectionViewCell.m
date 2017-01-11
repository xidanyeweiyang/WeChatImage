//
//  ListCollectionViewCell.m
//  WeChatImage
//
//  Created by CPZX008 on 17/1/4.
//  Copyright © 2017年 xboker. All rights reserved.
//

#import "ListCollectionViewCell.h"

@interface ListCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *photoImage;
@property (weak, nonatomic) IBOutlet UIButton *chooseState;

@property (nonatomic, strong) PHAsset *tempAsset;


@end

@implementation ListCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self bringSubviewToFront:self.chooseState];
}

- (void)displayCellWithDataSource:(NSMutableArray *)dataSource withIndexPath:(NSIndexPath *)indexPath isCancleAction:(BOOL)cancleAction {
    if (dataSource.count > indexPath.row) {
        PHAsset *assetString = dataSource[indexPath.row];
        [self displayCellWithAssetString:assetString isCancleAction:cancleAction];
    }
}


- (void)displayCellWithAssetString:(PHAsset *)asset  isCancleAction:(BOOL)cancleAction{
    __weak ListCollectionViewCell *weakSelf = self;
    self.tempAsset = (PHAsset *)asset;
    if (!cancleAction) {
        if (asset.chooseFlag ) {
            self.chooseState.selected = YES;
            [self.chooseState setImage:[UIImage imageNamed:@"choose"] forState:UIControlStateSelected];
        }else {
            self.chooseState.selected = NO;
            [self.chooseState setImage:[UIImage imageNamed:@"unChoose"] forState:UIControlStateNormal];
        }
    }else {
        asset.chooseFlag = NO;
        self.chooseState.selected = NO;
        [self.chooseState setImage:[UIImage imageNamed:@"unChoose"] forState:UIControlStateNormal];
    }

    CGSize imageSize = CGSizeMake(CELL_COLLECTION_WIDTH - 6, CELL_COLLECTION_WIDTH - 6);
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.synchronous = YES;
    options.resizeMode = PHImageRequestOptionsResizeModeFast;
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:imageSize contentMode:PHImageContentModeAspectFill options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        weakSelf.photoImage.image = result;
    }];
    
    
#pragma mark    不采用标志符方式.读取太慢会导致拖动卡顿
    //    PHFetchResult *result = [self getPHFetchResultFromAssetString:asset];
    //    [result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    //        PHAsset *asset = (PHAsset *)obj;
    //        NSLog(@"%@________________", asset.chooseFlag);
    //        weakSelf.tempAsset = asset;
    //        if ([asset.chooseFlag isEqualToString:@"1"]) {
    //            weakSelf.chooseState.selected = YES;
    //            [weakSelf.chooseState setImage:[UIImage imageNamed:@"choose"] forState:UIControlStateSelected];
    //        }else {
    //            weakSelf.chooseState.selected = NO;
    //            [self.chooseState setImage:[UIImage imageNamed:@"unChoose"] forState:UIControlStateNormal];
    //        }
    //        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:imageSize contentMode:PHImageContentModeAspectFill options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
    //            weakSelf.photoImage.image = result;
    ////            NSLog(@"%@_+_+_+_+_+_+_", info);
    //        }];
    //    }];
}


//#pragma mark    根据标志符取出PHFetchResult
//- (PHFetchResult *)getPHFetchResultFromAssetString:(NSString *)assetString {
//    return [PHAsset fetchAssetsWithLocalIdentifiers:@[assetString] options:nil];
//}




#pragma mark    interFaceBuilder Method
- (IBAction)tapAction:(UIButton *)sender {
    self.chooseState.selected = !self.chooseState.selected;
    if (self.chooseState.selected) {
        [self.chooseState setImage:[UIImage imageNamed:@"choose"] forState:UIControlStateSelected];
        self.tempAsset.chooseFlag = YES;
        [[ImageHelper shareImageHelper].phassetChoosedArr addObject:self.tempAsset];
        [self animationAction];
    }else {
        [self.chooseState setImage:[UIImage imageNamed:@"unChoose"] forState:UIControlStateNormal];
        self.tempAsset.chooseFlag = NO;
        [[ImageHelper shareImageHelper].phassetChoosedArr removeObject:self.tempAsset];
    }
//    NSLog(@"%ld____________", [ImageHelper shareImageHelper].phassetChoosedArr.count);
//    NSLog(@"%@____________", [ImageHelper shareImageHelper].phassetChoosedArr);
  
    
    [self.delegate imageHelperGetImageCount:[ImageHelper shareImageHelper].phassetChoosedArr.count];
    [self.chooseState setNeedsLayout];
    
    
}

#pragma mark    按钮动画
- (void)animationAction {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.repeatCount = 1;
    animation.removedOnCompletion = YES;
    animation.duration = 0.4;
    animation.fillMode = kCAFillModeForwards;
    animation.values = @[@(1.05), @(1.1), @(1.15),@(1.1), @(1.05), @(1), @(1.05), @(1.1), @(1.15),@(1.1), @(1.05),@(1)];
    [self.chooseState.imageView.layer addAnimation:animation forKey:@"animation"];
    
}

- (void)dealloc {
    [self.chooseState.imageView.layer removeAnimationForKey:@"animation"];
    [self.chooseState.imageView.layer removeAllAnimations];
    NSLog(@"[%@---------------dealloc]", self.class);
}


@end
