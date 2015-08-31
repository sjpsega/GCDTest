//
//  GCDTestTests.m
//  GCDTestTests
//
//  Created by sjpsega on 15/8/27.
//  Copyright (c) 2015年 sjpsega. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "GCDTestCase.h"

@implementation GCDTestCase

- (void)setUp {
    [super setUp];
    [Expecta setAsynchronousTestTimeout:5.0];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

@end
