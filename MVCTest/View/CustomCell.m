//
//  CustomCell.m
//  MVVMTest
//
//  Created by Mr Qian on 2016/12/18.
//  Copyright © 2016年 Mr Qian. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//设置标题内容
- (void)setCellWithInfo:(CityEntity*)entity {
    self.height = 0.0;//重置cell高度为0
    [self.cellImageView yidaImageURL:entity.imageURL placeholderImage:[UIImage imageNamed:@"default"]];
    self.cellTitleLab.text = entity.title;
    
    //重新设置内容lab的frame，方便后面动态计算(注意：lab的宽度不能写死，也不能使用自动布局的！否则计算出的高度有问题)
    CGRect r = self.cellContentLab.frame;
    CGFloat W = [UIScreen mainScreen].bounds.size.width;//物理屏幕宽
    self.cellContentLab.frame = CGRectMake(r.origin.x, r.origin.y, W-2*r.origin.x, r.size.height);
    self.cellContentLab.text =entity.content;
    
    // 动态计算内容的高度
    NSDictionary *attribute = @{NSFontAttributeName:self.cellContentLab.font};
    CGSize size = [self.cellContentLab.text boundingRectWithSize:CGSizeMake(self.cellContentLab.frame.size.width, MAXFLOAT) options: NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    self.cellContentLab.frame = CGRectMake(r.origin.x, r.origin.y, r.size.width, size.height);
    
    //动态计算总高度
    self.height += self.cellContentLab.frame.origin.y+self.cellContentLab.frame.size.height+10;
}

@end
