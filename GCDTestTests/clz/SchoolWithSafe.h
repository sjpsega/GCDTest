//
//  SchoolWithSafe.h
//  GCDTest
//
//  Created by sjpsega on 15/8/30.
//  Copyright (c) 2015年 sjpsega. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"

@interface SchoolWithSafe : NSObject
- (void)addStudents:(Student *)student;
- (NSArray *)students;
@end
