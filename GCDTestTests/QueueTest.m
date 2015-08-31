//
//  QueueTest.m
//  GCDTest
//
//  Created by sjpsega on 15/8/28.
//  Copyright (c) 2015年 sjpsega. All rights reserved.
//

#import "GCDTestCase.h"

@interface QueueTest : GCDTestCase

@end

@implementation QueueTest

//自定义并发队列
- (void)testConcurrent {
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.sjpsega", DISPATCH_QUEUE_CONCURRENT);

    __block int count = 0;
    dispatch_group_async(group, concurrentQueue, ^{
        NSLog(@"1");
        count++;
    });
    dispatch_group_async(group, concurrentQueue, ^{
        NSLog(@"2");
        count++;
    });
    dispatch_group_async(group, concurrentQueue, ^{
        NSLog(@"3");
        count++;
    });
    dispatch_group_async(group, concurrentQueue, ^{
        NSLog(@"4");
        count++;
    });
    dispatch_group_async(group, concurrentQueue, ^{
        NSLog(@"5");
        count++;
    });
    expect(count).will.equal(5);
}

//自定义串行队列
- (void)testSerial {
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t serialQueue = dispatch_queue_create("com.sjpsega", DISPATCH_QUEUE_SERIAL);
    
    __block int count = 0;
    dispatch_group_async(group, serialQueue, ^{
        NSLog(@"1");
        count++;
    });
    dispatch_group_async(group, serialQueue, ^{
        NSLog(@"2");
        count++;
    });
    dispatch_group_async(group, serialQueue, ^{
        NSLog(@"3");
        count++;
    });
    dispatch_group_async(group, serialQueue, ^{
        NSLog(@"4");
        count++;
    });
    dispatch_group_async(group, serialQueue, ^{
        NSLog(@"5");
        count++;
    });
    expect(count).will.equal(5);
}

@end
