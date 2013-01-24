//
//  MyUrlConnection.h
//  NSXmlSample
//
//  Created by KazukiKubo on 2013/01/14.
//  Copyright (c) 2013年 KazukiKubo. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BuildResultReaderDelegate <NSObject>
-(void)didFinishParseWithData:(NSString*)parsedData;
@end

@interface BuildResultReader : NSObject<NSXMLParserDelegate>

- (void)startConnectionWithUrl:(NSString*)url;

@property (nonatomic,assign) id<BuildResultReaderDelegate> delegate;

@end