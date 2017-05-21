//
//  CityEntity.h
//  MVVMTest
//
//  Created by Mr Qian on 2016/12/18.
//  Copyright © 2016年 Mr Qian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityEntity : NSObject
@property (nonatomic,strong) NSString *imageURL;//图片缩略图URL
@property (nonatomic,strong) NSString *title;//标题
@property (nonatomic,strong) NSString *content;//内容
@property (nonatomic,strong) NSArray *imageAry;//图片数组

@end
