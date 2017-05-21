//
//  YDRequest.h
//  MVVMTest
//
//  Created by Mr Qian on 2016/12/18.
//  Copyright © 2016年 Mr Qian. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^RequedtResult)(id obj, NSError* err);

@interface YDRequest : NSObject
@property (copy, nonatomic) RequedtResult rResult;

//网络请求 单例
+ (YDRequest*)share;

//post请求 城市信息接口
- (void)postCityRequest;

//post请求 天气预报接口
- (void)postWeatherRequest;

//post请求 火车票接口
- (void)postRailwayTicketRequest;

//接着写更多的API接口...

@end
