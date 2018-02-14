//
//  ViewController.m
//  Network
//
//  Created by luochaojing on 2018/2/14.
//  Copyright © 2018年 luochaojing. All rights reserved.
//

#import "ViewController.h"

#import <AFNetworking.h>
#import "Masonry.h"
#import "TXDownloadPool.h"

@interface ViewController ()


@property (strong, nonatomic) UIButton *startBtn;

@property (strong, nonatomic) UIProgressView *progressView;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self comInit];
}

- (void)comInit {
    self.startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.startBtn setBackgroundColor:[UIColor grayColor]];
    [self.startBtn setTitle:@"开始" forState:UIControlStateNormal];
    [self.startBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.startBtn addTarget:self action:@selector(startDownload:) forControlEvents:UIControlEventTouchUpInside];
    
    self.progressView = [[UIProgressView alloc] init];
    self.progressView.backgroundColor = [UIColor grayColor];
    self.progressView.progress = 0.0;
    
    [self.view addSubview:self.startBtn];
    [self.view addSubview:self.progressView];
    
    [self.startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(100);
        make.width.equalTo(@100);
        make.height.equalTo(@40);
        make.centerX.equalTo(self.view);
    }];
    
    
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(50);
        make.right.equalTo(self.view).offset(-50);
        make.height.equalTo(@20);
        make.top.equalTo(self.startBtn.mas_bottom).offset(40);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)startDownload:(id)sender {
    
    NSString *downloadURL = @"https://static.tigerbrokers.com/desktop/download/Tiger_Trade_latest.dmg";
    
    NSString *localPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 要检查的文件目录
    NSString *filePath = [localPath  stringByAppendingPathComponent:@"Tiger_Trade_latest.dmg"];
    NSURL *fileUrl = [NSURL fileURLWithPath:filePath isDirectory:NO];
    
    [[TXDownloadPool shared] AFDownLoadFileWithUrl:downloadURL progress:^(CGFloat progress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.progressView.progress = progress;
            
            if (progress >= 0.1) {
                NSString *s = nil;
                NSMutableArray *arr = @[].mutableCopy;
                [arr addObject:s];
            }
            
        });
        
    } fileLocalUrl:fileUrl success:^(NSURL *fileUrlPath, NSURLResponse *response) {
        NSLog(@"成功");
        
    } failure:^(NSError *error, NSInteger statusCode) {
        NSLog(@"失败");
    }];
}


@end
