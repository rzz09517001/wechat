//
//  RZZSezrchResultsTableViewController.h
//  wechat
//
//  Created by 任志忠 on 2018/10/7.
//  Copyright © 2018 rzz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RZZSezrchResultsTableViewController : UITableViewController<UISearchResultsUpdating>
- (instancetype)initWithKeywords:(NSArray*)keywords
                       andImages:(NSArray<UIImage*>*)images;

@end

NS_ASSUME_NONNULL_END
