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

static const int GOOD = 1;
static const int BETTER = 2;
static const int BAD = 3;

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
    self.data = [[NSMutableArray alloc]init];
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

/** myUrlConnection delegate method
    XMLParserのfinishがトリガー */
-(void)didFinishParseWithData:(NSString*)parsedData {
    NSLog(@"parsedData %@", parsedData);
    NSString* data = [[parsedData stringByReplacingOccurrencesOfString:@"(" withString:@""] stringByReplacingOccurrencesOfString:@")" withString:@" "];
    NSArray* phrases = [data componentsSeparatedByString:@" "];
    
    [self arrayToDictionary:phrases];
    // アプリの状態を取得する
    
}

// 配列にデータ(BuildInfo型)を格納する
- (void)arrayToDictionary:(NSArray*)array {
    int i = 0;
    while ([[array objectAtIndex:i]length] != 0) {
        BuildInfo* info = [BuildInfo new];
        if (i%3 == 0) { // ワークスペース名が入っている
            info.workSpaceName = [array objectAtIndex:i];
        } else if (i%3 == 1){ // ビルドナンバーが入っている
            info.buildNumber = [array objectAtIndex:i];
        } else { // 状態が入っている
            info.status = [array objectAtIndex:i];
        }
        [self.data addObject:info];
        i++;
    }
}

/** アプリとして状態はどうなのかを返す。
    つまり：self.dataを見て、
    一つでも悪いのがあったら → bad
    状態が悪いまま → bad
    --------------------------------
    状態が良くなったものがあったら → better (安定 + 正常に復帰)
    安定 → good (All 安定)
    の三種類に分類する
 */
- (int)getAppStatus {
    int appStatus = GOOD; // 初期状態。なんもなかったらコレを返す
    for (BuildInfo* info in self.data) {
        if ([info.status hasSuffix:@"故障"]) {
            appStatus = BAD;
            break;
        } else if ([info.status hasSuffix:@"復帰"]) {
            appStatus = BETTER;
        }
    }
    return appStatus;
}

@end
