//
//  YDImageView.m
//  YIDaDemo
//
//  Created by Mr Qian on 16/2/26.
//  Copyright © 2016年 Mr Qian. All rights reserved.
//

#import "YDImageView.h"

#define Cache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"CacheImage"] //定义图片缓存路径
#define FM [NSFileManager defaultManager] //定义文件管理单例

@implementation YDImageView

/**
 @功能：根据URL获取网络图片
 @参数：图片url  默认显示图片
 @返回值：空
 */
- (void)yidaImageURL:(NSString*)strURL placeholderImage:(UIImage*)placeholderImage {
    self.image = placeholderImage;//默认图片
    self.imageURL = strURL;//保存URL
    NSString *imagePath = [self filePath:strURL];//获取本地图片完整路径
    if ([FM fileExistsAtPath:imagePath] == YES) {//本地存在，则显示本地的
        self.image = [UIImage imageWithContentsOfFile:imagePath];
    } else {//否则，进行网络请求
        [self indicaorView:YES];//显示等待视图
        __weak YDImageView *weakSelf = self;//防止循环引用
        NSURL *url = [NSURL URLWithString:[strURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
        NSURLSessionDownloadTask *downloadTask = [[NSURLSession sharedSession] downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
            if (!error) {
                //location是沙盒中tmp文件夹下的一个临时url,文件下载后会存到这个位置,
                //由于tmp中的文件随时可能被删除,所以我们需要自己需要把下载的文件挪到需要的地方
                [FM removeItemAtPath:imagePath error:nil];//如果有，则先移旧的
                [FM moveItemAtURL:location toURL:[NSURL fileURLWithPath:imagePath] error:nil];
                dispatch_async(dispatch_get_main_queue(), ^{//主线程显示
                    [weakSelf indicaorView:NO];//停止等待视图
                    weakSelf.image = [UIImage imageWithContentsOfFile:imagePath];
                });
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{//主线程显示
                    [weakSelf indicaorView:NO];//停止等待视图
                });
            }
        }];
        [downloadTask resume];//启动任务(或恢复任务)
    }
}

//清理指定图片的缓存
- (void)clearCache {
    self.image = [UIImage imageNamed:@"default"];//恢复默认图片
    NSString *filePath = [self filePath:self.imageURL];
    BOOL directory = NO;
    if (filePath && [FM fileExistsAtPath:filePath isDirectory:&directory]) {
        [FM removeItemAtPath:filePath error:nil];//删除图片
    }
}

//清理所有的图片缓存
+ (void)clearAllCaches {
    [FM removeItemAtPath:Cache error:nil];
}

/**
 @功能：显示或者等待视图
 @参数：是否显示（YES表示显示，NO表示不显示)
 @返回值：空
 */
- (void)indicaorView:(BOOL)show {
    if (show) {
        UIActivityIndicatorView *acView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((self.bounds.size.width-20)/2, (self.bounds.size.height-20)/2, 20, 20)];
        acView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        acView.tag = 6666;
        [self addSubview:acView];
        [self bringSubviewToFront:acView];
        [acView startAnimating];
    } else {
        UIActivityIndicatorView *aView = [self viewWithTag:6666];
        [aView stopAnimating];
        [aView removeFromSuperview];
        aView = nil;
    }
}

//获取图片完整缓存路径
- (NSString*)filePath:(NSString*)url {
    NSString *fPath = nil; //图片完整路径
    if ([url hasPrefix:@"http"]) {//验证是否是一张网络图片
        NSArray *ary = [url componentsSeparatedByString:@"/"];
        NSString *fileName = [ary lastObject];
        
        NSFileManager *fileManage = [NSFileManager defaultManager];
        BOOL directory = YES;
        if (![fileManage fileExistsAtPath:Cache isDirectory:&directory]) {
            [fileManage createDirectoryAtPath:Cache //创建一个图片文件夹
                  withIntermediateDirectories:NO
                                   attributes:nil
                                        error:nil];
        }
        
        fPath = [Cache stringByAppendingPathComponent:fileName];
    }
    return fPath;//返回图片完整路径
}

@end
