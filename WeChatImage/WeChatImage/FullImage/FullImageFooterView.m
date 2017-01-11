//
//  FullImageFooterView.m
//  WeChatImage
//
//  Created by CPZX008 on 17/1/4.
//  Copyright © 2017年 xboker. All rights reserved.
//

#import "FullImageFooterView.h"

@interface FullImageFooterView()
@property (nonatomic, weak) IBOutlet UILabel *countLable;
@property (nonatomic, weak) IBOutlet UIView *animationView;

@end

@implementation FullImageFooterView


- (void)displayFooterWithCount:(NSInteger)count {
    self.countLable.text = [@(count) stringValue];
    [self animationAction];
}


- (void)animationAction {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.repeatCount = 1;
    animation.removedOnCompletion = YES;
    animation.duration = 0.4;
    animation.fillMode = kCAFillModeForwards;
    animation.values = @[@(0.4), @(0.5), @(0.6), @(0.7), @(0.8), @(0.9),@(1), @(0.9), @(0.8), @(0.9),@(1)];
    [self.animationView.layer addAnimation:animation forKey:@"animation"];
    
}

#pragma mark    interFaceBuilder    method
- (IBAction)senderAction:(id)sender {
    [self.delegate chooseImageSendAction];
}

- (IBAction)checkFomerImage:(id)sender {
    [self.delegate checkOriginalImageAction];
}




- (void)dealloc {
    [self.animationView.layer removeAnimationForKey:@"animation"];
    [self.countLable.layer removeAllAnimations];
    NSLog(@"[%@---------------dealloc]", self.class);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
