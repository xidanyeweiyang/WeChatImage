//
//  ChoosedCollectionViewCell.h
//  WeChatImage
//
//  Created by CPZX008 on 17/1/5.
//  Copyright © 2017年 xboker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChoosedCollectionViewCell : UICollectionViewCell
- (void)displayCellWithDataSource:(NSMutableArray *)dataSource withIndexPath:(NSIndexPath *)indexPath;
@end
