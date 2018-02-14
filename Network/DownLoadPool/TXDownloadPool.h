//
//  TXDownloadPool.h
//  Network
//
//  Created by luochaojing on 2018/2/14.
//  Copyright © 2018年 luochaojing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AFURLSessionManager.h>

typedef void (^DonwLoadSuccessBlock)(NSURL *fileUrlPath ,NSURLResponse *  response );
typedef void (^DownLoadfailBlock)(NSError*  error ,NSInteger statusCode);
typedef void (^DowningProgress)(CGFloat progress);


@interface TXDownloadPool : NSObject


@property (nonatomic, strong) AFURLSessionManager *manager;
@property (nonatomic, strong) NSMutableDictionary *downLoadHistoryDictionary;


+ (instancetype)shared;

/**
 文件下载
 @param urlHost 下载地址
 @param progress 下载进度
 @param localUrl 本地存储路径
 @param success 下载成功
 @param failure 下载失败
 @return downLoadTask
 */
- (NSURLSessionDownloadTask  *)AFDownLoadFileWithUrl:(NSString*)urlHost
                                            progress:(DowningProgress)progress
                                        fileLocalUrl:(NSURL *)localUrl
                                             success:(DonwLoadSuccessBlock)success
                                             failure:(DownLoadfailBlock)failure;

/** 停止所有的下载任务*/
- (void)stopAllDownLoadTasks;





@end
