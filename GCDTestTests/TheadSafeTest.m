//
//  TheadSafeTest.m
//  GCDTest
//
//  Created by sjpsega on 15/8/30.
//  Copyright (c) 2015年 sjpsega. All rights reserved.
//

#import "GCDTestCase.h"
#import "School.h"
#import "Student.h"
#import "SchoolWithSafe.h"
#import "SchoolWithAdvSafe.h"

@interface TheadSafeTest : GCDTestCase

@end

@implementation TheadSafeTest{
    School *_school;
    SchoolWithSafe *_safeSchool;
    SchoolWithAdvSafe *_advSafeSchool;
}

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _school = [[School alloc] init];
    _safeSchool = [[SchoolWithSafe alloc] init];
    _advSafeSchool = [[SchoolWithAdvSafe alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    _school = nil;
    _safeSchool = nil;
    _advSafeSchool = nil;
    [super tearDown];
}

//测试不符合预期，多线程添加数据，add 的时候，student count 数量有跳跃
- (void)testTheadSafe1 {
    __block int count = 0;
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.sjpsega", DISPATCH_QUEUE_CONCURRENT);
    for (int i = 0; i < 10; i++) {
        dispatch_async(concurrentQueue, ^{
            [_school addStudents:[[Student alloc] initWithName:@"a"]];
            [_school students];
            count++;
        });
    }
    expect(count).will.equal(10);
}

- (void)testTheadSafe2 {
    __block int count = 0;
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.sjpsega", DISPATCH_QUEUE_CONCURRENT);
    for (int i = 0; i < 10; i++) {
        dispatch_async(concurrentQueue, ^{
            [_safeSchool addStudents:[[Student alloc] initWithName:@"a"]];
            [_safeSchool students];
            count++;
        });
    }
    expect(count).will.equal(10);
}

- (void)testTheadSafe3 {
    __block int count = 0;
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.sjpsega", DISPATCH_QUEUE_CONCURRENT);
    for (int i = 0; i < 10; i++) {
        dispatch_async(concurrentQueue, ^{
            [_advSafeSchool addStudents:[[Student alloc] initWithName:@"a"]];
            [_advSafeSchool students];
            count++;
        });
    }
    expect(count).will.equal(10);
}
@end
