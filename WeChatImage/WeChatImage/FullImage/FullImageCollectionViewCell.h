//
//  FullImageCollectionViewCell.h
//  WeChatImage
//
//  Created by CPZX008 on 17/1/4.
//  Copyright © 2017年 xboker. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FullImageCollectionViewCellDelegate  <NSObject>

- (void)fullImageCollectionViewCellTaped;

@end


@interface FullImageCollectionViewCell : UICollectionViewCell
@property (nonatomic, weak) id<FullImageCollectionViewCellDelegate>delegate;

- (void)displayCellWithDataSource:(NSMutableArray *)dataSource  inedexPath:(NSIndexPath *)indexPath isOriginalImage:(BOOL)isOriginal;
@end
