//
//  ViewController.h
//  JenkinsReader
//
//  Created by KazukiKubo on 2013/01/22.
//  Copyright (c) 2013年 KazukiKubo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BuildResultReader.h"

@interface JenkinsViewController : UIViewController<BuildResultReaderDelegate>

@property (nonatomic,retain) NSMutableArray* workSpace;
@property (nonatomic,retain) NSMutableArray* status;

@end
