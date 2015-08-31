//
//  SchoolWithAdvSafe.m
//  GCDTest
//
//  Created by sjpsega on 15/8/30.
//  Copyright (c) 2015年 sjpsega. All rights reserved.
//

#import "SchoolWithAdvSafe.h"

@interface SchoolWithAdvSafe()
@property (readwrite ,nonatomic)NSMutableArray *students;
@property (strong,nonatomic) dispatch_queue_t concurrentQueue;
@end

@implementation SchoolWithAdvSafe

- (instancetype) init{
    self = [super init];
    if(self){
        _students = [@[] mutableCopy];
        _concurrentQueue = dispatch_queue_create("com.sjpsega", DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

- (void)addStudents:(Student *)student{
    dispatch_barrier_async(_concurrentQueue, ^{
        [_students addObject:student];
        NSLog(@"add ... :%i",[_students count]);
    });
}

- (NSArray *)students{
    __block NSArray *copyObj;
    dispatch_sync(_concurrentQueue, ^{
        NSLog(@"get:%i",[_students count]);
        copyObj =  [_students copy];
    });
    return copyObj;
}
@end

