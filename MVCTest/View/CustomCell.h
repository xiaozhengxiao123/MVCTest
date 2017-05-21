//
//  CustomCell.h
//  MVVMTest
//
//  Created by Mr Qian on 2016/12/18.
//  Copyright © 2016年 Mr Qian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell
@property (strong, nonatomic) IBOutlet YDImageView *cellImageView;
@property (strong, nonatomic) IBOutlet UILabel *cellTitleLab;
@property (strong, nonatomic) IBOutlet UILabel *cellContentLab;
@property (nonatomic) float height;//cell高度

- (void)setCellWithInfo:(CityEntity*)entity;

@end
