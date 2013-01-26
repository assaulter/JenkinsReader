//
//  main.m
//  GHUnit
//
//  Created by KazukiKubo on 2013/01/26.
//  Copyright (c) 2013年 KazukiKubo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GHUnitIOS/GHUnitIOSViewController.h>

int main(int argc, char* argv[]) {
	@autoreleasepool {
		int retVal;
		if(getenv("GHUNIT_CLI")) {
			retVal = [GHTestRunner run];
		} else {
			retVal = UIApplicationMain(argc, argv, nil, @"GHUnitIOSAppDelegate");
		}
	}
}