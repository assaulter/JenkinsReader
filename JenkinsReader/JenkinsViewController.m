//
//  ViewController.m
//  JenkinsReader
//
//  Created by KazukiKubo on 2013/01/22.
//  Copyright (c) 2013年 KazukiKubo. All rights reserved.
//

#import "JenkinsViewController.h"
#import "BuildResultReader.h"
#import "ParseResultAnalyser.h"
#import <AVFoundation/AVFoundation.h>

static const float TIMER_INTERVAL = 5.0;

static const int GOOD = 1;
static const int BETTER = 2;
static const int BAD = 3;

@implementation JenkinsViewController {
    NSTimer* _timer;
    BuildResultReader* _resultReader;
    AVAudioPlayer* _failurePlayer;
    AVAudioPlayer* _recoverPlayer;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Parser
    _resultReader = [[BuildResultReader alloc]init];
    // 音を鳴らす準備までしておく
    _failurePlayer =  [self createPlayerWithFilePath:@"doraque_delete"];
    [_failurePlayer prepareToPlay];
    _recoverPlayer = [self createPlayerWithFilePath:@"doraque_levelup"];
    [_recoverPlayer prepareToPlay];
    
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
    // ParseResultAnalyserのクラスメソッドを使うこと
    int status = [ParseResultAnalyser getAppStatusFromParsedData:parsedData];
    // 音を鳴らす(現状コケた時だけ)
    if (status == BAD) {
        [_failurePlayer play];
    } else if (status == BETTER) {
        [_recoverPlayer play];
    }
}

// ファイルのurlをセットしたAVAudioPlayerを返すメソッド
- (AVAudioPlayer*)createPlayerWithFilePath:(NSString*)path {
    NSString* soundPath = [[NSBundle mainBundle]pathForResource:path ofType:@"mp3"];
    NSURL* fileUrl = [[NSURL alloc]initFileURLWithPath:soundPath];
    
    return [[AVAudioPlayer alloc]initWithContentsOfURL:fileUrl error:nil];;
}

@end
