//
//  FullImageFooterView.h
//  WeChatImage
//
//  Created by CPZX008 on 17/1/4.
//  Copyright © 2017年 xboker. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FullImageFooterViewDelegate <NSObject>
@required
- (void)chooseImageSendAction;
//查看原图
- (void)checkOriginalImageAction;


@end


@interface FullImageFooterView : UIView
@property (nonatomic, weak) id<FullImageFooterViewDelegate>delegate;
- (void)displayFooterWithCount:(NSInteger)count;

@end
