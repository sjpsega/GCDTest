//
//  SchoolWithSafe.m
//  GCDTest
//
//  Created by sjpsega on 15/8/30.
//  Copyright (c) 2015年 sjpsega. All rights reserved.
//

#import "SchoolWithSafe.h"

@interface SchoolWithSafe()
@property (readwrite ,nonatomic)NSMutableArray *students;
@end

@implementation SchoolWithSafe

- (instancetype) init{
    self = [super init];
    if(self){
        _students = [@[] mutableCopy];
    }
    return self;
}

- (void)addStudents:(Student *)student{
    @synchronized(_students){
        [_students addObject:student];
        NSLog(@"add ... :%i",[_students count]);
    }
}

- (NSArray *)students{
    @synchronized(_students){
        NSLog(@"get:%i",[_students count]);
        return [_students copy];
    }
}
@end
