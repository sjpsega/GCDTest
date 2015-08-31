//
//  Student.m
//  GCDTest
//
//  Created by sjpsega on 15/8/30.
//  Copyright (c) 2015年 sjpsega. All rights reserved.
//

#import "Student.h"

@implementation Student
- (instancetype) initWithName:(NSString *)name{
    self = [super init];
    if(self){
        _name = name;
    }
    return self;
}
@end
