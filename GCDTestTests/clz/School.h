//
//  School.h
//  GCDTest
//
//  Created by sjpsega on 15/8/30.
//  Copyright (c) 2015年 sjpsega. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"
@interface School : NSObject
- (void)addStudents:(Student *)student;
- (NSArray *)students;
@end
