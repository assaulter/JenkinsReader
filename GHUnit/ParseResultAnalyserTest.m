//
//  ParseResultAnalyserTest.m
//  JenkinsReader
//
//  Created by KazukiKubo on 2013/01/25.
//  Copyright (c) 2013年 KazukiKubo. All rights reserved.
//

#import "ParseResultAnalyserTest.h"

@implementation ParseResultAnalyserTest

- (void)setUpClass {
    self.testData = @"AluuubumbumBuild #183 (安定)AluuubumbumTest #111 (このビルドから故障)AluuubumbumTest2 #111 (ビルド#100から故障)AluuubumbumTest3 #111 (正常に復帰)";
}

// 変換した結果から、BuildInfoの配列を作成する
//+ (NSArray*)arrayToDictionary:(NSArray*)array;

//- (void)testConvertDataToArray {
//    NSArray* result = [ParseResultAnalyser convertDataToArray:self.testData];
//    NSArray* ex = [[NSArray alloc]initWithObjects:@"AluuubumbumBuild",  @"#183", @"安定", @"AluuubumbumTest", @"#111", @"このビルドから故障", @"AluuubumbumTest2", @"#111", @"ビルド#100から故障", @"AluuubumbumTest3", @"#111", @"正常に復帰", @"", nil];
//    GHAssertEqualObjects(result, ex, @"こんなかんじにパースされる");
//}

@end
