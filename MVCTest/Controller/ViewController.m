//
//  ViewController.m
//  MVCTest
//
//  Created by Mr Qian on 2016/12/22.
//  Copyright © 2016年 Mr Qian. All rights reserved.
//

#import "ViewController.h"
#import "CustomCell.h"
#import "YiDaVC.h"

@interface ViewController ()
@property (nonatomic, strong) YDRequest *request;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"城市信息";
    self.arrayData = [NSMutableArray array];
    [self getCityInfomation];//获取城市信息
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//获取城市信息
- (void)getCityInfomation {
    self.request = [[YDRequest alloc] init];//创建网络请求
    __weak typeof(self) weakSelf = self;//typeof(self)等价于 ViewController*   防止内存泄漏!
    weakSelf.request.rResult = ^(id obj, NSError* err) {
        if (obj && [obj isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = (NSDictionary*)obj;
            NSArray *ary = dic[@"a"];
            for (NSDictionary *aDic in ary) {
                CityEntity *en = [[CityEntity alloc] init];
                en.title = aDic[@"c"];
                en.imageURL = aDic[@"d"];
                en.content = aDic[@"f"];
                NSString *strURL = aDic[@"e"];
                NSArray *ary = [strURL componentsSeparatedByString:@","];
                if (ary && ary.count > 0) {
                    en.imageAry = ary;
                } else {
                    en.imageAry = nil;
                }
                [weakSelf.arrayData addObject:en];
            }
            
            if (weakSelf.arrayData.count > 0) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.tableView reloadData];//刷新数据
                });
            }
        }
    };
    [self.request postCityRequest];//开始请求城市信息
}

#pragma mark - UITableViewDataSource
//设置表格视图每一组有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.arrayData && [self.arrayData count]) {
        return [self.arrayData count];
    }
    
    return 0;
}

//设置表格视图每一行显示的内容
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"MyCustomCell";//定义一个可重用标识，在故事板里设置的！
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (self.arrayData && indexPath.row < [self.arrayData count])  {
        [cell setCellWithInfo:self.arrayData[indexPath.row]];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0;
    if (self.arrayData && indexPath.row < [self.arrayData count])  {
        CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCustomCell"];
        [cell setCellWithInfo:self.arrayData[indexPath.row]];
        height = cell.height;
    }
    return height;
}

//选择表格视图某一行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < [self.arrayData count]) {
        CityEntity *entity = [self.arrayData objectAtIndex:indexPath.row];
        UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        YiDaVC *vc = [main instantiateViewControllerWithIdentifier:@"YiDaVC"];
        vc.entity = entity;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
