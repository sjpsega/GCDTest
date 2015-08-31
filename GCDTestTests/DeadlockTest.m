//
//  DeadlockTest.m
//  GCDTest
//
//  Created by sjpsega on 15/8/29.
//  Copyright (c) 2015年 sjpsega. All rights reserved.
//

#import "GCDTestCase.h"

@interface DeadlockTest : GCDTestCase

@end

//不能在串行（主线程是一种串行队列）线程队列的任务中，再使用 dispatch_sync 添加任务到同一个串行队列中，否则必定发生死锁。
//注：测试代码默认执行在主线程上(串行队列)
@implementation DeadlockTest

- (void)testA{
    __block int count = 0;
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"11");
        count++;
        dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSLog(@"22");
            count++;
        });
    });
    expect(count).will.equal(2);
}

//死锁
- (void)testB{
    __block int count = 0;
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"11");
        count++;
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"22");
            count++;
        });
    });
    expect(count).will.equal(2);
}

//死锁
- (void)testC{
    __block int count = 0;
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"11");
        count++;
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"22");
            count++;
        });
    });
    expect(count).will.equal(2);
}


//死锁
- (void)testD{
    __block int count = 0;
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"11");
        count++;
        dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSLog(@"22");
            count++;
        });
    });
    expect(count).will.equal(2);
}

- (void)testE{
    __block int count = 0;
    dispatch_queue_t serialQueue = dispatch_queue_create("com.sjpsega", DISPATCH_QUEUE_SERIAL);
    dispatch_sync(serialQueue, ^{
        NSLog(@"11");
        count++;
        dispatch_queue_t serialQueue2 = dispatch_queue_create("com.sjpsega", DISPATCH_QUEUE_SERIAL);
        dispatch_sync(serialQueue2, ^{
            NSLog(@"22");
            count++;
        });
    });
    expect(count).will.equal(2);
}
@end
