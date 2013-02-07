//
//  ViewController.h
//  JenkinsReader
//
//  Created by KazukiKubo on 2013/01/22.
//  Copyright (c) 2013年 KazukiKubo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BuildResultReader.h"
#import "BuildInfo.h"
#import "JenkinsReaderSetting.h"

@interface JenkinsViewController : UIViewController<BuildResultReaderDelegate>

@property (strong, nonatomic) JenkinsReaderSetting* settings;

@end
