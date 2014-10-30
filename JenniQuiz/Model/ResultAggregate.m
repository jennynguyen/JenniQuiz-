//
//  ResultAggregate.m
//  JenniQuiz
//
//  Created by Jennifer Nguyen on 24/10/2014.
//  Copyright (c) 2014 Jennifer Nguyen. All rights reserved.
//


#import "ResultAggregate.h"

@implementation ResultAggregate

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.date = [aDecoder decodeObjectForKey:@"date"];
    self.percent = [aDecoder decodeFloatForKey:@"percent"];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.date forKey:@"date"];
    [encoder encodeFloat:self.percent forKey:@"percent"];
}

@end
