//
//  ResultAggregate.h
//  JenniQuiz
//
//  Created by Jennifer Nguyen on 24/10/2014.
//  Copyright (c) 2014 Jennifer Nguyen. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface ResultAggregate : NSObject <NSCoding>

@property (nonatomic, strong) NSDate* date;

@property (nonatomic, assign) CGFloat percent;

@end
