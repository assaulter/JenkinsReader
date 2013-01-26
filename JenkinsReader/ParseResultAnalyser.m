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

@end
