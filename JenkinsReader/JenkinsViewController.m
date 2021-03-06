//
//  ViewController.m
//  JenkinsReader
//
//  Created by KazukiKubo on 2013/01/22.
//  Copyright (c) 2013年 KazukiKubo. All rights reserved.
//

#import "JenkinsViewController.h"
#import "BuildResultReader.h"
#import <AVFoundation/AVFoundation.h>

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
    NSLog(@"hogehoge");
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_timer invalidate];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/** タイマーの初期化と起動 */
- (void)timerStartWithSelector:(SEL)selector {
    _timer = [NSTimer scheduledTimerWithTimeInterval:[self.settings.interval doubleValue] target:self selector:selector userInfo:nil repeats:YES];
}

/** パースを開始する　 */
- (void)startParse {
    _resultReader.delegate = self;
    [_resultReader startConnectionWithUrl:self.settings.url];
}

/** myUrlConnection delegate method
    XMLParseが終わったら呼ばれる */
-(void)didFinishParseWithAppStatus:(int)status {
    NSLog(@"status : %d", status);
    // 音を鳴らす
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
