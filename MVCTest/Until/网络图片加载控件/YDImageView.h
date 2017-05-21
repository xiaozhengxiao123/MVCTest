//
//  YDImageView.h
//  YIDaDemo
//
//  Created by Mr Qian on 16/2/26.
//  Copyright © 2016年 Mr Qian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YDImageView : UIImageView
@property (nonatomic, strong) NSString *imageURL;//保存图片URL

/**
 @功能：根据URL获取网络图片
 @参数：图片url  默认显示图片
 @返回值：空
 */
- (void)yidaImageURL:(NSString*)strURL placeholderImage:(UIImage*)placeholderImage;

//清理指定图片的缓存
- (void)clearCache;

//清理所有的图片缓存
+ (void)clearAllCaches;

@end
