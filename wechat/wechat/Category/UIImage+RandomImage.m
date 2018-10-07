//
//  UIImage+RandomImage.m
//  wechat
//
//  Created by 任志忠 on 2018/10/7.
//  Copyright © 2018 rzz. All rights reserved.
//

#import "UIImage+RandomImage.h"

@implementation UIImage (RandomImage)
+ (UIImage*)randomImageInPath:(NSString*)path;
{
    NSString* imagePath =
    [NSString stringWithFormat:@"%@/%u.jpg", [[NSBundle mainBundle] bundlePath],
     arc4random() % 29];
    UIImage* image = [[UIImage alloc] initWithContentsOfFile:imagePath];
    return image;
}

@end
