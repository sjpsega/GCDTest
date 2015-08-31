//
//  Student.h
//  GCDTest
//
//  Created by sjpsega on 15/8/30.
//  Copyright (c) 2015年 sjpsega. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject
@property (copy ,nonatomic)NSString *name;

- (instancetype) initWithName:(NSString *)name;
@end
