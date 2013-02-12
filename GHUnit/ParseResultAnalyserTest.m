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

- (void)testGetAppStatus {
    BuildInfo* info1 = [BuildInfo new];
    info1.status = @"安定";
    BuildInfo* info2 = [BuildInfo new];
    info2.status = @"正常に復帰";
    BuildInfo* info3 = [BuildInfo new];
    info3.status = @"ビルド#xxから故障";
    BuildInfo* info4 = [BuildInfo new];
    info4.status = @"このビルドから故障";
    
    // すべて安定している場合
    NSArray* data = [[NSArray alloc]initWithObjects:info1, info1, nil];
    int result = [ParseResultAnalyser getAppStatus:data];
    GHAssertEquals(result, GOOD, @"すべて安定の場合はGOOD");
    
    // 安定 + 復帰の場合
    data = [[NSArray alloc]initWithObjects:info1, info2, nil];
    result = [ParseResultAnalyser getAppStatus:data];
    GHAssertEquals(result, BETTER, @"安定 + 復帰の場合は BETTER");
    
    // 安定 + 復帰 + 故障の場合(継続的故障も、このビルドから故障も同列にみなす)
    data = [[NSArray alloc]initWithObjects:info1, info2, info3, info4, nil];
    result = [ParseResultAnalyser getAppStatus:data];
    GHAssertEquals(result, BAD, @"故障が含まれる場合は、強制的にBAD");
}

- (void)testFail {
    GHAssertEquals(1, 2, @"test failed");
}

@end
