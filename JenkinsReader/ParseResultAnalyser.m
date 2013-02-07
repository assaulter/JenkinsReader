//
//  ParseResultAnalyser.m
//  JenkinsReader
//
//  Created by KazukiKubo on 2013/01/26.
//  Copyright (c) 2013年 KazukiKubo. All rights reserved.
//

#import "ParseResultAnalyser.h"
#import "BuildInfo.h"

static const int GOOD = 1;
static const int BETTER = 2;
static const int BAD = 3;

@implementation ParseResultAnalyser

// 下3つのメソッドを使い、parserから取得した文字列から、アプリのステータスを返却する
+ (int)getAppStatusFromParsedData:(NSString*)data {
   return [self getAppStatus:[self arrayToBuildInfo:[self convertDataToArray:data]]];
}

+ (NSArray*)convertDataToArray:(NSString*)data {
    NSString* result = [[data stringByReplacingOccurrencesOfString:@"(" withString:@""] stringByReplacingOccurrencesOfString:@")" withString:@" "];
    return [result componentsSeparatedByString:@" "];
}

// buildInfoが入った配列を返す
+ (NSArray*)arrayToBuildInfo:(NSArray*)array {
    NSMutableArray* result = [[NSMutableArray alloc]initWithCapacity:[array count]];
    int i = 0;
    while ([[array objectAtIndex:i]length] != 0) {
        if (i%3 == 0) { // ワークスペース名が入っている
            BuildInfo* info = [BuildInfo new];
            info.workSpaceName = [array objectAtIndex:i];
            info.buildNumber = [array objectAtIndex:i+1];
            info.status = [array objectAtIndex:i+2];
            [result addObject:info];
        }
        i++;
    }
    return result;
}

/** アプリとして状態はどうなのかを返す。
 @param data : BuildInfoの配列
 一つでも悪いのがあったら → bad
 状態が悪いまま → bad
 --------------------------------
 状態が良くなったものがあったら → better (安定 + 正常に復帰)
 安定 → good (All 安定)
 の三種類に分類する
 */
+ (int)getAppStatus:(NSArray*)data {
    int appStatus = GOOD; // 初期状態。なんもなかったらコレを返す
    for (BuildInfo* info in data) {
        if ([info.status hasSuffix:@"故障"] || [info.status hasSuffix:@"失敗"]) {
            appStatus = BAD;
            break;
        } else if ([info.status hasSuffix:@"復帰"]) {
            appStatus = BETTER;
        }
    }
    return appStatus;
}

@end
