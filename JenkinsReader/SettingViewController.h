//
//  ViewController.h
//  PickerViewSample
//
//  Created by KazukiKubo on 2013/02/07.
//  Copyright (c) 2013年 KazukiKubo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>

// pickerViewからの値を表示させたいので、IBOutletとして持つ必要がある
@property (strong, nonatomic) IBOutlet UILabel* time;
@property (strong, nonatomic) IBOutlet UIPickerView* pickerView;

// startボタンを押した時の動作
-(IBAction)buttonPushed:(id)sender;
// url入力fieldでreturnキーを押した時の動作
-(IBAction)didEndOnExit:(UITextField*)sender;

@end
