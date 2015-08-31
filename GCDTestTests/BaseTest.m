//
//  BaseTest.m
//  GCDTest
//
//  Created by sjpsega on 15/8/27.
//  Copyright (c) 2015年 sjpsega. All rights reserved.
//

#import "GCDTestCase.h"

@interface BaseTest : GCDTestCase

@end

@implementation BaseTest

- (void)testSync{
    __block BOOL isDone = NO;
    //同步操作不能在主线程（串行队列）上执行，否则会线程死锁
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"log 1");
        isDone = YES;
    });
    NSLog(@"log 2");
    expect(isDone).will.beTruthy();
}

- (void)testAsync{
    __block BOOL isDone = NO;
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"log 1");
        isDone = YES;
    });
    NSLog(@"log 2");
    expect(isDone).will.beTruthy();
}

- (void)testAfter{
    __block BOOL isDone = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"log 1");
        isDone = YES;
    });
    NSLog(@"log 2");
    expect(isDone).will.beTruthy();
}

- (void)testOnce{
    static dispatch_once_t onceToken;
    __block int count = 0;
    dispatch_once(&onceToken, ^{
        count++;
        NSLog(@"log 1");
    });
    dispatch_once(&onceToken, ^{
        count++;
        NSLog(@"log 2");
    });
    dispatch_once(&onceToken, ^{
        count++;
        NSLog(@"log 3");
    });
    expect(count).after(3).equal(1);
}
@end
