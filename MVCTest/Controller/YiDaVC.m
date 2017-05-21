//
//  YiDaVC.m
//  MVVMTest
//
//  Created by Mr Qian on 2016/12/21.
//  Copyright © 2016年 Mr Qian. All rights reserved.
//

#import "YiDaVC.h"
#import "ContentCell.h"

@interface YiDaVC ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation YiDaVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height;
    UIScrollView *aSC = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width, height/3)];
    aSC.pagingEnabled = YES;
    NSArray *imagesAry = self.entity.imageAry;
    if (imagesAry && imagesAry.count > 0) {
        for (int i = 0; i < imagesAry.count; i++) {
            width = aSC.bounds.size.width;
            height = aSC.bounds.size.height;
            NSString *strURL = imagesAry[i];
            YDImageView *iv=[[YDImageView alloc] initWithFrame:CGRectMake(i*width, 0, width, height)];
            [iv yidaImageURL:strURL placeholderImage:[UIImage imageNamed:@"default"]];
            [aSC addSubview:iv];
        }
        aSC.contentSize = CGSizeMake(width*imagesAry.count, 0);
        self.tableView.tableHeaderView = aSC;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UITableViewDataSource
//设置表格视图每一组有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

//设置表格视图每一行显示的内容
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"MyContentCell";//定义一个可重用标识，在故事板里设置的！
    ContentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    [cell setCellWithInfo:self.entity];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyContentCell"];
    [cell setCellWithInfo:self.entity];
    return cell.height;
}

@end
