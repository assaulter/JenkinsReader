//
//  ParseResultAnalyserTest.m
//  JenkinsReader
//
//  Created by KazukiKubo on 2013/01/25.
//  Copyright (c) 2013年 KazukiKubo. All rights reserved.
//

#import "ParseResultAnalyserTest.h"
#import "BuildInfo.h"

@implementation ParseResultAnalyserTest

- (void)setUpClass {
    self.testData = @"AluuubumbumBuild #183 (安定)AluuubumbumTest #111 (このビルドから故障)AluuubumbumTest2 #111 (ビルド#100から故障)AluuubumbumTest3 #111 (正常に復帰)";
    self.dataArray = [[NSArray alloc]initWithObjects:@"AluuubumbumBuild",  @"#183", @"安定", @"AluuubumbumTest", @"#111", @"このビルドから故障", @"AluuubumbumTest2", @"#111", @"ビルド#100から故障", @"AluuubumbumTest3", @"#111", @"正常に復帰", @"", nil];
}

- (void)testConvertDataToArray {
    NSArray* result = [ParseResultAnalyser convertDataToArray:self.testData];

    GHAssertEqualObjects(result, self.dataArray, @"こんなかんじにパースされる");
}

- (void)testArrayToBuildInfo {
    NSArray* result = [ParseResultAnalyser arrayToBuildInfo:self.dataArray];
    GHAssertEquals((int)[result count], 4, @"ワークスペースは４つ");
    
    BuildInfo* info = [BuildInfo new];
    // 1 ~ 4までのワークスペースについて確認する。
    for (int i=0; i<4; i++) {
        info = [result objectAtIndex:i];
        
        GHAssertEqualStrings(info.workSpaceName, [self.dataArray objectAtIndex:(3*i)], @"workspace Name");
        GHAssertEqualStrings(info.buildNumber, [self.dataArray objectAtIndex:(3*i)+1], @"build number");
        GHAssertEqualStrings(info.status, [self.dataArray objectAtIndex:(3*i)+2], @"build status");
    }
}

@end
