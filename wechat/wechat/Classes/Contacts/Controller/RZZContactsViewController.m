//
//  RZZContactsViewController.m
//  wechat
//
//  Created by 任志忠 on 2018/10/7.
//  Copyright © 2018 rzz. All rights reserved.
//

#import "RZZContactsViewController.h"
#import <YSMChineseSort/NSArray+SortContact.h>
#import "RZZContactsTableViewCell.h"
#import "UIImage+RandomImage.h"
#import "UIImage+common.h"
#import "Constants.h"
#import "GlassView.h"
#import "RZZSezrchResultsTableViewController.h"

@interface RZZContactsViewController ()<UITableViewDelegate, UITableViewDataSource,                       UISearchControllerDelegate, UISearchBarDelegate>
@property (nonatomic, strong) UITableView* tableView;

@property (nonatomic, copy) NSArray* firstSectionData;

@property (nonatomic, copy) NSArray* contacts;

//排序完成的数组
@property (nonatomic, copy) NSArray* grouppedContacts;
//头部
@property (nonatomic, copy) NSArray* headers;
    
@property (nonatomic, strong) UISearchController* searchController;

@property (strong, nonatomic) GlassView* glassView;


@end

@implementation RZZContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializeData];
    [self buildTableView];
}

- (void)initializeData
{
    _firstSectionData = @[
                              @[ @"plugins_FriendNotify", @"新的朋友" ],
                              @[ @"add_friend_icon_addgroup", @"群聊" ],
                              @[ @"Contact_icon_ContactTag", @"标签" ],
                              @[ @"add_friend_icon_offical", @"公众号" ]
                              ];
    
    _contacts = @[
                      @"吴正祥",
                      @"陈维",
                      @"赖杰",
                      @"范熙丹",
                      @"丁亮",
                      @"赵雨彤",
                      @"落落",
                      @"Leo琦仔",
                      @"廖宇超",
                      @"Darui Li",
                      @"刘洋"
                      ];
    //排序
    [self.contacts sortContactTOTitleAndSectionRow_A_EC:^(BOOL isSuccess, NSArray *titleArray, NSArray *rowArray) {
        if (!isSuccess) {
            return ;
        }
        self.grouppedContacts = rowArray;
        self.headers = titleArray;
    }];
}
    
-(void)buildTableView
{
    _tableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        tableView.delegate =self;
        tableView.dataSource =self;
        
        tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        tableView.rowHeight = 50;
        
        tableView.tableFooterView = [self tableFooterView];
        tableView.tableHeaderView = [self tableHeaderView];
        
        //右边索引样式
        tableView.sectionIndexColor = [UIColor grayColor];
        tableView.sectionIndexBackgroundColor = [UIColor clearColor];
        
        tableView;
    });
    [self.view addSubview:_tableView];
}

#pragma mark - search
- (UISearchBar *)tableHeaderView
{
    NSMutableArray *tempTmageArray = [NSMutableArray array];
    for (int  i=0; i<self.contacts.count; i++) {
        [tempTmageArray addObject:[UIImage randomImageInPath:@"cell"]];
    }
    RZZSezrchResultsTableViewController *resultController = [[RZZSezrchResultsTableViewController alloc] initWithKeywords:self.contacts andImages:tempTmageArray];
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:resultController];
    self.searchController.searchResultsUpdater = resultController;
    //取消蒙版
    self.searchController.dimsBackgroundDuringPresentation =NO;
    self.searchController.delegate = self;
    
    UISearchBar *bar = self.searchController.searchBar;
    //输入过多自适应
    [bar sizeToFit];
    bar.delegate = self;
    bar.backgroundColor = [UIColor colorWithWhite:.95 alpha:1];
    bar.backgroundImage = [UIImage imageWithColor:[UIColor clearColor] size:CGSizeMake(bar.frame.size.width, bar.frame.size.height)];
    bar.placeholder = @"搜索";
    bar.tintColor = [Constants themeColor];
    //是否在搜索框右侧显示一个图书的按钮，默认为NO
    bar.showsBookmarkButton =YES;
    [bar setImage:[UIImage imageNamed:@"VoiceSearchStartBtn"] forSearchBarIcon:UISearchBarIconBookmark state:UIControlStateNormal];
    return bar;
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    //修改searchbar右侧按钮的文字
    [searchBar setShowsCancelButton:YES animated:YES];
    UIButton *btn = [searchBar valueForKey:@"_cancelButton"];
    [btn setTitle:@"取消" forState:UIControlStateNormal];
}

-(GlassView *)glassView
{
    if (!_glassView) {
        _glassView = [[GlassView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    }
    return _glassView;
}

-(void)willPresentSearchController:(UISearchController *)searchController
{
    [self.view addSubview:self.glassView];
    NSLog(@"%@",self.glassView);
}

-(void)willDismissSearchController:(UISearchController *)searchController
{
    [self.glassView removeFromSuperview];
}

#pragma mark - footer
-(UIView *)tableFooterView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50)];
    UILabel *label = [[UILabel alloc] initWithFrame:view.bounds];
    label.text = [NSString stringWithFormat:@"%lu位联系人",self.contacts.count];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor lightGrayColor];
    [view addSubview:label];
    
    return view;
}
    
#pragma mark - header

#pragma mark - tableview datasource & delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.headers.count + 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.firstSectionData.count;
    }
    return [self.grouppedContacts[section -1] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"contactsCellIdentifier";
    RZZContactsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[RZZContactsTableViewCell alloc] init];
        [cell setRestorationIdentifier:identifier];
        
        //调整分割线长度
        cell.preservesSuperviewLayoutMargins = false;
        cell.layoutMargins = UIEdgeInsetsZero;
        cell.separatorInset = UIEdgeInsetsMake(0, 10, 0, 0);
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(RZZContactsTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        cell.avatar = [UIImage imageNamed:self.firstSectionData[indexPath.row][0]];
        cell.name = self.firstSectionData[indexPath.row][1];
    } else {
        cell.avatar = [UIImage randomImageInPath:@"cell"];
        cell.name = self.grouppedContacts[indexPath.section -1][indexPath.row];
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return nil;
    }
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 20)];
    headerView.backgroundColor = [UIColor colorWithWhite:.95 alpha:1];
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    headerLabel.textColor = [UIColor lightGrayColor];
    headerLabel.font = [UIFont boldSystemFontOfSize:14];
    headerLabel.text = self.headers[section - 1];
    headerLabel.frame = CGRectMake(10, 0, headerView.bounds.size.width, headerView.bounds.size.height);
    [headerView addSubview:headerLabel];
    return headerView;
}


/**
 自定义headerView必须设置这个

 @param tableView <#tableView description#>
 @param section <#section description#>
 @return <#return value description#>
 */
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section == 0 ? 0 : 20;
}


/**
 添加索引

 @param tableView <#tableView description#>
 @return <#return value description#>
 */
-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.headers;
}

/**
 点击索引的哪个跳转到哪组

 @param tableView <#tableView description#>
 @param title <#title description#>
 @param index <#index description#>
 @return <#return value description#>
 */
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return index+1;
}
@end
