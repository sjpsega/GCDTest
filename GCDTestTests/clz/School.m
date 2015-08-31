//
//  School.m
//  GCDTest
//
//  Created by sjpsega on 15/8/30.
//  Copyright (c) 2015年 sjpsega. All rights reserved.
//

#import "School.h"

@interface School()
@property (readwrite ,nonatomic)NSMutableArray *students;
@end
@implementation School

- (instancetype) init{
    self = [super init];
    if(self){
        _students = [@[] mutableCopy];
    }
    return self;
}

- (void)addStudents:(Student *)student{
    [_students addObject:student];
    NSLog(@"add ... :%i",[_students count]);
}

- (NSArray *)students{
    NSLog(@"get:%i",[_students count]);
    return [_students copy];
}
@end
