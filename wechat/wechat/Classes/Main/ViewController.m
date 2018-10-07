//
//  ViewController.m
//  wechat
//
//  Created by 任志忠 on 2018/10/7.
//  Copyright © 2018 rzz. All rights reserved.
//

#import "ViewController.h"
#import "RZZBaseInfoViewController.h"
#import "RZZContactsViewController.h"
#import "RZZDiscoverViewController.h"
#import "RZZMeViewController.h"

@interface ViewController ()<UITabBarDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    RZZBaseInfoViewController *baseVC = [[RZZBaseInfoViewController alloc] init];
    baseVC.navigationItem.title = @"微信";
    RZZContactsViewController *contactsVC = [[RZZContactsViewController alloc] init];
    contactsVC.navigationItem.title = @"通讯录";
    RZZDiscoverViewController *discoverVC = [[RZZDiscoverViewController alloc] init];
    discoverVC.navigationItem.title = @"发现";
    RZZMeViewController *meVC = [[RZZMeViewController alloc] init];
    meVC.navigationItem.title = @"我";
    
    self.viewControllers = @[
                            [self addNavigationController:baseVC],
                            [self addNavigationController:contactsVC],
                            [self addNavigationController:discoverVC],
                            [self addNavigationController:meVC]
                             ];
    
    NSArray *titles = @[@"微信",@"通讯录",@"发现",@"我"];
    NSArray *images = @[@"tabbar_mainframe",@"tabbar_contacts",@"tabbar_discover",@"tabbar_me"];
    [self.tabBar.items enumerateObjectsUsingBlock:^(UITabBarItem * item, NSUInteger idx, BOOL * _Nonnull stop) {
        item.title = titles[idx];
        item.image = [[UIImage imageNamed:images[idx]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.selectedImage = [[UIImage imageNamed:[images[idx] stringByAppendingString:@"HL"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        //设置红点数字
        NSInteger i = arc4random() % 100;
        item.badgeValue = [NSString stringWithFormat:@"%ld",i];
    }];
    self.tabBar.tintColor =
    [UIColor colorWithRed:9 / 255.0 green:187 / 255.0 blue:7 / 255.0 alpha:1];    
}


/**
 封装成navigation

 @param viewController <#viewController description#>
 @return <#return value description#>
 */
-(UINavigationController *)addNavigationController:(UIViewController *)viewController
{
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewController];
    return nav;
}


#pragma mark - TabBarDelegate
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    item.badgeValue = nil;
}
@end
