//
//  MyUrlConnection.h
//  NSXmlSample
//
//  Created by KazukiKubo on 2013/01/14.
//  Copyright (c) 2013年 KazukiKubo. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BuildResultReaderDelegate <NSObject>
-(void)didFinishParseWithData:(NSArray*)parsedData;
@end

@interface BuildResultReader : NSObject<NSXMLParserDelegate>

- (void)startConnection;
- (void)startConnectionWithUrl:(NSString*)url;

@property (nonatomic,assign) id<BuildResultReaderDelegate> delegate;

@end