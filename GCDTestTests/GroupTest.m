//
//  GroupTest.m
//  GCDTest
//
//  Created by sjpsega on 15/8/27.
//  Copyright (c) 2015年 sjpsega. All rights reserved.
//

#import "GCDTestCase.h"

@interface GroupTest : GCDTestCase

@end

@implementation GroupTest

//测试 group 功能，等待一个 group 任务全部完成，打印 done，不符合期望。
//after 相关处理在 done 之后执行
- (void)testGCDWithGroup{
    __block int count = 0;
    __block BOOL isDone = NO;
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"CGD 1 .");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSLog(@"CGD 1 after.");
            count++;
        });
    });
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"CGD 2 ..");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSLog(@"CGD 2 after..");
            count++;
        });
    });
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"CGD 3 ...");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSLog(@"CGD 3 after...");
            count++;
        });
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"done !!!");
        isDone = YES;
        expect(count).to.equal(3);
    });
    expect(isDone).will.beTruthy();
}

//测试 group 功能，等待一个 group 任务全部完成，打印 done，符合期望!
//使用dispatch_group_enter、dispatch_group_leave，保证 group 任务全部完成。
- (void)testGCDWithGroupEnterAndLeave{
    __block int count = 0;
    __block BOOL isDone = NO;
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"CGD 1 .");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSLog(@"CGD 1 after.");
            dispatch_group_leave(group);
            count++;
        });
    });
    dispatch_group_enter(group);
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"CGD 2 ..");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSLog(@"CGD 2 after..");
            dispatch_group_leave(group);
            count++;
        });
    });
    dispatch_group_enter(group);
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"CGD 3 ...");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSLog(@"CGD 3 after...");
            dispatch_group_leave(group);
            count++;
        });
    });

    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"done !!!");
        isDone = YES;
        expect(count).to.equal(3);
    });
    expect(isDone).will.beTruthy();
}

@end
