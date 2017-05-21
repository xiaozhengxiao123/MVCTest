//
//  YDRequest.m
//  MVVMTest
//
//  Created by Mr Qian on 2016/12/18.
//  Copyright © 2016年 Mr Qian. All rights reserved.
//

#import "YDRequest.h"
#import "AFNetworking.h"

@implementation YDRequest

//网络请求 单例
+ (YDRequest*)share {
    static YDRequest *g_request = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        g_request = [[YDRequest alloc] init];
    });
    return g_request;
}

//post请求 城市信息接口
- (void)postCityRequest {
    NSString *url = @"http://112.74.108.147:6200/API/city";
    NSDictionary *parameters = @{@"p":@"{\"a\":1,\"b\":1}"};
    
    //http://112.74.108.147:6200/API/city?p={"a":1,"b":1}
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];//创建请求管理者
    manager.responseSerializer = [AFJSONResponseSerializer serializer];//自动解析网络json
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html", @"text/plain", nil];//设置内容类型
    [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        //数据请求的进度...
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //数据请求成功后，返回 responseObject 结果集
        self.rResult(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //数据请求失败，返回错误信息原因 error
        NSLog(@"ERROR: %@", error);
        self.rResult(nil, error);
    }];
}

//post请求 天气预报接口
- (void)postWeatherRequest {
    //这里可以进行天气预报接口的请求
    
}

//post请求 火车票接口
- (void)postRailwayTicketRequest {
    //这里可以火车票接口的请求
}

//下面还可以继续写更多post 或 get 请求
//....

@end
