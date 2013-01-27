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
    // ParseResultAnalyserのクラスメソッドを使うこと
    NSLog(@"app status %d" ,[ParseResultAnalyser getAppStatusFromParsedData:parsedData]);
}

@end
