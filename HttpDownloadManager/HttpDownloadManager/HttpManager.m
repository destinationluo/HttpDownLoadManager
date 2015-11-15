//
//  HttpManager.m
//  半旅
//
//  Created by Angel on 15/11/2.
//  Copyright © 2015年 lq. All rights reserved.
//

#import "HttpManager.h"

@implementation HttpManager

+(HttpManager *)shareManager{
    static HttpManager *manager=nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        if (manager==nil) {
            manager=[[HttpManager alloc]init];
        }
    });
    return manager;
}

-(void)requestGetWithUrl:(NSString *)urlString withDictionary:(NSDictionary *)dic withSuccessBlock:(SuccessBlock)sucBlock withFailureBlock:(FailureBlock)failureBlock{
    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json",@"text/html",nil];
    [manager GET:urlString parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
         NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        sucBlock(dict);
        
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
- (void)requestPostWithUrl:(NSString *)urlString withDictionary:(NSDictionary *)dic withSuccessBlock:(SuccessBlock)sucBlock withFailureBlock:(FailureBlock)failureBlock
{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes  = [NSSet setWithObjects:@"application/json",@"text/html", nil];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        sucBlock(dict);
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
    }];
}


-(void)cancelAllRequest{
    AFHTTPSessionManager *manager= [AFHTTPSessionManager manager];
    //manager.operationQueue 拿到管理AFNetWorking请求的队列
    //manager.operationQueue.operationCount 拿到亲求队列中请求的数量
    if (manager.operationQueue.operationCount>0) {
        //取消队列中所有请求
        [manager.operationQueue cancelAllOperations];
    }
    
}

@end






