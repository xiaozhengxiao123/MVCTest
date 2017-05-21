//
//  ContentCell.h
//  MVVMTest
//
//  Created by Mr Qian on 2016/12/21.
//  Copyright © 2016年 Mr Qian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *contentLab;
@property (nonatomic) float height;//cell高度

- (void)setCellWithInfo:(CityEntity*)entity;

@end
