//
//  FullImageHeaderView.m
//  WeChatImage
//
//  Created by CPZX008 on 17/1/5.
//  Copyright © 2017年 xboker. All rights reserved.
//

#import "FullImageHeaderView.h"

typedef NS_ENUM(NSInteger, PreviewImageType) {
    PreviewImageTypeSome,
    PreviewImageTypeAll
};

@interface FullImageHeaderView()
@property (nonatomic, weak) IBOutlet UIButton *chooseButton;
@property (nonatomic, strong) PHAsset *tempAsset;
@property (nonatomic, assign) PreviewImageType previewType;

@end

@implementation FullImageHeaderView



- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor colorWithWhite:0.4 alpha:0.4];
}



- (void)displayHeaderWihtDataSource:(NSMutableArray *)dataSource withIndexPath:(NSIndexPath *)indexPath {
    PHAsset *asset = dataSource[indexPath.row];
    if ([dataSource isEqual:[ImageHelper shareImageHelper].phassetArr]) {
        self.previewType = PreviewImageTypeAll;
    }else {
        self.previewType = PreviewImageTypeSome;
    }
    self.tempAsset = (PHAsset *)asset;
    self.chooseButton.selected  = asset.chooseFlag;
    if (asset.chooseFlag ) {
        [self.chooseButton setImage:[UIImage imageNamed:@"choose"] forState:UIControlStateSelected];
    }else {
        [self.chooseButton setImage:[UIImage imageNamed:@"unChoose"] forState:UIControlStateNormal];
    }
    [self.chooseButton setNeedsLayout];
}





#pragma mark    interFaceBuilder    Method
- (IBAction)dismiss:(id)sender {
    [self.delegate fullImageHeaderViewTapDismissAction];
}

- (IBAction)changeStatus:(id)sender {
    self.chooseButton.selected = !self.chooseButton.selected;
    if (self.chooseButton.selected) {
        [self.chooseButton setImage:[UIImage imageNamed:@"choose"] forState:UIControlStateSelected];
        self.tempAsset.chooseFlag = YES;
        [self animationAction];
        if (self.previewType == PreviewImageTypeAll) {
            [[ImageHelper shareImageHelper].phassetChoosedArr addObject:self.tempAsset];
        }
    }else {
        [self.chooseButton setImage:[UIImage imageNamed:@"unChoose"] forState:UIControlStateNormal];
        self.tempAsset.chooseFlag = NO;
        if (self.previewType == PreviewImageTypeAll) {
            [[ImageHelper shareImageHelper].phassetChoosedArr removeObject:self.tempAsset];
        }
    }
    
    [self.delegate fullImageHeaderViewTapChangeChooseStatusAction];
}





#pragma mark    按钮动画
- (void)animationAction {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.repeatCount = 1;
    animation.removedOnCompletion = YES;
    animation.duration = 0.4;
    animation.fillMode = kCAFillModeForwards;
    animation.values = @[@(1.05), @(1.1), @(1.15),@(1.1), @(1.05), @(1), @(1.05), @(1.1), @(1.15),@(1.1), @(1.05),@(1)];
    [self.chooseButton.imageView.layer addAnimation:animation forKey:@"animation"];
    
}


- (void)dealloc {
    NSMutableArray *tempArr = [[ImageHelper shareImageHelper].phassetChoosedArr mutableCopy];
    for (PHAsset *asset in tempArr) {
        if (asset.chooseFlag == NO) {
            [[ImageHelper shareImageHelper].phassetChoosedArr removeObject:asset];
        }
    }
    [self.chooseButton.layer removeAnimationForKey:@"animation"];
    [self.chooseButton.layer removeAllAnimations];
    NSLog(@"[%@-----------dealloc]", self.class);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
