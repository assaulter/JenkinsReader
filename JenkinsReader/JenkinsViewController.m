//
//  ViewController.m
//  JenkinsReader
//
//  Created by KazukiKubo on 2013/01/22.
//  Copyright (c) 2013年 KazukiKubo. All rights reserved.
//

#import "JenkinsViewController.h"
#import "BuildResultReader.h"

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
    [self timerStartWithSelector:@selector(startParse)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/** タイマーの初期化と起動 */
- (void)timerStartWithSelector:(SEL)selector {
    _timer = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:selector userInfo:nil repeats:YES];
}

/** パースを開始する　 */
- (void)startParse {
    _resultReader.delegate = self;
    [_resultReader startConnectionWithUrl:@"http://sinri.net/feed/atom"];
}

/** myUrlConnection delegate method */
-(void)didFinishParseWithData:(NSArray*)parsedData {
    NSLog(@"finish parse %@", [parsedData objectAtIndex:0]);
}

@end
