//
//  ViewController.m
//  PickerViewSample
//
//  Created by KazukiKubo on 2013/02/07.
//  Copyright (c) 2013年 KazukiKubo. All rights reserved.
//

#import "SettingViewController.h"
#import "JenkinsViewController.h"
#import "JenkinsReaderSetting.h"

@interface SettingViewController () {
    NSArray* _times;
    JenkinsReaderSetting* setting;
}

@end

@implementation SettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    setting = [JenkinsReaderSetting new];
	// Do any additional setup after loading the view, typically from a nib.
    _times = [NSArray arrayWithObjects:[NSNumber numberWithInt:15], [NSNumber numberWithInt:30], [NSNumber numberWithInt:45], [NSNumber numberWithInt:60], [NSNumber numberWithInt:90], [NSNumber numberWithInt:120],nil];
    // 初期値
    setting.interval = [NSNumber numberWithInt:15];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UIButton
-(IBAction)buttonPushed:(id)sender {
    // 設定を保持するクラスを作ってそれに保持。
    // JenkinsReaderクラスに値を渡してポーリングスタート
    if ([setting.url length] == 0 ) {
        // url入れてください。
        return;
    }
    JenkinsViewController* jenkinsViewController = [[JenkinsViewController alloc]initWithNibName:@"JenkinsViewController" bundle:nil];
    // 設定を渡す
    jenkinsViewController.settings = setting;
    [self.navigationController pushViewController:jenkinsViewController animated:YES];
}
#pragma mark - UITextField
-(IBAction)didEndOnExit:(UITextField*)sender {
    setting.url = sender.text;
}

#pragma mark - UIPicherView
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{    
    setting.interval = [_times objectAtIndex:row];

    self.time.text = [NSString stringWithFormat:@"%d", [setting.interval intValue]];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    //componentの数
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    int numOfRows;
    //１つめのcomponentのデータ数
    numOfRows = _times.count;

    return numOfRows;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    //表示文字列を返す
    NSString *titleForRow;
    titleForRow = [[_times objectAtIndex:row] stringValue];

    return titleForRow;
}

@end
