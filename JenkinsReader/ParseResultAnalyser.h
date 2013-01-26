//
//  ParseResultAnalyser.h
//  JenkinsReader
//
//  Created by KazukiKubo on 2013/01/26.
//  Copyright (c) 2013年 KazukiKubo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParseResultAnalyser : NSObject

// 余計な文字を削除して配列に変換する
+ (NSArray*)convertDataToArray:(NSString*)data;
// 変換した結果から、BuildInfoの配列を作成する
+ (NSArray*)arrayToBuildInfo:(NSArray*)array;
// BuildInfoの配列から、アプリとしてのステータスを決定する
+ (int)getAppStatus:(NSArray*)data;


@end
