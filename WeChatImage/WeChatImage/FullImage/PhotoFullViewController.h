//
//  PhotoFullViewController.h
//  WeChatImage
//
//  Created by CPZX008 on 17/1/4.
//  Copyright © 2017年 xboker. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, FullImageType) {
    FullImageTypeSomePreview,
    FullImageTypeAllPreview
};


@interface PhotoFullViewController : UIViewController

@property (nonatomic, assign) FullImageType previewType;
@property (nonatomic, assign) NSInteger previewIndex;


@end
