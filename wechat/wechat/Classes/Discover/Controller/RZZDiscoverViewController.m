//
//  RZZDiscoverViewController.m
//  wechat
//
//  Created by 任志忠 on 2018/10/7.
//  Copyright © 2018 rzz. All rights reserved.
//

#import "RZZDiscoverViewController.h"

@interface RZZDiscoverViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView* tableView;
//名字数组
@property (nonatomic, copy) NSArray* dataArr;

//图片数组
@property (nonatomic, copy) NSArray* imgArr;

@end

@implementation RZZDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeData];
    [self buildTableView];
}

- (void)initializeData
{
    _dataArr = @[
                 @[ @"朋友圈" ],
                 @[ @"扫一扫", @"摇一摇" ],
                 @[ @"附近的人" ],
                 @[ @"购物", @"游戏" ]
                 ];
    
    _imgArr = @[
                @[ @"ff_IconShowAlbum" ],
                @[ @"ff_IconQRCode", @"ff_IconBottle" ],
                @[ @"ff_IconLocationService" ],
                @[ @"CreditCard_ShoppingBag", @"MoreGame" ]
                ];
}
- (void)buildTableView
{
    _tableView = ({
        UITableView* tableView = [[UITableView alloc]
                                  initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,
                                                           self.view.frame.size.height - 44)
                                  style:UITableViewStyleGrouped];
        
        tableView.delegate = self;
        tableView.dataSource = self;
        
        //调整两个cell之间的分割线的长度
        tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        tableView;
    });
    
    [self.view addSubview:_tableView];
}
#pragma mark - tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return _dataArr.count;
}

- (NSInteger)tableView:(UITableView*)tableView
 numberOfRowsInSection:(NSInteger)section
{
    NSArray* rowArr = _dataArr[section];
    return rowArr.count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView
        cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString* identifier = @"foundCellIdentifier";
    UITableViewCell* cell =
    [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:identifier];
        //右侧小箭头
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

- (void)tableView:(UITableView*)tableView
  willDisplayCell:(UITableViewCell*)cell
forRowAtIndexPath:(NSIndexPath*)indexPath
{
    cell.imageView.image =
    [UIImage imageNamed:_imgArr[indexPath.section][indexPath.row]];
    cell.textLabel.text = _dataArr[indexPath.section][indexPath.row];
}

- (CGFloat)tableView:(UITableView*)tableView
heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView*)tableView
heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return 15;
    
    return 5;
}

@end
