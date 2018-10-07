//
//  Constants.h
//  wechat
//
//  Created by 任志忠 on 2018/10/7.
//  Copyright © 2018 rzz. All rights reserved.
//
//按比例获取高度
#define WGiveHeight(HEIGHT)                                                    \
HEIGHT * [UIScreen mainScreen].bounds.size.height / 568.0

//按比例获取宽度
#define WGiveWidth(WIDTH)                                                      \
WIDTH * [UIScreen mainScreen].bounds.size.width / 320.0

// RGB色值
#define UIColorFromRGB(rgbValue)                                               \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0         \
green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0            \
blue:((float)(rgbValue & 0xFF)) / 255.0                     \
alpha:1.0]

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Constants : NSObject
+ (UIColor*)themeColor;
@end

NS_ASSUME_NONNULL_END
