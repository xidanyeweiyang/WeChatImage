//
//  FullImageHeaderView.h
//  WeChatImage
//
//  Created by CPZX008 on 17/1/5.
//  Copyright © 2017年 xboker. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FullImageHeaderViewDelegate <NSObject>
@required
- (void)fullImageHeaderViewTapDismissAction;
- (void)fullImageHeaderViewTapChangeChooseStatusAction;

@end


@interface FullImageHeaderView : UIView

@property (nonatomic, weak) id<FullImageHeaderViewDelegate>delegate;

- (void)displayHeaderWihtDataSource:(NSMutableArray *)dataSource withIndexPath:(NSIndexPath *)indexPath;



@end
