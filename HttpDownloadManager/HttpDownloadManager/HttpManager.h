//
//  HttpManager.h
//  半旅
//
//  Created by Angel on 15/11/2.
//  Copyright © 2015年 lq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"


typedef void(^SuccessBlock)(NSDictionary * dict);
typedef void(^FailureBlock)(NSError *error);

@interface HttpManager : NSObject
+(HttpManager *)shareManager;

-(void)requestGetWithUrl:(NSString *)urlString withDictionary:(NSDictionary *)dic withSuccessBlock:(SuccessBlock)sucBlock withFailureBlock:(FailureBlock)failureBlock;

-(void)requestPostWithUrl:(NSString *)urlString withDictionary:(NSDictionary *)dic withSuccessBlock:(SuccessBlock)sucBlock withFailureBlock:(FailureBlock)failureBlock;
-(void)cancelAllRequest;

@end
