//
//  ListCollectionViewCell.h
//  WeChatImage
//
//  Created by CPZX008 on 17/1/4.
//  Copyright © 2017年 xboker. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ListCollectionViewCellDelegate <NSObject>

#pragma mark    将选择的图片个数传递出去
- (void)imageHelperGetImageCount:(NSInteger)count;

@end




@interface ListCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) id<ListCollectionViewCellDelegate>delegate;

- (void)displayCellWithDataSource:(NSMutableArray *)dataSource withIndexPath:(NSIndexPath *)indexPath isCancleAction:(BOOL)cancleAction;


@end
