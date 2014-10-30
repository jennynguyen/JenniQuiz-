//
//  Topic.h
//  JenniQuiz
//
//  Created by Jennifer Nguyen on 24/10/2014.
//  Copyright (c) 2014 Jennifer Nguyen. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface Topic : NSObject

@property (nonatomic, strong) NSString* title;

@property (nonatomic, strong) UIImage* image;

@property (nonatomic, strong) NSArray* questionJSONObjects;

@end
