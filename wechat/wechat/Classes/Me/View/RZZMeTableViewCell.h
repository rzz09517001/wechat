//
//  RZZMeTableViewCell.h
//  wechat
//
//  Created by 任志忠 on 2018/10/7.
//  Copyright © 2018 rzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RZZPersonModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RZZMeTableViewCell : UITableViewCell

@property (nonatomic, strong) RZZPersonModel *model;

@property (nonatomic, strong) UIImageView *vatarImageView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *wechatIdLabel;

@property (nonatomic, strong) UIImageView *barcodeImageView;

-(void)setModel:(RZZPersonModel * _Nonnull)model;

@end

NS_ASSUME_NONNULL_END
