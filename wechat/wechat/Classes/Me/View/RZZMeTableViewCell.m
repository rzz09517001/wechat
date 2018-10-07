//
//  RZZMeTableViewCell.m
//  wechat
//
//  Created by 任志忠 on 2018/10/7.
//  Copyright © 2018 rzz. All rights reserved.
//

#import "RZZMeTableViewCell.h"

@implementation RZZMeTableViewCell

-(void)setModel:(RZZPersonModel *)model
{
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.vatarImageView.image = [UIImage imageNamed:model.image];
    self.nameLabel.text = model.name;
    self.wechatIdLabel.text = [NSString stringWithFormat:@"微信号：%@", model.wechatID];
    self.barcodeImageView.image = [UIImage imageNamed:@"ScanQRCode"];
    self.barcodeImageView.backgroundColor = [UIColor whiteColor];
}

-(UIImageView *)vatarImageView
{
    if (!_vatarImageView) {
        _vatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 12, self.frame.size.height-2 *12, self.frame.size.height-2 *12)];
        //裁剪属性，当子视图超出父视图的范围时要裁剪
        _vatarImageView.clipsToBounds =YES;
        //圆角
        _vatarImageView.layer.cornerRadius = 3;
        
        [self addSubview:_vatarImageView];
    }
    return _vatarImageView;
}

-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.height, 19, 160, 22)];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        
        [self addSubview:_nameLabel];
    }
    return _nameLabel;
}

-(UILabel *)wechatIdLabel
{
    if (!_wechatIdLabel) {
        _wechatIdLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.height, self.nameLabel.frame.origin.y + self.nameLabel.frame.size.height + 5, 160, 20)];
        _wechatIdLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:_wechatIdLabel];
    }
    return _wechatIdLabel;
}

-(UIImageView *)barcodeImageView
{
    if (!_barcodeImageView) {
        _barcodeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - 50, (self.frame.size.height -35 / 2.0) / 2.0, 35 / 2.0, 35 /2.0)];
        
        [self addSubview:_barcodeImageView];
    }
    return _barcodeImageView;
}
@end
