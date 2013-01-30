//
//  MyUrlConnection.m
//  NSXmlSample
//
//  Created by KazukiKubo on 2013/01/14.
//  Copyright (c) 2013年 KazukiKubo. All rights reserved.
//

#import "BuildResultReader.h"
#import "ParseResultAnalyser.h"

@implementation BuildResultReader {
    NSMutableString* parsedData;
    NSMutableData* dataBuffer;
    BOOL isEntry, isTitle;
}

- (id)init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)startConnectionWithUrl:(NSString*)url {
    // データ保存領域の初期化
    parsedData = [[NSMutableString alloc]init];
    dataBuffer = [[NSMutableData alloc]initWithCapacity:0];
    // 通信準備および開始
    NSURL *nsurl = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:nsurl];
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
    [connection start];
}

// レスポンスを受け取った時点で呼び出される。データ受信よりも前
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
}

// データを受け取る度に呼び出される
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // バッファにデータを貯める
    [dataBuffer appendData:data];
}

// データを全て受け取ると呼び出される
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSXMLParser* parser = [[NSXMLParser alloc]initWithData:dataBuffer];
    [parser setDelegate:self];
    [parser parse];
}

/** ここから、xmlParserの実装 */
- (void)parserDidStartDocument:(NSXMLParser *)parser {
	// element フラグを初期化（NO に設定）
    isEntry = NO;
    isTitle = NO;
}

// 要素の開始タグを読み込み
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
	// element があるかどうかチェック
    if ([elementName isEqualToString:@"entry"]) {
		// element フラグを YES に設定
		isEntry = YES;
	}
    if ([elementName isEqualToString:@"title"]) {
        isTitle = YES;
    }
}

// 要素の値を読み込み(複数回に渡って実行される可能性がある)
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	// element フラグが YES かどうかチェック
	if (isEntry && isTitle) {
		// 要素の値を elementBuffer へ追加
        [parsedData appendString:string];
	}
}

// 要素の閉じタグを読み込み
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	// element フラグが YES かどうかチェック
	if ([elementName isEqualToString:@"entry"]) {
		// element フラグを NO に設定
		isEntry = NO;
	}
    if ([elementName isEqualToString:@"title"]) {
        isTitle = NO;
    }
}

// XML のパース終了
- (void)parserDidEndDocument:(NSXMLParser *)parser {
    int appStatus = [ParseResultAnalyser getAppStatusFromParsedData:parsedData];
    [self.delegate didFinishParseWithAppStatus:appStatus];
}

- (void)parser:(NSXMLParser *)parser
parseErrorOccurred:(NSError *)parseError {
    // エラーの内容を出力
	NSLog(@"Error: %i, Column: %i, Line: %i, Description: %@",
          [parseError code],
          [parser columnNumber],
          [parser lineNumber],
          [parseError description]);
}

@end
