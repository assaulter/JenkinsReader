//
//  BuildInfo.h
//  JenkinsReader
//
//  Created by KazukiKubo on 2013/01/25.
//  Copyright (c) 2013年 KazukiKubo. All rights reserved.
//

#import <Foundation/Foundation.h>
/** 特定のワークスペースの状態を保持するクラス */
@interface BuildInfo : NSObject

@property (nonatomic, retain) NSString* workSpaceName;
@property (nonatomic, retain) NSString* buildNumber;
@property (nonatomic, retain) NSString* status;

@end
