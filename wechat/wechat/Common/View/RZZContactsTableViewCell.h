//
//  RZZContactsTableViewCell.h
//  wechat
//
//  Created by 任志忠 on 2018/10/7.
//  Copyright © 2018 rzz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ContactsTableViewCellStyle) {
    ContactsTableViewCellStyleDefault = 0,
    ContactsTableViewCellStyleSubtitle
};

@interface RZZContactsTableViewCell : UITableViewCell

@property (assign, nonatomic) ContactsTableViewCellStyle style;
@property (assign, nonatomic) CGFloat avatarCornerRadius;

/*请按照以下顺序设值*/
@property (strong, nonatomic) UIImage* avatar;
@property (copy, nonatomic) NSString* name;
@property (copy, nonatomic) NSString* descriptionText;

@end

NS_ASSUME_NONNULL_END
