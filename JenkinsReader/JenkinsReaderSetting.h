//
//  JenkinsReaderSetting.h
//  JenkinsReader
//
//  Created by KazukiKubo on 2013/02/07.
//  Copyright (c) 2013年 KazukiKubo. All rights reserved.
//

#import <Foundation/Foundation.h>

// JenkinsReaderの設定を保持するクラス
@interface JenkinsReaderSetting : NSObject

// ポーリング対象のurl
@property (strong, nonatomic) NSString* url;
// ポーリングの間隔
@property (strong, nonatomic) NSNumber* interval;

@end
