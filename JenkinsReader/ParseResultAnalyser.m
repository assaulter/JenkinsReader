//
//  ParseResultAnalyser.m
//  JenkinsReader
//
//  Created by KazukiKubo on 2013/01/26.
//  Copyright (c) 2013年 KazukiKubo. All rights reserved.
//

#import "ParseResultAnalyser.h"
#import "BuildInfo.h"

@implementation ParseResultAnalyser

//+ (NSArray*)convertDataToArray:(NSString*)data {
//    NSString* result = [[data stringByReplacingOccurrencesOfString:@"(" withString:@""] stringByReplacingOccurrencesOfString:@")" withString:@" "];
//    return [result componentsSeparatedByString:@" "];
//}

// buildInfoが入った配列を返す
//- (NSArray*)arrayToDictionary:(NSArray*)array {
//    NSMutableArray* result = [[NSMutableArray alloc]initWithCapacity:[array count]];
//    int i = 0;
//    while ([[array objectAtIndex:i]length] != 0) {
//        BuildInfo* info = [BuildInfo new];
//        if (i%3 == 0) { // ワークスペース名が入っている
//            info.workSpaceName = [array objectAtIndex:i];
//        } else if (i%3 == 1){ // ビルドナンバーが入っている
//            info.buildNumber = [array objectAtIndex:i];
//        } else { // 状態が入っている
//            info.status = [array objectAtIndex:i];
//        }
//        [result addObject:info];
//        i++;
//    }
//    return result;
//}

@end
