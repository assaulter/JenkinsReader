//
//  MyUrlConnection.m
//  NSXmlSample
//
//  Created by KazukiKubo on 2013/01/14.
//  Copyright (c) 2013年 KazukiKubo. All rights reserved.
//

#import "BuildResultReader.h"

@interface BuildResultReader() {
    NSMutableData* dataBuffer;
    BOOL isElement;
    NSMutableArray* elementBuffer;
}

@end

@implementation BuildResultReader


- (id)init {
    self = [super init];
    if (self) {
        dataBuffer = [[NSMutableData alloc]initWithCapacity:0];
        elementBuffer = [[NSMutableArray alloc]initWithCapacity:0];
    }
    NSLog(@"MyUrlConnection is initted");
    return self;
}

- (void)startConnectionWithUrl:(NSString*)url {
    NSURL *nsurl = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:nsurl];
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
    [connection start];
}

- (void)startConnection {
    NSString *urlstring = @"http://sinri.net/feed/atom";
    NSURL *url = [NSURL URLWithString:urlstring];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
    [connection start];
}

// レスポンスを受け取った時点で呼び出される。データ受信よりも前
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
}

// データを受け取る度に呼び出される
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSLog(@"did receive data %@", [[NSString alloc]initWithData:data encoding:NSStringEncodingConversionAllowLossy]);
    
    // バッファにデータを貯める
    [dataBuffer appendData:data];
    
//    NSXMLParser* parser = [[NSXMLParser alloc]initWithData:data];
//    [parser setDelegate:self];
//    [parser parse];
}

// データを全て受け取ると呼び出される
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSXMLParser* parser = [[NSXMLParser alloc]initWithData:dataBuffer];
    [parser setDelegate:self];
    [parser parse];
}

// XMLのパース開始
- (void)parserDidStartDocument:(NSXMLParser *)parser {
	// element フラグを初期化（NO に設定）
    isElement = NO;
    NSLog(@"start document");
}

// 要素の開始タグを読み込み
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
	// element があるかどうかチェック
    if ([elementName isEqualToString:@"title"]) {
		// element フラグを YES に設定
		isElement = YES;
		// 要素の値を入れる領域を初期化する
	}
}

// 要素の値を読み込み
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	// element フラグが YES かどうかチェック
	if (isElement) {
		// 要素の値を elementBuffer へ追加
		[elementBuffer addObject:string];
	}
}

// 要素の閉じタグを読み込み
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	// element フラグが YES かどうかチェック
	if (isElement) {
		// element フラグを NO に設定
		isElement = NO;
	}
}

// XML のパース終了
- (void)parserDidEndDocument:(NSXMLParser *)parser {
    [self.delegate didFinishParseWithData:elementBuffer];
    NSLog(@"element buffer count : %d", [elementBuffer count]);
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
