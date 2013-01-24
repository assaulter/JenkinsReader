//
//  ViewController.m
//  JenkinsReader
//
//  Created by KazukiKubo on 2013/01/22.
//  Copyright (c) 2013年 KazukiKubo. All rights reserved.
//

#import "JenkinsViewController.h"
#import "BuildResultReader.h"

static const float TIMER_INTERVAL = 5.0;

@interface JenkinsViewController () {
    NSTimer* _timer;
    BuildResultReader* _resultReader;
}

@end

@implementation JenkinsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _resultReader = [[BuildResultReader alloc]init];
    self.workSpace = [[NSMutableArray alloc]init];
    self.status = [[NSMutableArray alloc]init];
    [self timerStartWithSelector:@selector(startParse)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/** タイマーの初期化と起動 */
- (void)timerStartWithSelector:(SEL)selector {
    _timer = [NSTimer scheduledTimerWithTimeInterval:TIMER_INTERVAL target:self selector:selector userInfo:nil repeats:YES];
}

/** パースを開始する　 */
- (void)startParse {
    _resultReader.delegate = self;
    [_resultReader startConnectionWithUrl:@"file:///Users/kazukikubo/Downloads/rssLatest.xml"];
}

/** myUrlConnection delegate method */
-(void)didFinishParseWithData:(NSString*)parsedData {
    NSLog(@"parsedData %@", parsedData);
    NSString* data = [[parsedData stringByReplacingOccurrencesOfString:@"安定" withString:@"安定 "]
        stringByReplacingOccurrencesOfString:@"故障" withString:@"故障 "];
    NSArray* phrases = [data componentsSeparatedByString:@" "];
    [self arrayToDictionary:phrases];
}

// ワークスペースと状態の配列にデータを格納する
- (void)arrayToDictionary:(NSArray*)array {
    for (int i = 0; i<[array count]; i++) {
        if (i%3 == 0) { // ワークスペース名が入っている
            [self.workSpace addObject:[array objectAtIndex:i]];
            NSLog(@"workspace %@", [array objectAtIndex:i]);
        } else { // 状態が入っている
            [self.status addObject:[array objectAtIndex:i]];
        }
    }
}

/** 状態をステータスコードに変換するメソッド
 ステータスコード : 1 → 状態が悪くなった
 ステータスコード : 2 → 状態が良くなった
 ステータスコード : 3 → 状態は悪いまま */
- (int)isStatusChanged:(NSArray*)status {
    int code = 0;
    for (NSString* str in status) {
        if ([str isEqualToString:@"安定"]) {
            code = 0;
        } else if ([str isEqualToString:@"このビルドから故障"]) {
            code = 1;
        } else if ([str isEqualToString:@"正常に復帰"]) {
            code = 2;
        } else {
            code = 3;
        }
    }
    return code;
}

@end
