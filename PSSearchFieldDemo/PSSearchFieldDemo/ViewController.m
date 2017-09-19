//
//  ViewController.m
//  PSSearchFieldDemo
//
//  Created by 冯广勇 on 2017/9/16.
//  Copyright © 2017年 shuima. All rights reserved.
//

#import "ViewController.h"
#import "PSNavigationSearchField.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    PSNavigationSearchField *searchField = [PSNavigationSearchField navigationSearchField];
    searchField.naviTitle = @"搜索框Demo";
    self.navigationItem.titleView = searchField;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
