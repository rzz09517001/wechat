//
//  RZZPersonModel.h
//  wechat
//
//  Created by 任志忠 on 2018/10/7.
//  Copyright © 2018 rzz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RZZPersonModel : NSObject

/**
 名称
 */
@property(nonatomic, copy) NSString *name;


/**
 头像
 */
@property(nonatomic, copy) NSString *image;


/**
 微信号
 */
@property(nonatomic, copy) NSString *wechatID;

@end

NS_ASSUME_NONNULL_END
