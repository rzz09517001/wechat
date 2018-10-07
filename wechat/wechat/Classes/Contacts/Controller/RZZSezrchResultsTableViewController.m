//
//  RZZSezrchResultsTableViewController.m
//  wechat
//
//  Created by 任志忠 on 2018/10/7.
//  Copyright © 2018 rzz. All rights reserved.
//

#import "RZZSezrchResultsTableViewController.h"
#import "RZZContactsTableViewCell.h"
#import "NSString+PinYin.h"

@interface RZZSezrchResultsTableViewController ()
@property (copy, nonatomic) NSArray* keywords;
@property (copy, nonatomic) NSArray<UIImage*>* images;

@property (strong, nonatomic) NSMutableArray<NSNumber*>* filteredResultIndexes;
@end

@implementation RZZSezrchResultsTableViewController

/*初始化方法*/
- (instancetype)initWithKeywords:(NSArray*)keywords
                       andImages:(NSArray<UIImage*>*)images
{
    if (self = [super initWithStyle:UITableViewStylePlain]) {
        self.keywords = keywords;
        self.images = images;
        self.filteredResultIndexes = [NSMutableArray array];
        
        self.tableView.rowHeight = 60;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Table view data source
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.filteredResultIndexes.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"searchResultCell";
    RZZContactsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[RZZContactsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(RZZContactsTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger index = [self.filteredResultIndexes[indexPath.row] integerValue];
    cell.avatar = self.images[index];
    cell.name = self.keywords[index];
}

#pragma mark - search result updating
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *searchString = searchController.searchBar.text;
    [self.filteredResultIndexes removeAllObjects];
    if (searchString.length > 0) {
        for (int i =0; i < self.keywords.count; i++) {
            NSString *keyword = self.keywords[i];
            NSString *pinyin = [NSString stringWithFormat:@"%@", [keyword transformToPinyin]];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[cd] %@", searchString];
            if (![predicate evaluateWithObject:pinyin] &&![predicate evaluateWithObject:keyword]) {
                continue;
            }
            [self.filteredResultIndexes addObject:@(i)];
        }
    }
    [self.tableView reloadData];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //修正navigationcontroller+searchresultscontroller下tableview高度不正确的问题
    self.tableView.frame = CGRectMake(0, -40, self.view.bounds.size.width, self.view.bounds.size.height);
}
@end
