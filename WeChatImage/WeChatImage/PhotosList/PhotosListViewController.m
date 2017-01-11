//
//  PhotosListViewController.m
//  WeChatImage
//  某个相册(例如微博, QQ)的照片列表
//  Created by CPZX008 on 17/1/4.
//  Copyright © 2017年 xboker. All rights reserved.
//

#import "PhotosListViewController.h"
#import "PhotoListFooterView.h"
#import "ListCollectionViewCell.h"
#import "PhotoFullViewController.h"
#import "CustomViewController.h"
#import "ViewController.h"
#import "GroupModle.h"


@interface PhotosListViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ListCollectionViewCellDelegate, PhotoListFooterViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet PhotoListFooterView *fooerView;

@property (nonatomic, assign) BOOL cancelAllAction;



@end

@implementation PhotosListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.cancelAllAction = NO;
    [self.fooerView displayFooterWithCount:[ImageHelper shareImageHelper].phassetChoosedArr.count];
    [self.collectionView reloadData];
}



#pragma mark    statusBarStyle
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark    ListCollectionViewCellDelegate
- (void)imageHelperGetImageCount:(NSInteger)count {
    [self.fooerView displayFooterWithCount:count];
}



#pragma mark    UICollectionViewDelegate, UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [ImageHelper shareImageHelper].phassetArr.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ListCollectionViewCell" forIndexPath:indexPath];
    [cell displayCellWithDataSource:[ImageHelper shareImageHelper].phassetArr withIndexPath:indexPath isCancleAction:self.cancelAllAction];
    cell.delegate = self;
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoFullViewController *fullC = [self.storyboard instantiateViewControllerWithIdentifier:@"PhotoFullViewController"];
    fullC.previewType = FullImageTypeAllPreview;
    fullC.previewIndex = indexPath.item;
    [self presentViewController:fullC animated:YES completion:nil];
    
}





#pragma mark    UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(CELL_COLLECTION_WIDTH - 8 , CELL_COLLECTION_WIDTH);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(1, 1, 1, 1);
}




#pragma mark    interFaceBuilder    Method
//取消所有
- (IBAction)cancleAllChooseImages:(UIBarButtonItem *)sender {
    [[ImageHelper shareImageHelper].phassetChoosedArr removeAllObjects];
    [self dismissViewControllerAnimated:YES completion:^{
        [[ImageHelper shareImageHelper].phassetArr removeAllObjects];
    }];
    
    
}

//跳转到相册分类
- (IBAction)goToAlbumClassificaiton:(UIBarButtonItem *)sender {
    [[ImageHelper shareImageHelper].phassetChoosedArr removeAllObjects];
    [[ImageHelper shareImageHelper].phassetArr removeAllObjects];
    UIViewController *VC = self;
    if ([VC.presentingViewController isKindOfClass:[CustomViewController class]]) {
        VC = VC.presentingViewController;
        PhotoGroupsViewController *groupC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"PhotoGroupsViewController"];
        [groupC.groupModle getAllKindImagesAction];
        [(CustomViewController *)VC pushViewController:groupC animated:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}


#pragma mark    PhotoListFooterViewDelegate 
//发送或者预览
- (void)photoListFooterViewTapWithType:(PhotoListFooterViewTapType)type {
    if (type == PhotoListFooterViewTapTypeSend) {
        [self dismissViewControllerAnimated:YES completion:nil];
        [[ImageHelper shareImageHelper].phassetArr removeAllObjects];
        NSLog(@"%@____已选的照片发送",  [ImageHelper shareImageHelper].phassetChoosedArr);
    }else {
        NSLog(@"%@____大图预览",  [ImageHelper shareImageHelper].phassetChoosedArr);
        PhotoFullViewController *fullC = [self.storyboard instantiateViewControllerWithIdentifier:@"PhotoFullViewController"];
        fullC.previewType = FullImageTypeSomePreview;
        if ([ImageHelper shareImageHelper].phassetChoosedArr.count) {
            [self presentViewController:fullC animated:YES completion:nil];
        } 
    }
}


#pragma mark    Case
- (void)setFooerView:(PhotoListFooterView *)fooerView {
    _fooerView = fooerView;
    _fooerView.delegate = self;
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
