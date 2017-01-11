//
//  PhotoFullViewController.m
//  WeChatImage
//  photo列表中, 点击某一张图片展示整张大图
//  Created by CPZX008 on 17/1/4.
//  Copyright © 2017年 xboker. All rights reserved.
//

#import "PhotoFullViewController.h"
#import "FullImageCollectionViewCell.h"
#import "FullImageFooterView.h"
#import "FullImageHeaderView.h"
#import "ViewController.h"

@interface PhotoFullViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, FullImageHeaderViewDelegate, UIScrollViewDelegate, FullImageFooterViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet FullImageHeaderView *topView;

@property (weak, nonatomic) IBOutlet FullImageFooterView *footerView;

@property (nonatomic, assign) NSInteger scrollFlag;

@property (nonatomic, assign) BOOL isOriginal;

@end

@implementation PhotoFullViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isOriginal = NO;
    self.scrollFlag = 1;
    [self.footerView displayFooterWithCount:[ImageHelper shareImageHelper].phassetChoosedArr.count];
    if (self.previewType == FullImageTypeAllPreview) {
    [self.topView displayHeaderWihtDataSource:[ImageHelper shareImageHelper].phassetArr withIndexPath:[NSIndexPath indexPathForItem:self.previewIndex inSection:0]];

    }else {
    [self.topView displayHeaderWihtDataSource:[ImageHelper shareImageHelper].phassetChoosedArr withIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];

    }
    // Do any additional setup after loading the view.
}



#pragma mark    纯代码创建此界面无需这么麻烦:直接调用scrollToItemAtIndexPath方法即可实现效果;
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    if (self.previewType == FullImageTypeAllPreview && self.scrollFlag == 1) {
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.previewIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        self.scrollFlag = 999;
    }


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}

#pragma mark    
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}


#pragma mark    UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat offset = scrollView.contentOffset.x / SCREEN_WIDTH;
    NSIndexPath *path = [NSIndexPath indexPathForItem:round(offset) inSection:0];

    if (self.previewType == FullImageTypeAllPreview) {
        [self.topView displayHeaderWihtDataSource:[ImageHelper shareImageHelper].phassetArr withIndexPath:path];
    }else {
        [self.topView displayHeaderWihtDataSource:[ImageHelper shareImageHelper].phassetChoosedArr withIndexPath:path];
    }
}


#pragma mark    UICollectionViewDelegate, UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.previewType == FullImageTypeAllPreview) {
        return [ImageHelper shareImageHelper].phassetArr.count;
    }else {
        return [ImageHelper shareImageHelper].phassetChoosedArr.count;
    }
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FullImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FullImageCollectionViewCell" forIndexPath:indexPath];
    if (self.previewType == FullImageTypeAllPreview) {
        [cell displayCellWithDataSource:[ImageHelper shareImageHelper].phassetArr inedexPath:indexPath isOriginalImage:self.isOriginal];
    }else {
        [cell displayCellWithDataSource:[ImageHelper shareImageHelper].phassetChoosedArr inedexPath:indexPath isOriginalImage:self.isOriginal];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {

}


#pragma mark    UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(SCREEN_WIDTH , SCREEN_HEIGHT);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.1;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.1;
}


#pragma mark    interFaceBuilder    Method
- (IBAction)tapAction:(id)sender {
    __weak PhotoFullViewController *weakSelf = self;
    [UIView animateWithDuration:0.6 animations:^{
    weakSelf.topView.alpha = weakSelf.footerView.alpha = weakSelf.footerView.hidden;
        weakSelf.topView.hidden = !weakSelf.topView.hidden;
        weakSelf.footerView.hidden = !weakSelf.footerView.hidden;
    }];
}

- (void)checkOriginalImageAction {
    self.isOriginal = YES;
    
    FullImageCollectionViewCell *cell = [self.collectionView visibleCells].firstObject;
    NSIndexPath *path = [self.collectionView indexPathForCell:cell];
    
    [self.collectionView reloadItemsAtIndexPaths:@[path]];
    self.isOriginal = NO;
}



#pragma mark    FullImageHeaderViewDelegate

- (void)fullImageHeaderViewTapDismissAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)fullImageHeaderViewTapChangeChooseStatusAction {
    [self.footerView displayFooterWithCount:[ImageHelper shareImageHelper].phassetChoosedArr.count];
}




#pragma mark    FullImageFooterViewDelegate
- (void)chooseImageSendAction {
    UIViewController *VC = self;
    while (VC.presentingViewController) {
        VC = VC.presentingViewController;
    }
    [VC dismissViewControllerAnimated:YES completion:nil];
    [[ImageHelper shareImageHelper].phassetArr removeAllObjects];
}


#pragma mark    Case
- (void)setTopView:(FullImageHeaderView *)topView {
    _topView = topView;
    _topView.delegate = self;
}

- (void)setFooterView:(FullImageFooterView *)footerView {
    _footerView = footerView;
    _footerView.delegate = self;
}


- (void)dealloc {
    NSLog(@"[%@------------dealloc]", self.class);
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
