//
//  RZZMeViewController.m
//  wechat
//
//  Created by 任志忠 on 2018/10/7.
//  Copyright © 2018 rzz. All rights reserved.
//

#import "RZZMeViewController.h"
#import "RZZPersonModel.h"
#import "RZZMeTableViewCell.h"

@interface RZZMeViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy) UITableView *tableView;

/**
 名字数组
 */
@property (nonatomic, copy) NSArray *dataArr;


/**
 图片数组
 */
@property (nonatomic, copy) NSArray *imageArr;

@end

@implementation RZZMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializeDate];
    [self buildTableView];
}

/**
 初始化数据
 */
-(void)initializeDate
{
    RZZPersonModel *model = [[RZZPersonModel alloc] init];
    model.name = @"Renzz";
    model.image = @"siegrain_avatar";
    model.wechatID = @"euphoria33";
    
    _dataArr = @[
                 @[model],
                 @[@"钱包"],
                 @[@"收藏",@"相册",@"卡包",@"表情"],
                 @[@"设置"]
                 ];
    
    _imageArr = @[
                  @[@""],
                  @[@"MoreMyBankCard"],
                  @[@"MoreMyFavorites",@"MoreMyAlbum",@"MyCardPackageIcon",@"MoreExpressionShops"],
                  @[@"MoreSetting"]
                  ];
}

-(void)buildTableView
{
    _tableView = (
                  {
                      UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height -44) style:UITableViewStyleGrouped];
                      tableView.delegate = self;
                      tableView.dataSource = self;
                      //调整两个cell之间的分割线的长度
                      tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
                      
                      tableView;
                  });
    [self.view addSubview:_tableView];
}

#pragma mark - tableview datesources
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *rowArr = _dataArr[section];
    return rowArr.count;
}

/**
 注册设置cell样式

 @param tableView <#tableView description#>
 @param indexPath <#indexPath description#>
 @return <#return value description#>
 */
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"meCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        if (indexPath.section == 0) {
            cell = [[RZZMeTableViewCell alloc] init];
        } else {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier ];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    return cell;
}

/**
 设置cell内容

 @param tableView <#tableView description#>
 @param cell <#cell description#>
 @param indexPath <#indexPath description#>
 */
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        RZZMeTableViewCell *meCell = (RZZMeTableViewCell *)cell;
        meCell.model = _dataArr[indexPath.section][indexPath.row];
    } else {
        cell.imageView.image = [UIImage imageNamed:_imageArr[indexPath.section][indexPath.row]];
        cell.textLabel.text = _dataArr[indexPath.section][indexPath.row];
    }
}

/**
 设置每行的高度

 @param tableView <#tableView description#>
 @param indexPath <#indexPath description#>
 @return <#return value description#>
 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 90;
    }
    return 44;
}

/**
 设置行与行之间的距离

 @param tableView <#tableView description#>
 @param section <#section description#>
 @return <#return value description#>
 */
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 15;
    }
    return 5;
}
@end
