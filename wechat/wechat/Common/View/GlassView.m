//
//  GlassView.m
//  wechat
//
//  Created by 任志忠 on 2018/10/7.
//  Copyright © 2018 rzz. All rights reserved.
//

#import "GlassView.h"

@implementation GlassView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //毛玻璃效果
        UIBlurEffect* blurEffect =
        [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView* effectView =
        [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        effectView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        
        [self addSubview:effectView];
    }
    return self;
}

@end
