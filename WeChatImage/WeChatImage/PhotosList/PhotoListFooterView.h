//
//  PhotoListFooterView.h
//  WeChatImage
//
//  Created by CPZX008 on 17/1/4.
//  Copyright © 2017年 xboker. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PhotoListFooterViewTapType){
    PhotoListFooterViewTapTypePreview,
    PhotoListFooterViewTapTypeSend
};

@protocol PhotoListFooterViewDelegate <NSObject>
@required
- (void)photoListFooterViewTapWithType:(PhotoListFooterViewTapType)type;
@end


@interface PhotoListFooterView : UIView

@property (nonatomic, weak) id<PhotoListFooterViewDelegate>delegate;
- (void)displayFooterWithCount:(NSInteger)count;



@end
