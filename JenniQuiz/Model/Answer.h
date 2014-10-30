//
//  Answer.h
//  JenniQuiz
//
//  Created by Jennifer Nguyen on 24/10/2014.
//  Copyright (c) 2014 Jennifer Nguyen. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface Answer : NSObject

@property (nonatomic, strong) NSString* text;

@property (nonatomic, strong) NSString* image;

@property (nonatomic, assign) BOOL correct;

@property (nonatomic, assign) BOOL chosen;

-(id)initWithDictionary:(NSDictionary*)dictionary;
@end
