//
//  NSString+PinYin.m
//  wechat
//
//  Created by 任志忠 on 2018/10/7.
//  Copyright © 2018 rzz. All rights reserved.
//

#import "NSString+PinYin.h"

@implementation NSString (PinYin)
- (NSString*)transformToPinyin
{
    NSMutableString* mutableString = [NSMutableString stringWithString:self];
    CFStringTransform((CFMutableStringRef)mutableString, NULL,
                      kCFStringTransformToLatin, false);
    CFStringTransform((CFMutableStringRef)mutableString, NULL,
                      kCFStringTransformStripDiacritics, false);
    return mutableString;
}
@end
