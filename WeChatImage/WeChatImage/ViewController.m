//
//  ViewController.m
//  WeChatImage
//  首界面. 点击获取相册内容
//  Created by CPZX008 on 17/1/4.
//  Copyright © 2017年 xboker. All rights reserved.
//

#import "ViewController.h"
#import "ChoosedCollectionViewCell.h"
#import "PhotoGroupsViewController.h"
#import "GroupModle.h"



@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>


@property (weak, nonatomic) IBOutlet UICollectionView *colllectionView;

@property (nonatomic, strong) NSMutableArray *chooseImages;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    PHFetchResult *assetsFetchResults = [PHAsset fetchAssetsWithOptions:nil];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.chooseImages removeAllObjects];
    [self.chooseImages addObjectsFromArray:[ImageHelper shareImageHelper].phassetChoosedArr];
    [[ImageHelper shareImageHelper].phassetChoosedArr removeAllObjects];
    [self.colllectionView reloadData];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark    interFaceBuilder  Mehtod
//点击跳转到相册相关
- (IBAction)getAumbralleContentAction:(UIButton *)sender {
    PhotosListViewController *listC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"PhotosListViewController"];
    [[ImageHelper shareImageHelper] getAllImageActionWithCollection:nil];
    [self presentViewController:listC animated:YES completion:nil];
    
  
}



#pragma mark    UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.chooseImages.count;
}
// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ChoosedCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ChoosedCollectionViewCell" forIndexPath:indexPath];
    [cell displayCellWithDataSource:self.chooseImages withIndexPath:indexPath];
    return cell;
}

#pragma mark    UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(CELL_COLLECTION_WIDTH - 8 , CELL_COLLECTION_WIDTH);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(1, 1, 1, 1);
}


#pragma mark    Case
- (NSMutableArray *)chooseImages {
    if (!_chooseImages) {
        _chooseImages = [NSMutableArray arrayWithCapacity:0];
    }
    return _chooseImages;
}

@end
